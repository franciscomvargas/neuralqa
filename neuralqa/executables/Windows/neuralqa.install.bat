@ECHO OFF
:: Instalation VARS
:: - Model GIT
set model_git=https://github.com/franciscomvargas/neuralqa.git
set model_git_branch=master
set model_name=Desota/NeuralQA
:: - Model Path
set install_model_path=%UserProfile%\Desota\Desota_Models\NeuralQA
set model_path_in=%install_model_path%\neuralqa
:: - Service Name
set model_service_name=neuralqa_service
:: - Model Execs
set model_uninstall=%model_path_in%\executables\Windows\neuralqa.uninstall.bat
set model_service_install=%model_path_in%\executables\Windows\neuralqa.nssm.bat
set model_start=%model_path_in%\executables\Windows\neuralqa.start.bat



:: -- Edit bellow if you're felling lucky ;) -- https://youtu.be/5NV6Rdv1a3I

:: Program Installers
set python64=https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe
set python32=https://www.python.org/ftp/python/3.11.4/python-3.11.4.exe
set git64_portable=https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/PortableGit-2.41.0.3-64-bit.7z.exe
set git32_portable=https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/PortableGit-2.41.0.3-32-bit.7z.exe
set miniconda64=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
set miniconda32=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86.exe

:: IPUT ARGS - /reinstall="overwrite model + remove service" ; /startmodel="Start Model Service"
SET arg1=/reinstall
SET arg2=/startrunner

:: .BAT ANSI Colored CLI
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

ECHO %header%Welcome to DeRunner Installer!%ansi_end%

:: Re-instalation Check
ECHO %info_h1%Step 1/7 - Check Re-Instalation%ansi_end%
IF NOT EXIST %model_path_in% (
    ECHO %sucess%New install%ansi_end%
    GOTO noreinstallrequired
)
ECHO %info_h2%Re-Instalation required - Start Uninstall...%ansi_end%
IF "%1" EQU "" GOTO noreinstallargs
IF %1 EQU %arg1% (
    GOTO reinstall
)
IF %2 EQU %arg1% (
    GOTO reinstall
)
:noreinstallargs
call %model_uninstall%
GOTO endofreinstall
:reinstall
call %model_uninstall% /Q
:endofreinstall
IF EXIST %model_path% (
    GOTO EOF_IN
) ELSE (
    ECHO %sucess%DeRunner Uninstall Sucess%ansi_end%
)
:noreinstallrequired

:: Create Project Folder
ECHO %info_h1%Step 2/7 - Create Project Folder%ansi_end%
mkdir %install_model_path% >NUL 2>NUL
call cd %install_model_path% >NUL 2>NUL

:: Install Python if Required
ECHO %info_h1%Step 3/7 - Install Python if required%ansi_end%
python --version >NUL 2>NUL
IF errorlevel 1 (
    python3 --version >NUL 2>NUL
    IF errorlevel 1 (
        IF NOT EXIST %UserProfile%\Desota\Portables\python3 (
            GOTO installpython
        )
    )
)
goto skipinstallpython
:installpython
call mkdir %UserProfile%\Desota\Portables >NUL 2>NUL
IF %PROCESSOR_ARCHITECTURE%==AMD64 powershell -command "Invoke-WebRequest -Uri %python64% -OutFile ~\python3_installer.exe" && start /B /WAIT %UserProfile%\python3_installer.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%UserProfile%\Desota\Portables\python3 && del %UserProfile%\python3_installer.exe && goto skipinstallpython
IF %PROCESSOR_ARCHITECTURE%==x86 powershell -command "Invoke-WebRequest -Uri %python32% -OutFile ~\python3_installer.exe" && start /B /WAIT %UserProfile%\python3_installer.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0 TargetDir=%UserProfile%\Desota\Portables\python3 && del %UserProfile%\python3_installer.exe && goto skipinstallpython
:skipinstallpython

