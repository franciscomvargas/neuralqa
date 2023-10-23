# **WINDOWS**

## **Project comands**

### SETUP CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.setup.bat /startmodel
```


### START CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.start.bat
```


### STATUS CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.status.bat
```


### STOP CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.stop.bat
```


### Uninstall CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.uninstall.bat /Q
```


### INSTALL SERVICE CMD:
```
%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows\neuralqa.nssm.bat
```

<!-- ------------- -->

## **Service commands**

**SERVICE NAME**: `neuralqa_service`

### Start Service:
```
%UserProfile%\Desota\Portables\nssm\win64\nssm.exe start neuralqa_service
```


### Stop Service

```
%UserProfile%\Desota\Portables\nssm\win64\nssm.exe stop neuralqa_service
```


### Status Service:
```
%UserProfile%\Desota\Portables\nssm\win64\nssm.exe status neuralqa_service
```


### Remove Service:
```
%UserProfile%\Desota\Portables\nssm\win64\nssm.exe remove neuralqa_service
```


<!-- ---------------------------------------------------------------------- -->


# **LINUX**

## **Project comands**

### REQUIRED APT INSTALLS
apt install openssl

### SETUP:
```
sudo /bin/bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.setup.bash -s
```

### UNINSTALL:
```
sudo /bin/bash ~/Desota/Desota_Models/NeuralQA/neuralqa/executables/Linux/neuralqa.uninstall.bash
```