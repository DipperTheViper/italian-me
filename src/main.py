from fastapi import FastAPI
from sqlalchemy import create_engine, text
import os

app = FastAPI()
engine = create_engine(os.getenv("DATABASE_URL"))

@app.get("/")
async def root():
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 'Database connected!'"))
        return {"message": result.scalar()}