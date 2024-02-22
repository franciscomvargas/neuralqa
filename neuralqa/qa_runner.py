import os, sys
import time, re, json, shutil
import requests, subprocess
import yaml
from yaml.loader import SafeLoader

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-mr", "--model_req", 
                    help="DeSOTA Request as yaml file path",
                    type=str)
parser.add_argument("-mru", "--model_res_url",
                    help="DeSOTA API Result URL. Recognize path instead of url for desota tests", # check how is atribuited the test_mode variable in main function
                    type=str)

DEBUG = False

# DeSOTA Funcs [START]
#   > Import DeSOTA Scripts
from desota import detools
#   > Grab DeSOTA Paths
USER_SYS = detools.get_platform()
APP_PATH = os.path.dirname(os.path.realpath(__file__))
#   > USER_PATH
if USER_SYS == "win":
    path_split = str(APP_PATH).split("\\")
    desota_idx = [ps.lower() for ps in path_split].index("desota")
    USER=path_split[desota_idx-1]
    USER_PATH = "\\".join(path_split[:desota_idx])
elif USER_SYS == "lin":
    path_split = str(APP_PATH).split("/")
    desota_idx = [ps.lower() for ps in path_split].index("desota")
    USER=path_split[desota_idx-1]
    USER_PATH = "/".join(path_split[:desota_idx])
DESOTA_ROOT_PATH = os.path.join(USER_PATH, "Desota")
# DeSOTA Funcs [END]

def main(args):
    '''
    return codes:
    0 = SUCESS
    1 = INPUT ERROR
    2 = OUTPUT ERROR
    3 = API RESPONSE ERROR
    9 = REINSTALL MODEL (critical fail)
    '''
   # Time when grabed
    _report_start_time = time.time()
    start_time = int(_report_start_time)

    #---INPUT---# TODO (PRO ARGS)
    _reader = 'distilbert'  # | 'bert'
    _quenstion_expansionterms = [] # list of lists - foreach question
    #---INPUT---#

    if _reader == 'distilbert':
        _model = "twmkn9/distilbert-base-uncased-squad2"
    elif _reader == 'bert':
        _model = "deepset/bert-base-cased-squad2"


    # DeSOTA Model Request
    model_request_dict = detools.get_model_req(args.model_req)
    
    # API Response URL
    result_id = args.model_res_url
    
    # TARGET File Path
    dir_path = os.path.dirname(os.path.realpath(__file__))
    out_filepath = os.path.join(dir_path, f"url-to-text{start_time}.txt")
    out_urls = detools.get_url_from_str(result_id)
    if len(out_urls)==0:
        test_mode = True
        report_path = result_id
    else:
        test_mode = False
        send_task_url = out_urls[0]

    # Get url from request
    questions, contexts = detools.get_request_qa(model_request_dict)
    print(f"[ DEBUG ] -> NeuralQA req: {json.dumps(model_request_dict, indent=4)}")
    print(f"[ DEBUG ] -> NeuralQA questions: {questions}")
    print(f"[ DEBUG ] -> NeuralQA contexts: {contexts}")
    _context = "\n".join(contexts)
    # Input Error - ret 1
    if not (_context and questions):
        print(f"[ ERROR ] -> NeuralQA Request Failed:\nContext: {_context}\nQuestions: {questions}")
        exit(1)

    qa_res = []
    if isinstance(questions, str):
        questions = [questions]
    if not isinstance(questions, list):
        print(f"[ ERROR ] -> NeuralQA Request Failed:\nQuestion could not be parsed into list!\nQuestion: {questions}")
        exit(1)
    for count, question in enumerate(questions):
        # NeuralQA Request Preparation
        payload = {
            "max_documents": 5,
            "context": _context,
            "query": question, # type - str
            "fragment_size": 350,
            "reader": _model,
            "retriever": "none",
            "tokenstride": 0,
            "relsnip": True,
            "expansionterms": _quenstion_expansionterms[count] if _quenstion_expansionterms != [] else []
        }
        headers = {
            "Accept": "application/json, text/javascript, */*; q=0.01",
            "Connection": "keep-alive",
            "Content-Type": "application/json; charset=UTF-8"
        }
        # NeuralQA Request
        print(f"[ INFO ] -> NeuralQA Request Payload:\n{json.dumps(payload, indent=2)}")
        neuralqa_url = "http://127.0.0.1:8888/api/answers"

        neuralqa_response = requests.request("POST", neuralqa_url, json=payload, headers=headers)
        if neuralqa_response.status_code != 200:
            print(f"[ ERROR ] -> NeuralQA Request Failed (Info):\n\tResponse Code = {neuralqa_response.status_code}")
            exit(2)

        neuralqa_json_res = neuralqa_response.json()

        if 'error' in neuralqa_json_res:
            print(f"[ ERROR ] -> NeuralQA Response Error (Info):{json.dumps(neuralqa_json_res, indent=2)}")
            exit(2)

        qa_res.append(neuralqa_json_res)
    

    print(f"[ INFO ] -> NeuralQA Response:{json.dumps(qa_res, indent=2)}")
    
    # DeSOTA API Response Preparation
    with open(out_filepath, 'w', encoding="utf-8") as fw:
        _out_format = []
        for _qa_arg in qa_res:
            if "answers" in _qa_arg:
                _out_format.append(json.dumps(_qa_arg["answers"]))
            else:
                _out_format.append(json.dumps({"error": f"Model NeuralQA couldn't find any answers for questions `{_qa_arg['qestion']}`"}))
        fw.writelines(_out_format)
    
    
    if test_mode:
        if not report_path.endswith(".json"):
            report_path += ".json"
        with open(report_path, "w") as rw:
            json.dump(
                {
                    "Model Result Path": out_filepath,
                    "Processing Time": time.time() - _report_start_time
                },
                rw,
                indent=2
            )
        detools.user_chown(report_path)
        detools.user_chown(out_filepath)
        print(f"Path to report:\n\t{report_path}")
    else:
        files = []
        with open(out_filepath, 'rb') as fr:
            files.append(('upload[]', fr))
            # DeSOTA API Response Post
            send_task = requests.post(url = send_task_url, files=files)
            print(f"[ INFO ] -> DeSOTA API Upload Res:{json.dumps(send_task.json(), indent=2)}")
        # Delete temporary file
        os.remove(out_filepath)

        if send_task.status_code != 200:
            print(f"[ ERROR ] -> Descraper Post Failed (Info):\nfiles: {files}\nResponse Code: {send_task.status_code}")
            exit(3)
    
    print("TASK OK!")
    exit(0)


if __name__ == "__main__":
    args = parser.parse_args()
    if not args.model_req or not args.model_res_url:
        raise EnvironmentError()
    main(args)