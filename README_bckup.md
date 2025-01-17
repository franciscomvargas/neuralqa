# Windows Instalation
## Create Project Folder 
Model Folder:
> %UserProfile%\Desota_Models\NeuralQA

Go to CMD (command prompt)
> WIN + "R" 
> Write "cmd" 

Copy-Paste the following comands 
```
mkdir %UserProfile%\Desota_Models\NeuralQA
cd %UserProfile%\Desota\Desota_Models\NeuralQA
```

## Test if conda is instaled
Copy-Paste the following comands 
```
%UserProfile%\miniconda3\condabin\conda --version
```
if response is:
> 'conda' is not recognized as an internal or external command,operable program or batch 

then is required conda instalation !

### Conda Instalation
Copy-Paste the following comand
```
powershell -command "Invoke-WebRequest -Uri https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -OutFile ~\miniconda.exe && start /B /WAIT %UserProfile%\miniconda.exe /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=%UserProfile%\miniconda3 && del %UserProfile%\miniconda.exe 
```


## Install Neuralqa model
Copy-Paste the following comands 
```
cd %UserProfile%\Desota\Desota_Models\NeuralQA
%UserProfile%\miniconda3\condabin\conda create --prefix ./env python=3.11 -y
%UserProfile%\miniconda3\condabin\conda activate ./env 
pip install -q -r git+https://github.com/franciscomvargas/neuralqa.git@master#egg=neuralqa
echo DONE (:

```

## Run Model
### Start API server
> Re-Open the command prompt (CMD)

Copy-Paste the following comands
```
cd %UserProfile%\Desota\Desota_Models\NeuralQA
%UserProfile%\miniconda3\condabin\conda activate ./env 
neuralqa ui --port 8888

```
### Open Server in Browser
Search in the browser
```
http://127.0.0.1:8888/
```




# Linux Instalation
## Create Project Folder 
Model Folder:
> ~/Desota/Desota_Models/NeuralQA

Go to CMD (command prompt)
> CTRL + ALT + "T" 

Copy-Paste the following comands 
```
mkdir ~\Desota_Models\NeuralQA
cd ~\Desota_Models\NeuralQA
```

## Test if conda is instaled

Copy-Paste the following comands 
```
conda --help
```
if response is:
> 'conda' is not recognized as an internal or external command,operable program or batch 

then is required conda instalation !

### Conda Instalation
Update/Upgrade System
```
sudo apt update && sudo apt upgrade
```

Copy-Paste the following comand
```
pip install -q -r -U pip && pip install -q -r conda
```


## Install Neuralqa model
Copy-Paste the following comands 
```
conda create --prefix ./env -y
conda activate ./env 
conda install -y pip 
pip install -q -r git+https://github.com/franciscomvargas/neuralqa.git@master#egg=neuralqa
echo DONE (:

```

## Run Model
### Start API server
> Re-Open the command prompt (CMD)

Copy-Paste the following comands
```
cd ~\Desota_Models\NeuralQA
conda activate ./env 
neuralqa ui --port 8888

```
### Open Server in Browser
Search in the browser
```
http://127.0.0.1:8888/
```


# Credits / Lincense
## Citation
```
@article{dibia2020neuralqa,
    title={NeuralQA: A Usable Library for Question Answering (Contextual Query Expansion + BERT) on Large Datasets},
    author={Victor Dibia},
    year={2020},
    journal={Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing (EMNLP-IJCNLP): System Demonstrations}
}
```

## Licence
[MIT](https://github.com/victordibia/neuralqa/blob/master/LICENSE)