:: GIT MODEL CLONE
ECHO %info_h1%Step 4/7 - Get Project from GitHub%ansi_end%
git --version >NUL 2>NUL
IF NOT errorlevel 1 (
    ::  Clone Descraper Repository
    ECHO %info_h2%Cloning Project Repository...%ansi_end%
    call git clone --branch %model_git_branch% %model_git% . >NUL 2>NUL
    call copy %model_path%\Assets\config_template.yaml %model_path%\config.yaml >NUL 2>NUL
    GOTO endgitclonemodel
)
:: PORTABLE GIT MODEL CLONE
:: Install Portable Git
call mkdir %UserProfile%\Desota\Portables >NUL 2>NUL
IF EXIST %UserProfile%\Desota\Portables\PortableGit GOTO clonerep
:: Install Portable Git
%info_h2%Downloading Portable Git...%ansi_end%
IF %PROCESSOR_ARCHITECTURE%==AMD64 powershell -command "Invoke-WebRequest -Uri %git64_portable% -OutFile ~\Desota\Portables\git_installer.exe" && start /B /WAIT %UserProfile%\Desota\Portables\git_installer.exe -o"%UserProfile%\Desota\Portables\PortableGit" -y && del %UserProfile%\Desota\Portables\git_installer.exe && goto clonerep
IF %PROCESSOR_ARCHITECTURE%==x86 powershell -command "Invoke-WebRequest -Uri %git32_portable% -OutFile ~\Desota\Portables\git_installer.exe" && start /B /WAIT %UserProfile%\Desota\Portables\git_installer.exe -o"%UserProfile%\Desota\Portables\PortableGit" && del %UserProfile%\Desota\Portables\git_installer.exe && goto clonerep
:clonerep
ECHO %info_h2%Cloning Project Repository...%ansi_end%
call %UserProfile%\Desota\Portables\PortableGit\bin\git.exe clone --branch %model_git_branch% %model_git% . >NUL 2>NUL
call copy %model_path%\Assets\config_template.yaml %model_path%\config.yaml >NUL 2>NUL
:endgitclonemodel


:: Install Conda if Required
ECHO %info_h1%Step 5/7 - Create Virtual Environment for Project%ansi_end%
call mkdir %UserProfile%\Desota\Portables >NUL 2>NUL
IF NOT EXIST %UserProfile%\Desota\Portables\miniconda3\condabin\conda.bat goto installminiconda
goto skipinstallminiconda
:installminiconda
ECHO %info_h2%Downloading Portable MiniConda...%ansi_end%
IF %PROCESSOR_ARCHITECTURE%==AMD64 powershell -command "Invoke-WebRequest -Uri %miniconda64% -OutFile %UserProfile%\miniconda_installer.exe" && start /B /WAIT %UserProfile%\miniconda_installer.exe /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=%UserProfile%\Desota\Portables\miniconda3 && del %UserProfile%\miniconda_installer.exe && goto skipinstallminiconda
IF %PROCESSOR_ARCHITECTURE%==x86 powershell -command "Invoke-WebRequest -Uri %miniconda32% -OutFile %UserProfile%\miniconda_installer.exe" && start /B /WAIT %UserProfile%\miniconda_installer.exe /InstallationType=JustMe /AddToPath=0 /RegisterPython=0 /S /D=%UserProfile%\Desota\Portables\miniconda3 && del %UserProfile%\miniconda_installer.exe && && goto skipinstallminiconda
:skipinstallminiconda


:: Create/Activate Conda Virtual Environment
ECHO %info_h2%Creating MiniConda Environment...%ansi_end% 
call %UserProfile%\Desota\Portables\miniconda3\condabin\conda create --prefix ./env python=3.11 -y >NUL 2>NUL
call %UserProfile%\Desota\Portables\miniconda3\condabin\conda activate ./env >NUL 2>NUL

:: Install required Libraries
ECHO %info_h1%Step 6/7 - Install Project Packages%ansi_end%
call pip install -r requirements.txt >NUL 2>NUL


:: Install Service - NSSM  - the Non-Sucking Service Manager
ECHO %info_h1%Step 7/7 - Create Project Service with NSSM%ansi_end%
start /B /WAIT %model_service_install%



:: Start Runner Service?
IF "%1" EQU "" GOTO EOF_IN
IF %1 EQU %arg2% (
    GOTO startrunner
)
IF "%2" EQU "" GOTO EOF_IN
IF %2 EQU %arg2% (
    GOTO startrunner
)
GOTO EOF_IN

:startmodel
start /B /WAIT %model_start%
ECHO %sucess%%model_name% Installed & %model_service_name% - Started!%ansi_end%
exit

:EOF_IN
ECHO %sucess%%model_name% Installed!%ansi_end%
PAUSE