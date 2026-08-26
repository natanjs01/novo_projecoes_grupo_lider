#!/bin/bash
# Script para iniciar o servidor de exportação PowerPoint
# Grupo Líder Supermercados - Apresentação

echo ""
echo "========================================"
echo "Servidor de Exportacao PPT"
echo "Grupo Lider Supermercados"
echo "========================================"
echo ""

# Verificar Python
echo "Verificando Python..."
if ! command -v python3 &> /dev/null; then
    echo "ERRO: Python 3 nao encontrado!"
    echo "Por favor, instale Python em: https://www.python.org"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo "✓ Python encontrado: $PYTHON_VERSION"

# Verificar dependências
echo "Verificando dependencias..."
python3 -c "import flask; import pptx; import bs4" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "⚠️  Instalando dependencias..."
    echo ""
    pip3 install -r backend/requirements.txt
    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao instalar dependencias"
        exit 1
    fi
else
    echo "✓ Todas as dependencias instaladas"
fi

echo ""
echo "✅ Tudo preparado!"
echo ""
echo "Iniciando servidor em http://127.0.0.1:5000"
echo ""
echo "DICAS:"
echo "  • Abra a apresentação no navegador"
echo "  • Clique em '📊 Exportar PPT'"
echo "  • Arquivo será baixado automaticamente"
echo ""
echo "Pressione Ctrl+C para parar o servidor"
echo ""

# Iniciar servidor
python3 backend/app/main.py
