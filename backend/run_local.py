import os
import sys

from uvicorn import run

if __name__ == "__main__":
    os.environ.setdefault("APP_NAME", "lider_dashboard")
    os.environ.setdefault("ENVIRONMENT", "local")
    os.environ.setdefault("PORT", "8000")
    os.environ.setdefault("DATABASE_URL", "sqlite:///./local_dev.db")

    run(
        "app.main:app",
        host="0.0.0.0",
        port=int(os.getenv("PORT", "8000")),
        reload=True,
        log_level="info",
    )
