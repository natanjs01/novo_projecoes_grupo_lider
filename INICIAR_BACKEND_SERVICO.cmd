@echo off
setlocal

set "PYTHON=C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
set "ROOT=%~dp0"
set "BACKEND=%ROOT%backend\app\main.py"

"%PYTHON%" "%BACKEND%"
set "EXITCODE=%ERRORLEVEL%"
endlocal & exit /b %EXITCODE%
