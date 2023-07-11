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
cd %UserProfile%\Desota_Models\NeuralQA
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
Copy-Paste the following comand
```
powershell -command "Invoke-WebRequest -Uri https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe -OutFile ~\miniconda.exe && start /B /WAIT %UserProfile%\miniconda.exe /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=%UserProfile%\miniconda3 && del %UserProfile%\miniconda.exe 
```


## Install Neuralqa model
Copy-Paste the following comands 
```
%UserProfile%\miniconda3\condabin\activate 
conda deactivate 
conda create --prefix ./env python=3.11 -y
conda activate ./env 
conda install -y pip 
pip install -q -r git+https://github.com/franciscomvargas/neuralqa.git@master#egg=neuralqa
echo DONE (:

```




# Linux Instalation
## Create Project Folder 
Model Folder:
> ~\Desota_Models\NeuralQA

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
pip install -q -r -U pip && pip install conda
```


## Install Neuralqa model
Copy-Paste the following comands 
```
conda create --prefix ./env python=3.11 -y
conda activate ./env 
conda install -y pip 
pip install -q -r git+https://github.com/franciscomvargas/neuralqa.git@master#egg=neuralqa
echo DONE (:

```



# Initialize Neuralqa model - Equal for Windows & Linux
Copy-Paste the following comand
```
neuralqa ui --port 8888
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
