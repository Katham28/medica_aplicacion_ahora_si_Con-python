from pymongo import MongoClient
from pymongo.server_api import ServerApi

# Conexión a MongoDB (local o Atlas)
client = MongoClient("mongodb://localhost:27017", server_api=ServerApi('1'))
db = client["mi_app"]  # Nombre de la base de datos

# Colecciones
users_collection = db["users"]
tasks_collection = db["tasks"]  # Ejemplo para CRUD