# Exportação para PowerPoint

Este projeto inclui um sistema para exportar a apresentação de slides para PowerPoint (.pptx).

## ⚡ Início Rápido

### 1. Instalar Dependências (primeira vez)
```bash
pip install -r backend/requirements.txt
```

### 2. Iniciar o Servidor
```bash
python backend/app/main.py
```

**Esperado:**
```
WARNING in app.run_simple
 * Running on http://127.0.0.1:5000
```

### 3. Usar o Botão na Apresentação
1. Abrir a apresentação no navegador
2. Clicar no botão **"📊 Exportar PPT"**
3. Arquivo será baixado automaticamente

---

## 📋 Componentes Detalhados

### Script de Exportação (`scripts/export_to_ppt.py`)
- Lê todos os arquivos HTML da pasta `site/public/slides/`
- Converte para PowerPoint usando `python-pptx`
- Salva em `site/public/` com timestamp

**Uso direto:**
```bash
python scripts/export_to_ppt.py
```

### Servidor Backend (`backend/app/main.py`)
- Servidor Flask que expõe endpoints
- `GET /api/health` - Verificação de saúde
- `POST /api/export/pptx` - Exporta e retorna arquivo

**Iniciar:**
```bash
python backend/app/main.py
```

Servidor rodará em `http://127.0.0.1:5000`

### Frontend (`site/index.html`)
- Botão "📊 Exportar PPT" na toolbar
- Verifica disponibilidade do servidor
- Faz download automático
- Mostra mensagens de erro/sucesso

---

## 🔧 Solução de Problemas

### Erro: "ERR_CONNECTION_REFUSED"
**Causa:** O servidor Flask não está rodando

**Solução:**
1. Abra um terminal nova
2. Execute: `python backend/app/main.py`
3. Você deve ver: `Running on http://127.0.0.1:5000`
4. Tente novamente no navegador

### Erro: "Module not found"
**Causa:** Dependências não instaladas

**Solução:**
```bash
pip install -r backend/requirements.txt
```

### Servidor não inicia
**Causa:** Porta 5000 já em uso

**Solução:**
```bash
# Opção 1: Liberar porta 5000 (encerre outros processos)
# Opção 2: Mudar porta no código (main.py, linha final)
python backend/app/main.py  # Padrão: 5000
```

---

## 📦 Dependências

| Pacote | Versão | Uso |
|--------|--------|-----|
| `flask` | 3.0.0 | Servidor web |
| `flask-cors` | 4.0.0 | CORS para requisições |
| `python-pptx` | 0.6.23 | Geração de PowerPoint |
| `beautifulsoup4` | 4.12.2 | Parse HTML |

---

## 🏗️ Arquitetura

```
nova_apresentacao/
├── backend/
│   ├── app/
│   │   └── main.py              # Servidor Flask
│   └── requirements.txt          # Dependências
├── scripts/
│   └── export_to_ppt.py         # Script de exportação
├── site/
│   ├── index.html               # Frontend com botão
│   └── public/
│       └── slides/              # HTML dos slides (01-20)
└── EXPORT_PPT.md                # Esta documentação
```

---

## 🚀 Fluxo de Funcionamento

```
[Usuário clica "Exportar PPT"]
         ↓
[Frontend verifica servidor]
         ↓
[Servidor está online?]
    ├─ SIM → [Executa exportação] → [Retorna PPTX] → [Download]
    └─ NÃO → [Mostra instruções] → [Aguarda inicialização]
```

---

## 📝 Notas

- ⚠️ **IMPORTANTE:** Servidor deve estar rodando para usar o botão
- Exportação cria apresentação básica (texto apenas)
- Arquivo é salvo em `site/public/` com data/hora
- Download automático após exportação bem-sucedida

---

## ✨ Melhorias Futuras

- [ ] Incluir screenshots dos slides
- [ ] Preservar cores e formatação visual
- [ ] Adicionar notas do apresentador
- [ ] Suportar PDF export
- [ ] Interface web para gerenciar exports
- [ ] Agendamento de exports periódicos


