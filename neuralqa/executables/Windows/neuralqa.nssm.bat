@ECHO OFF
:: - Model Path
set model_path=%UserProfile%\Desota\Desota_Models\NeuralQA\neuralqa
:: Service VARS - retrieved from https://nssm.cc/usage
set model_name=Desota/NeuralQA
set service_name=neuralqa_service
set model_exe=%model_path%\executables\Windows\neuralqa.service.bat
set exe_path=%model_path%\executables\Windows
set model_exe_args=
set model_desc=
set model_dependencies=
set model_log=%model_path%\service.log
set model_env=



:: -- Edit bellow if you're felling lucky ;) -- https://youtu.be/5NV6Rdv1a3I

:: - Program Installers
set nssm_installer=https://nssm.cc/ci/nssm-2.24-101-g897c7ad.zip

:: - .bat ANSI Colored CLI
set header=
set info=
set sucess=
set fail=
set ansi_end=
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" GOTO set_ansi_colors
if "%version%" == "11.0" GOTO set_ansi_colors
GOTO end_ansi_colors
:set_ansi_colors
for /F %%a in ('echo prompt $E ^| cmd') do (
  set "ESC=%%a"
)
set header=%ESC%[4;95m
set info_h1=%ESC%[93m
set info_h2=%ESC%[33m
set sucess=%ESC%[7;32m
set fail=%ESC%[7;31m
set ansi_end=%ESC%[0m
:end_ansi_colors


:: NSSM - the Non-Sucking Service Manager 
IF EXIST %UserProfile%\Desota\Portables\nssm goto endofnssm
ECHO %info_h2%Installing NSSM...%ansi_end% 
call mkdir %UserProfile%\Desota\Portables\nssm >NUL 2>NUL
call cd %UserProfile%\Desota\Portables\nssm >NUL 2>NUL
call powershell -command "Invoke-WebRequest -Uri %nssm_installer% -OutFile ~\Desota\Portables\nssm.zip" &&  tar -xzvf %UserProfile%\Desota\Portables\nssm.zip -C %UserProfile%\Desota\Portables\nssm --strip-components 1 && del %UserProfile%\Desota\Portables\nssm.zip
:endofnssm

ECHO %info_h2%Creating Service `%service_name%`...%ansi_end% 
:: NSSM - exe path 
IF %PROCESSOR_ARCHITECTURE%==AMD64 set nssm_exe=%UserProfile%\Desota\Portables\nssm\win64\nssm.exe
IF %PROCESSOR_ARCHITECTURE%==x86 set nssm_exe=%UserProfile%\Desota\Portables\nssm\win32\nssm.exe

:: Service Install
call %nssm_exe% install %service_name% %model_exe% %exe_path% >NUL 2>NUL
:: Application tab
:: call %nssm_exe% set %service_name% Application %model_exe%
call %nssm_exe% set %service_name% AppDirectory %exe_path% >NUL 2>NUL
call %nssm_exe% set %service_name% AppParameters server >NUL 2>NUL
:: Details tab
call %nssm_exe% set %service_name% DisplayName Desota/%model_name% >NUL 2>NUL
call %nssm_exe% set %service_name% Description %model_desc% >NUL 2>NUL
call %nssm_exe% set %service_name% Start SERVICE_AUTO_START >NUL 2>NUL
:: Log on tab
call %nssm_exe% set %service_name% ObjectName LocalSystem >NUL 2>NUL
call %nssm_exe% set %service_name% Type SERVICE_WIN32_OWN_PROCESS >NUL 2>NUL
:: Dependencies
call %nssm_exe% set %service_name% DependOnService %model_dependencies% >NUL 2>NUL

:: Process tab
call %nssm_exe% set %service_name% AppPriority NORMAL_PRIORITY_CLASS >NUL 2>NUL
call %nssm_exe% set %service_name% AppNoConsole 0 >NUL 2>NUL
call %nssm_exe% set %service_name% AppAffinity All >NUL 2>NUL
:: Shutdown tab
call %nssm_exe% set %service_name% AppStopMethodSkip 0 >NUL 2>NUL
call %nssm_exe% set %service_name% AppStopMethodConsole 1500 >NUL 2>NUL
call %nssm_exe% set %service_name% AppStopMethodWindow 1500 >NUL 2>NUL
call %nssm_exe% set %service_name% AppStopMethodThreads 1500 >NUL 2>NUL
:: Exit actions tab
call %nssm_exe% set %service_name% AppThrottle 1500 >NUL 2>NUL
call %nssm_exe% set %service_name% AppExit Default Restart >NUL 2>NUL
call %nssm_exe% set %service_name% AppRestartDelay 0 >NUL 2>NUL
:: I/O tab
call %nssm_exe% set %service_name% AppStdout %model_log% >NUL 2>NUL
call %nssm_exe% set %service_name% AppStderr %model_log% >NUL 2>NUL
:: File rotation tab
call %nssm_exe% set %service_name% AppStdoutCreationDisposition 4 >NUL 2>NUL
call %nssm_exe% set %service_name% AppStderrCreationDisposition 4 >NUL 2>NUL
call %nssm_exe% set %service_name% AppRotateFiles 1 >NUL 2>NUL
call %nssm_exe% set %service_name% AppRotateOnline 0 >NUL 2>NUL
call %nssm_exe% set %service_name% AppRotateSeconds 86400 >NUL 2>NUL
call %nssm_exe% set %service_name% AppRotateBytes 1048576 >NUL 2>NUL
:: Environment tab
call %nssm_exe% set %service_name% AppEnvironmentExtra %model_env% >NUL 2>NUL

exit