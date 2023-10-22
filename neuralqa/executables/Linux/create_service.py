import os
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("-uh", "--user_home", 
    help="Specify User PATH to handle with admin requests",
    type=str)
args = parser.parse_args()

# EDIT BELLOW v
USER_PATH=None
if args.user_home:
    if os.path.isdir(args.user_home):
        USER_PATH = args.user_home
if not USER_PATH:
    USER_PATH = os.path.expanduser('~')

CURR_PATH = os.path.dirname(os.path.realpath(__file__))
TARGET_RUN_FILE = os.path.join(CURR_PATH, "neuralqa.service.bash")
TARGET_SERV_FILE = os.path.join(CURR_PATH, "neuralqa.service")

MODEL_PATH=os.path.join(USER_PATH, "Desota", "Desota_Models", "NeuralQA", "neuralqa")
SERV_DESC="Desota/NeuralQA - A Usable Library for Question Answering on Large Datasets"
SERV_PORT=8888
SERV_RUN_CMD=f"/bin/bash {TARGET_RUN_FILE}"
# EDIT ABOVE ^

# SERVICE RUNNER
TEMPLATE_SERVICE_RUNNER=f'''#!/bin/bash
# GET USER PATH
while true
do
    {MODEL_PATH}/bin/python3 {MODEL_PATH}/cli.py ui --host 127.0.0.1 --port {SERV_PORT}
done
# Inform Crawl Finish
echo Service as Terminated !'''

with open(TARGET_RUN_FILE, "w") as fw:
    fw.write(TEMPLATE_SERVICE_RUNNER)

# SERVICE FILE
TEMPLATE_SERVICE=f'''[Unit]
Description={SERV_DESC}
After=network.target
StartLimitIntervalSec=0
StartLimitBurst=5
StartLimitAction=reboot.

[Service]
Type=simple
Restart=always
RestartSec=2
ExecStart={SERV_RUN_CMD}

[Install]
WantedBy=multi-user.target'''

with open(TARGET_SERV_FILE, "w") as fw:
    fw.write(TEMPLATE_SERVICE)
    
    
USER=USER_PATH.split("/")[-1]
os.system(f"chown -R {USER} {TARGET_RUN_FILE}")
os.system(f"chown -R {USER} {TARGET_SERV_FILE}")
exit(0)
