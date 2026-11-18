
from pydantic import BaseModel

class UserCreate(BaseModel):
    username : str
    mail : str
    password : str

class UserLogin(BaseModel):
    mail : str
    password : str

class UserDelete(BaseModel):
    mail : str
    password : str

class TaskCreate(BaseModel):
    title : str
    description : str
    status : bool

class TaskUpdate(BaseModel):
    title : str
    description : str
    status : bool
