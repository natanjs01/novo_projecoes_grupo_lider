#!/usr/bin/env pwsh
<#
.SYNOPSIS
Inicia o servidor de exportação para PowerPoint
Grupo Líder Supermercados - Apresentação

.DESCRIPTION
Script que:
1. Verifica se Python está instalado
2. Instala dependências (se necessário)
3. Inicia o servidor Flask
#>

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Servidor de Exportacao PPT" -ForegroundColor Green
Write-Host "Grupo Lider Supermercados" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar Python
Write-Host "Verificando Python..." -ForegroundColor Yellow
$pythonCheck = python --version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERRO: Python nao encontrado!" -ForegroundColor Red
    Write-Host "Por favor, instale Python em: https://www.python.org" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}
Write-Host "✓ Python encontrado: $pythonCheck" -ForegroundColor Green

# Verificar dependências
Write-Host "Verificando dependencias..." -ForegroundColor Yellow
try {
    python -c "import flask; import pptx; import bs4" 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Modulos nao encontrados"
    }
    Write-Host "✓ Todas as dependencias instaladas" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Instalando dependencias..." -ForegroundColor Yellow
    Write-Host ""
    pip install -r backend/requirements.txt
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRO: Falha ao instalar dependencias" -ForegroundColor Red
        Read-Host "Pressione Enter para sair"
        exit 1
    }
}

Write-Host ""
Write-Host "✅ Tudo preparado!" -ForegroundColor Green
Write-Host ""
Write-Host "Iniciando servidor em http://127.0.0.1:5000" -ForegroundColor Cyan
Write-Host ""
Write-Host "DICAS:" -ForegroundColor Yellow
Write-Host "  • Abra a apresentacao no navegador" -ForegroundColor White
Write-Host "  • Clique em '📊 Exportar PPT'" -ForegroundColor White
Write-Host "  • Arquivo sera baixado automaticamente" -ForegroundColor White
Write-Host ""
Write-Host "Pressione Ctrl+C para parar o servidor" -ForegroundColor Magenta
Write-Host ""

# Iniciar servidor
python backend/app/main.py

Read-Host "Pressione Enter para sair"
