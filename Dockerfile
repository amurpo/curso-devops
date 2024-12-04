# Imagen base de Node.js 20
FROM node:20-alpine

# Crear un usuario no root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Configurar el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar solo package.json y package-lock.json primero para aprovechar la caché de Docker
COPY package*.json ./

# Instalar dependencias como usuario root
RUN npm install

# Copiar el resto del código al contenedor
COPY . .

# Cambiar la propiedad de los archivos al usuario no root
RUN chown -R appuser:appgroup /app

# Cambiar al usuario no root
USER appuser

# Exponer el puerto 3000
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["npm", "start"]
