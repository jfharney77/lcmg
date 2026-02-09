@rem Central config for batch scripts
set "DEFAULT_PROJ_ROOT=%~dp0.."
echo Using project root: %DEFAULT_PROJ_ROOT%

set "P_SERVER_PATH=%DEFAULT_PROJ_ROOT%\src\servers\models\gateway\p_model\app.py"
set "IT_SERVER_PATH=%DEFAULT_PROJ_ROOT%\src\servers\models\gateway\it_model\app.py"

set "P_SERVER_PORT=6001"
set "IT_SERVER_PORT=6002"