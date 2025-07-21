# Build stage: installer les dépendances
FROM python:3.10-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.10-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_ENV=production

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY app/main.py /app/

RUN adduser --disabled-password --gecos "" appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

CMD ["/bin/sh", "/app/db_connect.sh"]
