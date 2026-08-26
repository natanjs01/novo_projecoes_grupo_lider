#!/usr/bin/env python3
"""
Servidor Flask para expor endpoints de exportação
"""

import os
import sys
from pathlib import Path
from flask import Flask, jsonify, send_file
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)

# Add scripts to path
SCRIPTS_DIR = Path(__file__).parent.parent.parent / "scripts"
sys.path.insert(0, str(SCRIPTS_DIR))

@app.route('/api/export/pptx', methods=['POST'])
def export_pptx():
    """
    Endpoint para exportar apresentação para PowerPoint
    """
    try:
        from export_to_ppt import export_to_pptx
        
        # Exporta para PowerPoint
        output_file = export_to_pptx()
        
        # Verifica se arquivo foi criado
        if os.path.exists(output_file):
            return send_file(
                output_file,
                as_attachment=True,
                download_name='Apresentacao_Grupo_Lider.pptx',
                mimetype='application/vnd.openxmlformats-officedocument.presentationml.presentation'
            )
        else:
            return jsonify({"error": "Falha ao gerar PowerPoint"}), 500
            
    except Exception as e:
        print(f"Erro na exportação: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/api/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({"status": "ok", "service": "export-api"}), 200

@app.route('/', methods=['GET'])
def index():
    """Info endpoint"""
    return jsonify({
        "service": "Grupo Líder Export API",
        "version": "1.0",
        "endpoints": {
            "POST /api/export/pptx": "Exporta apresentação para PowerPoint",
            "GET /api/health": "Health check"
        }
    }), 200

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001, debug=False, use_reloader=False)
