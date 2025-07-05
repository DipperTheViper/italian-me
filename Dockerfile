FROM python:3.12-slim
WORKDIR /app

# Install system deps + Poetry
RUN apt-get update && apt-get install -y \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip install poetry && \
    poetry config virtualenvs.create false

# Copy ONLY required files for dependency installation
COPY README.md pyproject.toml poetry.lock ./

# Install dependencies (skip project installation)
RUN poetry install --only main --no-root

# Copy everything else
COPY . .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]