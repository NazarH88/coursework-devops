# ─── Stage 1: builder ──────────────────────────────────────────────────────
# Встановлюємо залежності в окремому шарі, щоб не тягнути build-tools у прод
FROM python:3.12-slim AS builder

WORKDIR /build

# Копіюємо тільки requirements — шар кешується до першої зміни залежностей
COPY app/requirements.txt .

RUN pip install --upgrade pip \
 && pip install --prefix=/install --no-cache-dir -r requirements.txt


# ─── Stage 2: runtime ──────────────────────────────────────────────────────
# Чистий образ без зайвого інструментарію
FROM python:3.12-slim AS runtime

# Мета-дані образу
LABEL maintainer="student@example.com"
LABEL version="1.0.0"
LABEL description="DevOps Coursework — Flask Demo"

# Не зберігаємо .pyc та не буферизуємо stdout
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_ENV=production \
    APP_VERSION=1.0.0 \
    PORT=5000

WORKDIR /app

# Копіюємо встановлені пакети з builder-шару
COPY --from=builder /install /usr/local

# Копіюємо код додатку
COPY app/ .

# Відкриваємо порт застосунку
EXPOSE 5000

# Healthcheck — Docker буде знати, чи живий контейнер
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/api/health')"

# Запускаємо через gunicorn (production WSGI-сервер)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "60", "app:app"]
