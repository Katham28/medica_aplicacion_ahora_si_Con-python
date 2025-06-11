from flask import Flask, request, send_file, jsonify
from process_image import process_image
from mongo_handler import MongoDB  # Importa tu clase MongoDB
from datetime import datetime
import os
from fastapi import FastAPI
from auth import router as auth_router

app = FastAPI()
app.include_router(auth_router)

app = Flask(__name__)

# Crea una instancia de MongoDB al iniciar la app
mongo = MongoDB()

@app.route('/api', methods=['POST'])
def main():
    try:
        # Conectar a MongoDB
        if not mongo.connect():
            return jsonify({"error": "No se pudo conectar a la base de datos"}), 500
        
        data = request.get_json()
        text = data.get('text')
        
        # Procesar la imagen
        process_image(text, 'image.jpg', 'image_text.jpg')
        
        # Guardar registro en MongoDB
        document_id = mongo.insert_one("image_processing", {
            "text": text,
            "original_image": "image.jpg",
            "processed_image": "image_text.jpg",
            "processed_at": datetime.utcnow()
        })
        
        # Verificar que se insertó correctamente
        if not document_id:
            return jsonify({"error": "Error al guardar en base de datos"}), 500
        
        return send_file('image_text.jpg', mimetype='image/jpg')
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        # Cerrar conexión
        mongo.close()

@app.route('/history', methods=['GET'])
def get_history():
    try:
        if not mongo.connect():
            return jsonify({"error": "No se pudo conectar a la base de datos"}), 500
        
        # Obtener últimos 10 procesamientos
        history = mongo.find_all("image_processing", {}, limit=10)
        
        # Convertir ObjectId a string para JSON
        for item in history:
            item['_id'] = str(item['_id'])
        
        return jsonify(history)
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        mongo.close()

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)