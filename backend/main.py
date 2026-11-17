from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"tasks": ["Apprendre Python", "Apprendre FastAPI"]}