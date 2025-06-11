from datetime import datetime, timedelta
from jose import JWTError, jwt
from passlib.context import CryptContext
from fastapi import APIRouter, HTTPException, Depends, status
import bcrypt, jwt, os
from pydantic import BaseModel, EmailStr
from models import users, otp
from otp_utils import gen_code, hash_code, send_code_email

router = APIRouter(prefix="/auth", tags=["auth"])

# Configuración
SECRET_KEY = "tu_super_secreto"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

class EmailOnly(BaseModel):
    email: EmailStr

class VerifyReq(BaseModel):
    email: EmailStr
    code : str

class ResetReq(BaseModel):
    new_password: str

JWT_SECRET = os.getenv("JWT_SECRET")

#Solicitar código
@router.post("/forgot-password", status_code=200)
def forgot_password(body: EmailOnly):
    if not users.find_one({"email": body.email}):
        return   # 204-like → no sacamos info

    code      = gen_code()
    code_hash = hash_code(code)
    otp.update_one(
        {"email": body.email},
        {"$set": {
            "code_hash": code_hash,
            "expires"  : datetime.utcnow() + timedelta(minutes=10),
            "tries"    : 5}},
        upsert=True
    )
    send_code_email(body.email, code)
    return {"msg": "Código enviado si el correo existe"}

#Verificar código
@router.post("/verify-code")
def verify_code(body: VerifyReq):
    doc = otp.find_one({"email": body.email})
    if not doc or doc["expires"] < datetime.utcnow() or doc["tries"] <= 0:
        raise HTTPException(status_code=400, detail="Código inválido/expirado")

    if not bcrypt.checkpw(body.code.encode(), doc["code_hash"]):
        otp.update_one({"email": body.email}, {"$inc": {"tries": -1}})
        raise HTTPException(status_code=400, detail="Código incorrecto")

    token = jwt.encode({"sub": body.email, "type": "RESET"}, JWT_SECRET, algorithm="HS256")
    return {"token": token}

#Reset de contraseña
def reset_guard(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        assert payload.get("type") == "RESET"
        return payload["sub"]
    except Exception:
        raise HTTPException(status_code=401, detail="Token inválido")

@router.post("/reset-password")
def reset_password(body: ResetReq, email: str = Depends(reset_guard)):
    pw_hash = bcrypt.hashpw(body.new_password.encode(), bcrypt.gensalt())
    users.update_one({"email": email}, {"$set": {"password": pw_hash}})
    otp.delete_one({"email": email})
    return {"msg": "Contraseña actualizada"}