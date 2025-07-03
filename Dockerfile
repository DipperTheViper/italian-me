# ./Dockerfile
FROM python:3.12-slim
WORKDIR /app

# Install Poetry
RUN pip install poetry && \
    poetry config virtualenvs.create false

# Copy dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry install --only main

# Copy app
COPY . .

CMD ["uvicorn", "italianme.main:app", "--host", "0.0.0.0", "--port", "80"]