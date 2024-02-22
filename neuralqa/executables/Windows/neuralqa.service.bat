@ECHO OFF
:: Get Model path
:: %~dp0 = C:\users\[user]\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows
for %%a in ("%~dp0..\..\..") do set "model_install_path=%%~fa"
for %%a in ("%~dp0..\..") do set "model_path=%%~fa"
:: Run NeuralQA Service
call cd %model_path%
:: Delete Service Log on-start
break>%model_path%\service.log
:: Make sure every package required is installed
IF EXIST %model_path%\NSSM.flag GOTO mainloop
type nul > %model_path%\NSSM.flag
call %model_path%\env\python -m pip install -r %model_install_path%\requirements.txt
:mainloop
:: Start Model Server
call %model_path%\env\python %model_path%\cli.py ui --host 127.0.0.1 --port 8888
GOTO mainloop