from fastapi import FastAPI , HTTPException
import model
import crud
import sqlite3

app = FastAPI()

@app.post("/users/register")
def register(user: model.UserCreate):
    try:
        crud.create_user(user.username, user.mail, user.password)
    except sqlite3.IntegrityError:
        raise HTTPException(
            status_code=409,
            detail="Cette adresse e-mail est déjà utilisée"
        )

    return {"message": "Utilisateur créé avec succès"}

@app.post("/users/login")
def login(user: model.UserLogin):
    user_db = crud.get_user_by_mail(user.mail)

    if user_db is None:
        raise HTTPException(status_code=400, detail="Utilisateur introuvable")

    if not user.password:
        raise HTTPException(status_code=400, detail="Mot de passe manquant")

    if user_db[3] != user.password:
        raise HTTPException(status_code=400, detail="Mot de passe incorrect")

    return {"message": "Connexion réussie"}

@app.delete("/users/delete")
def delete(user:model.UserDelete):
    user_db = crud.get_user_by_mail(user.mail)
    if user_db is None:
        return {"message": "Utilisateur introuvable"}

    if not user.password:
        return {"vous n'avez rien ecrit"}

    if user_db[3] != user.password:
        return {"message": "Mot de passe incorrect"}
    
    crud.delete_user(user.mail)
    return {"supression reussit"}

@app.post("/users/{user_id}/tasks")
def createTask(user_id:int,task:model.TaskCreate):
    crud.create_task(user_id, task.title , task.description , task.status)
    return {"message": "Tâche créée avec succès"}

@app.get("/users/{user_id}/tasks")
def get_tasks(user_id:int):
    return crud.get_tasks(user_id)


@app.put("/tasks/{task_id}")
def update_task(task_id:int,task:model.TaskUpdate):
    return crud.update_task(task_id, task.title , task.description,task.status)

@app.delete("/tasks/{task_id}")
def delete_task(task_id: int):
    crud.delete_task(task_id)

    return {"message": "Tâche supprimée avec succès"}