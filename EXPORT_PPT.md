# Exportação para PowerPoint

Este projeto inclui um sistema para exportar a apresentação de slides para PowerPoint (.pptx).

## Componentes

### 1. Script de Exportação (`scripts/export_to_ppt.py`)
- Lê todos os arquivos HTML da pasta `site/public/slides/`
- Converte para PowerPoint usando a biblioteca `python-pptx`
- Salva o arquivo em `site/public/` com timestamp

**Uso direto:**
```bash
python scripts/export_to_ppt.py
```

### 2. Servidor Backend (`backend/app/main.py`)
- Servidor Flask que expõe um endpoint para exportação
- Rota: `POST /api/export/pptx`
- Retorna arquivo .pptx para download

**Iniciar servidor:**
```bash
pip install flask flask-cors python-pptx beautifulsoup4
python backend/app/main.py
```

O servidor rodará em `http://127.0.0.1:5000`

### 3. Botão no Frontend
- Botão "📊 Exportar PPT" adicionado na toolbar do `site/index.html`
- Faz requisição POST para o servidor backend
- Faz download automático do arquivo

## Instalação de Dependências

```bash
pip install flask flask-cors python-pptx beautifulsoup4
```

## Como Usar

### Opção 1: Via Backend (Recomendado)
1. Iniciar o servidor:
   ```bash
   python backend/app/main.py
   ```

2. Abrir a apresentação no navegador:
   ```
   http://localhost:8000  (ou conforme configurado)
   ```

3. Clicar no botão "📊 Exportar PPT"

### Opção 2: Via Linha de Comando
```bash
python scripts/export_to_ppt.py
```

O arquivo será salvo em `site/public/Apresentacao_Grupo_Lider_YYYYMMDD_HHMMSS.pptx`

## Arquitetura

```
nova_apresentacao/
├── scripts/
│   └── export_to_ppt.py          # Script de exportação
├── backend/
│   └── app/
│       └── main.py               # Servidor Flask
├── site/
│   ├── index.html                # Frontend com botão
│   └── public/
│       └── slides/               # HTML dos slides
└── requirements.txt              # Dependências
```

## Notas Técnicas

- A exportação é baseada em texto extraído do HTML
- Cada slide cria uma página no PowerPoint com:
  - Título principal extraído do heading
  - Informações do slide (número, nome)
  - Fundo e formatação básica
- Gráficos e imagens complexas não são incluídas (apenas texto)
- Para apresentações com dados complexos, considere abrir a apresentação web em fullscreen e usar Print to PDF

## Melhorias Futuras

- [ ] Incluir imagens dos slides (captura de tela)
- [ ] Preservar cores e formatação visual
- [ ] Adicionar notas do apresentador
- [ ] Suportar múltiplos formatos de exportação (PDF, etc)
- [ ] Integrar com API de HTML to Image
