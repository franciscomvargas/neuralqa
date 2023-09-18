import os
import time
import requests
import yaml
from yaml.loader import SafeLoader
import json

from runner_utils.utils import *

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-mr", "--model_req", 
                    help="DeSOTA Request as yaml file path",
                    type=str)
parser.add_argument("-mru", "--model_res_url",
                    help="DeSOTA API Rsponse URL for model results",
                    type=str)

# DeSOTA Funcs
def get_model_req(req_path):
    '''
    {
        "task_type": None,      # TASK VARS
        "task_model": None,
        "task_dep": None,
        "task_args": None,
        "task_id": None,
        "filename": None,       # FILE VARS
        "file_url": None,
        "text_prompt": None     # TXT VAR
    }
    '''
    if not os.path.isfile(req_path):
        exit(1)
    with open(req_path) as f:
        return yaml.load(f, Loader=SafeLoader)

def main(args):
    '''
    return codes:
    0 = SUCESS
    1 = INPUT ERROR
    2 = OUTPUT ERROR
    3 = API RESPONSE ERROR
    9 = REINSTALL MODEL (critical fail)
    '''
    #---INPUT---# TODO (PRO ARGS)
    _reader = 'distilbert'  # | 'bert'
    _quenstion_expansionterms = [] # list of lists - foreach question
    #---INPUT---#

    if _reader == 'distilbert':
        _model = "twmkn9/distilbert-base-uncased-squad2"
    elif _reader == 'bert':
        _model = "deepset/bert-base-cased-squad2"


    # Time when grabed
    start_time = int(time.time())

    # DeSOTA Model Request
    model_request_dict = get_model_req(args.model_req)
    
    # API Response URL
    send_task_url = args.model_res_url
    
    # TMP File Path
    dir_path = os.path.dirname(os.path.realpath(__file__))
    out_filepath = os.path.join(dir_path, f"question-answer{start_time}.txt")
    
    # Get url from request
    _context, _questions = get_request_qa(model_request_dict)
                
    # Input Error - ret 1
    if not (_context and _questions):
        print(f"[ ERROR ] -> NeuralQA Request Failed: No HTML | ULR found")
        exit(1)

    qa_res = []
    for count, question in enumerate(_questions):
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
    
    # # DeSOTA API Response Preparation
    # with open(out_filepath, 'w', encoding="utf-8") as fw:
    #     fw.write(descraper_res["html_text"] if "html_text" in descraper_res else json.dumps(descraper_res))
    # files = []
    # with open(out_filepath, 'rb') as fr:
    #     files.append(('upload[]', fr))
    #     # DeSOTA API Response Post
    #     send_task = requests.post(url = send_task_url, files=files)
    #     print(f"[ INFO ] -> DeSOTA API Upload:{json.dumps(send_task.json(), indent=2)}")
    # # Delete temporary file
    # os.remove(out_filepath)

    # if send_task.status_code != 200:
    #     print(f"[ ERROR ] -> Descraper Post Failed (Info):\nfiles: {files}\nResponse Code: {send_task.status_code}")
    #     exit(3)
    
    print("TASK OK!")
    exit(0)


if __name__ == "__main__":
    args = parser.parse_args()
    if not args.model_req or not args.model_res_url:
        raise EnvironmentError()
    main(args)