@echo off
setlocal

rem Load shared config (path relative to this script)
call "%~dp0config.bat"
if errorlevel 1 (
    echo Failed to load config.bat
    exit /b 1
)


rem ---
rem 1) set PROJ_ROOT from first argument or default
rem ---
if "%~1"=="" (
    set "PROJ_ROOT=%DEFAULT_PROJ_ROOT%"
) else (
    set "PROJ_ROOT=%~1" 
)
echo Using project root: "%PROJ_ROOT%"

rem === Configuration section ===


set "NEED_UV_INIT=0"

rem === check to see if uv.lock exists ===
if not exist "%PROJ_ROOT%\uv.lock" (
    echo uv.lock not found in project root "%PROJ_ROOT%".
    set "NEED_UV_INIT=1"
)

rem === check to see if pyproject.toml exists ===
if not exist "%PROJ_ROOT%\pyproject.toml" (
    echo pyproject.toml not found in project root "%PROJ_ROOT%".
    set "NEED_UV_INIT=1"
)

rem === change iunto the PROJ_ROOT directory ===
cd /d "%PROJ_ROOT%"
if errorlevel 1 (
    echo Failed to change directory to "%PROJ_ROOT%".
    exit /b 1
)

rem === Run uv sync to create/update the virtual environment ===
if "%NEED_UV_INIT%"=="0" (
    echo Generating virtual environment using uv...
    uv sync
    if errorlevel 1 (
        echo uv sync failed. Will initialize project and add dependencies.
        set "NEED_UV_INIT=1"
    )
)

if "%NEED_UV_INIT%"=="1" (
    echo Initializing project with uv and adding required dependencies...
    uv init
    if errorlevel 1 (
        echo uv init failed.
        exit /b 1
    )
    uv add requests>=2.32.5
    if errorlevel 1 (
        echo Failed to add requests.
        exit /b 1
    )
    uv add fastapi>=0.128.0
    if errorlevel 1 (
        echo Failed to add fastapi.
        exit /b 1
    )
    uv add ariadne>=0.27.1
    if errorlevel 1 (
        echo Failed to add ariadne.
        exit /b 1
    )
    echo Generating virtual environment using uv...
    uv sync
    if errorlevel 1 (
        echo Failed to generate virtual environment using uv after initialization.
        exit /b 1
    )
)

echo Virtual environment generated successfully.

endlocal

