@echo off
REM Script para iniciar o servidor de exportação PowerPoint
REM Executar este arquivo para iniciar o servidor

echo.
echo ========================================
echo Servidor de Exportacao PPT
echo Grupo Lider Supermercados
echo ========================================
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Python nao encontrado!
    echo Por favor, instale Python ou adicione ao PATH
    pause
    exit /b 1
)

REM Verificar se as dependências estão instaladas
echo Verificando dependencias...
python -c "import flask; import pptx; import bs4" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ⚠️  Dependencias nao encontradas
    echo Instalando packages necessarios...
    echo.
    pip install -r backend\requirements.txt
    if %errorlevel% neq 0 (
        echo ERRO: Falha ao instalar dependencias
        pause
        exit /b 1
    )
)

echo.
echo ✅ Tudo preparado!
echo.
echo Iniciando servidor em http://127.0.0.1:5000
echo.
echo Dicas:
echo   - Abra a apresentacao no navegador
echo   - Clique em "📊 Exportar PPT"
echo   - Arquivo sera baixado automaticamente
echo.
echo Pressione Ctrl+C para parar o servidor
echo.

REM Iniciar o servidor
cd /d %~dp0
python backend\app\main.py

pause
