
FROM python:3.10-slim

WORKDIR /app

RUN pip3 install --no-cache-dir poetry

COPY pyproject.toml poetry.lock* ./

RUN poetry install --no-dev --no-interaction --no-root

COPY . .

EXPOSE 8024

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

CMD ["gunicorn", "--bind", "0.0.0.0:8024", "app:app"]
