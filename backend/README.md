# Backend local - Grupo Lider

## Requisitos
- Python 3.11+
- pip
- PostgreSQL local (opcional no início)

## Instalação local

```powershell
cd backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## Execução local

```powershell
cd backend
.\.venv\Scripts\Activate.ps1
$env:APP_NAME="lider_dashboard"
$env:ENVIRONMENT="local"
$env:PORT="8000"
$env:DATABASE_URL="sqlite:///./local_dev.db"
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

## Endpoints

- GET /
- GET /health
- GET /api/slides
- GET /api/summary

## Próximo passo
- trocar SQLite por PostgreSQL local
- rodar como serviço Windows com NSSM
