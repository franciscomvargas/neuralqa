@ECHO OFF
:mainloop

:: Get Model path
:: %~dp0 = C:\users\[user]\Desota\Desota_Models\NeuralQA\neuralqa\executables\Windows
for %%a in ("%~dp0..\..") do set "model_path=%%~fa"

:: Run NeuralQA Service
call cd %model_path%
call %model_path%\env\python %model_path%\cli.py ui --host 127.0.0.1 --port 8888

GOTO mainloop