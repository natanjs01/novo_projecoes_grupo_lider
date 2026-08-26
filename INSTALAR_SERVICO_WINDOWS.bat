@echo off
setlocal

set "NSSM=C:\nssm\nssm.exe"
set "PYTHON=C:\Users\idcontroller\AppData\Local\Programs\Python\Python314\python.exe"
set "ROOT=%~dp0"
set "ROOT=%ROOT:~0,-1%"
set "SERVICE=GrupoLider-ExportPPT"
set "BACKEND=%ROOT%\backend\app\main.py"
set "LAUNCHER=%ROOT%\INICIAR_BACKEND_SERVICO.cmd"

 echo.
echo ========================================
echo Instalacao do servico Grupo Lider PPT
echo ========================================
echo.

if not exist "%NSSM%" (
    echo ERRO: NSSM nao encontrado em %NSSM%
    pause
    exit /b 1
)

if not exist "%PYTHON%" (
    echo ERRO: Python nao encontrado em %PYTHON%
    pause
    exit /b 1
)

if not exist "%BACKEND%" (
    echo ERRO: Backend nao encontrado em %BACKEND%
    pause
    exit /b 1
)

if not exist "%LAUNCHER%" (
    echo ERRO: Launcher nao encontrado em %LAUNCHER%
    pause
    exit /b 1
)

echo Removendo instalacao anterior, se existir...
"%NSSM%" stop "%SERVICE%" >nul 2>&1
"%NSSM%" remove "%SERVICE%" confirm >nul 2>&1

echo Instalando servico...
"%NSSM%" install "%SERVICE%" "%ComSpec%"
if errorlevel 1 (
    echo ERRO: Falha ao instalar o servico.
    pause
    exit /b 1
)

"%NSSM%" set "%SERVICE%" AppParameters "/c INICIAR_BACKEND_SERVICO.cmd"
"%NSSM%" set "%SERVICE%" AppDirectory "%ROOT%"
"%NSSM%" set "%SERVICE%" DisplayName "Grupo Lider - Exportacao PPT"
"%NSSM%" set "%SERVICE%" Description "Servidor Flask para exportacao de apresentacoes em PowerPoint"
"%NSSM%" set "%SERVICE%" Start SERVICE_AUTO_START
"%NSSM%" set "%SERVICE%" AppExit Default Restart
"%NSSM%" set "%SERVICE%" AppRestartDelay 5000

 echo Iniciando servico...
"%NSSM%" start "%SERVICE%"
if errorlevel 1 (
    echo AVISO: Servico instalado, mas nao foi iniciado.
    echo Verifique em services.msc.
    pause
    exit /b 1
)

echo.
echo SUCESSO: servico instalado e iniciado.
echo Nome: %SERVICE%
echo Porta: 127.0.0.1:5001
echo.
echo Teste agora o botao Exportar PPT.
echo.
pause
endlocal
