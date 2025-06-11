# backend/otp_utils.py
import os, random, bcrypt, smtplib, ssl
from email.message import EmailMessage
from datetime import datetime, timedelta
from bson import ObjectId

OTP_EXP_MINUTES = 10
MAX_TRIES        = 5

def gen_code() -> str:
    return f"{random.randint(100_000, 999_999)}"

def hash_code(code: str) -> bytes:
    return bcrypt.hashpw(code.encode(), bcrypt.gensalt())

def send_code_email(to_email: str, code: str):
    msg = EmailMessage()
    msg["Subject"] = "Tu código para restablecer contraseña"
    msg["From"]    = os.getenv("SMTP_FROM")
    msg["To"]      = to_email
    msg.set_content(f"Hola!\n\nTu código es: {code}\nExpira en {OTP_EXP_MINUTES} minutos.")

    ctx = ssl.create_default_context()
    with smtplib.SMTP_SSL(os.getenv("SMTP_HOST"), int(os.getenv("SMTP_PORT")), context=ctx) as smtp:
        smtp.login(os.getenv("SMTP_USER"), os.getenv("SMTP_PASS"))
        smtp.send_message(msg)

def build_otp_doc(email: str, code_hash: bytes) -> dict:
    return {
        "_id"       : ObjectId(),
        "email"     : email,
        "code_hash" : code_hash,
        "expires"   : datetime.utcnow() + timedelta(minutes=OTP_EXP_MINUTES),
        "tries"     : MAX_TRIES,
    }
