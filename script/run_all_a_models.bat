@echo off
call "%~dp0config.bat"

set SRC=%DEFAULT_PROJ_ROOT%/src
set PYTHONPATH=%DEFAULT_PROJ_ROOT%\%SRC%

echo Startiong a models...
wt new-tab powershell -Command "python %P_SERVER_PATH% %P_SERVER_PORT%" ; ^
   new-tab powershell -Command "python %IT_SERVER_PATH% %IT_SERVER_PORT%"