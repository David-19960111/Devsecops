#Imagen base ligera de Python
FROM python:3.11-slim 

#Establecer directorio de trabajo 
WORKDIR /app 

#Copiar archivos necesarios 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src        

#Puerto Expuesto
EXPOSE 5000

#Comando para ejecutar la app con Gunicorn
CMD ["gunicorn","--chdir","src","--bind","0.0.0.0:5000", "app:app"]