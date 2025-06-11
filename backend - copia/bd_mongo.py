from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, OperationFailure
from bson import ObjectId
from datetime import datetime
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

class MongoDB:
    def __init__(self):
        # Configuración de conexión
        self.MONGO_URI = os.getenv('MONGO_URI', 'mongodb://localhost:27017/')
        self.DB_NAME = os.getenv('DB_NAME', 'mi_base_de_datos')
        self.client = None
        self.db = None
        
    def connect(self):
        """Establece conexión con MongoDB"""
        try:
            self.client = MongoClient(self.MONGO_URI)
            # Verificar que la conexión es válida
            self.client.admin.command('ping')
            self.db = self.client[self.DB_NAME]
            print("✅ Conexión exitosa a MongoDB")
            return True
        except ConnectionFailure as e:
            print(f"❌ Error de conexión: {e}")
            return False
    
    def close(self):
        """Cierra la conexión con MongoDB"""
        if self.client:
            self.client.close()
            print("🔌 Conexión cerrada")
    
    # Operaciones CRUD
    
    def insert_one(self, collection_name, document):
        """Inserta un documento en la colección especificada"""
        try:
            collection = self.db[collection_name]
            document['created_at'] = datetime.utcnow()
            result = collection.insert_one(document)
            print(f"📝 Documento insertado con ID: {result.inserted_id}")
            return result.inserted_id
        except OperationFailure as e:
            print(f"❌ Error al insertar: {e}")
            return None
    
    def find_one(self, collection_name, query):
        """Busca un documento en la colección"""
        try:
            collection = self.db[collection_name]
            return collection.find_one(query)
        except OperationFailure as e:
            print(f"❌ Error al buscar: {e}")
            return None
    
    def find_all(self, collection_name, query={}):
        """Devuelve todos los documentos que coincidan con el query"""
        try:
            collection = self.db[collection_name]
            return list(collection.find(query))
        except OperationFailure as e:
            print(f"❌ Error al buscar: {e}")
            return []
    
    def update_one(self, collection_name, query, new_values):
        """Actualiza un documento"""
        try:
            collection = self.db[collection_name]
            new_values['updated_at'] = datetime.utcnow()
            result = collection.update_one(
                query,
                {'$set': new_values}
            )
            print(f"🔄 Documentos modificados: {result.modified_count}")
            return result.modified_count
        except OperationFailure as e:
            print(f"❌ Error al actualizar: {e}")
            return 0
    
    def delete_one(self, collection_name, query):
        """Elimina un documento"""
        try:
            collection = self.db[collection_name]
            result = collection.delete_one(query)
            print(f"🗑️ Documentos eliminados: {result.deleted_count}")
            return result.deleted_count
        except OperationFailure as e:
            print(f"❌ Error al eliminar: {e}")
            return 0
        
    def printeo (self, collection_name):
        """Imprime"""
        print("Imprimiendo desde python :)")

    def find_all(self, collection_name, query={}, limit=0):
        """Devuelve todos los documentos que coincidan con el query"""
        try:
            collection = self.db[collection_name]
            if limit > 0:
                return list(collection.find(query).limit(limit))
            return list(collection.find(query))
        except OperationFailure as e:
            print(f"❌ Error al buscar: {e}")
            return []
# Ejemplo de uso
if __name__ == "__main__":
    # Crear instancia de MongoDB
    mongo = MongoDB()
    
    # Conectar a la base de datos
    if mongo.connect():
        # Insertar un documento
        user_id = mongo.insert_one("users", {
            "name": "Juan Pérez",
            "email": "juan@example.com",
            "age": 30
        })
        
        # Buscar el documento insertado
        if user_id:
            user = mongo.find_one("users", {"_id": user_id})
            print("Usuario encontrado:", user)
            
            # Actualizar el documento
            mongo.update_one("users", {"_id": user_id}, {"age": 31})
            
            # Ver todos los usuarios
            all_users = mongo.find_all("users")
            print("Todos los usuarios:", all_users)
            
            # Eliminar el documento
            mongo.delete_one("users", {"_id": user_id})
        
        # Cerrar conexión
        mongo.close()