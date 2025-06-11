from pydantic import BaseModel, EmailStr
from typing import Optional
from pymongo import ASCENDING
from bd_mongo import db

class User(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserLogin(BaseModel):
    username: str
    password: str

class Task(BaseModel):
    title: str
    description: Optional[str] = None
    completed: bool = False

users = db["users"]
otp = db["otp"]
otp.create_index([("email", ASCENDING)], unique=True)