from PIL import Image, ImageDraw, ImageFont

def process_image(texto, ruta_imagen, ruta_salida):
    imagen = Image.open(ruta_imagen)
    draw = ImageDraw.Draw(imagen)
    
    ancho_imagen, alto_imagen = imagen.size
    
    fuente = ImageFont.truetype("arial.ttf", 64)
    
    bbox = draw.textbbox((0, 0), texto, fuente)
    ancho_texto = bbox[2] - bbox[0]
    alto_texto = bbox[3] - bbox[1]
    
    x = (ancho_imagen - ancho_texto) / 2
    y = (alto_imagen - alto_texto) / 2
    
    draw.text((x, y), texto, fill="white", font=fuente, stroke_width=4, stroke_fill="black")
    
    imagen.save(ruta_salida)

if __name__ == "__main__":
    texto = "Texto de ejemplo"
    ruta_imagen = "image.jpg"
    ruta_salida = "image_text.jpg"
    process_image(texto, ruta_imagen, ruta_salida)