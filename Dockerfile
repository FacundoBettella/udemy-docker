## Comando de construcción de imagen sin buildX 
## docker build --tag  cron-ticket .

## Se encarga de construir una imagen de Docker utilizando las instrucciones definidas en el Dockerfile presente en el directorio actual, debe hacer match con la ubicación del dockerfile ("."), y luego etiqueta esa imagen con el nombre "cron-ticket"


# plataforma especifica mediante dockerfile.
    # FROM --platform=linux/amd64 node:19.2-alpine3.16 
    
# Si quisiera usar las plataformas definidas en mi "buildx"
    # FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16

# Si construimos la imagen sin especificar el BUILDPLATFORM con "buildx" la va a construir en base a la arquitectura del host.
FROM node:19.2-alpine3.16

ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > /log

# cd app
WORKDIR /app

# source/host /Destino/img
COPY package.json ./

# Instalar las dependencias
RUN npm install

COPY ./ ./

# Realizar testing
RUN npm run test

# Eliminar archivos y directorios no necesarios en PROD
RUN rm -rf tests && rm -rf node_modules

# Unicamente las dependencias de prod
RUN npm install --prod

# Comando RUN de la imagen
CMD [ "node", "app.js" ]

# Para publicar esta imagen: 
# Auth: 
#   docker login username:FacundoBettella password:xxxx
#   docker image tag cron-ticker FacundoBettella/cron-ticker
#   docker push FacundoBettella/cron-ticker:latest