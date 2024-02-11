FROM node:19.2-alpine3.16 as dev-deps
WORKDIR /app
COPY package.json ./
RUN npm install

FROM node:19.2-alpine3.16 as test
WORKDIR /app
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN npm run test

FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod

FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks
CMD [ "node", "app.js" ]

## Comando de construcción de imagen sin buildX 
## docker build --tag  cron-ticket .

## Se encarga de construir una imagen de Docker utilizando las instrucciones definidas en el Dockerfile presente en el directorio actual, debe hacer match con la ubicación del dockerfile ("."), y luego etiqueta esa imagen con el nombre "cron-ticket"

# plataforma especifica mediante dockerfile.
    # FROM --platform=linux/amd64 node:19.2-alpine3.16 
    
# Si quisiera usar las plataformas definidas en mi "buildx"
    # FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16

# Si construimos la imagen sin especificar el BUILDPLATFORM con "buildx" la va a construir en base a la arquitectura del host.

# Para publicar esta imagen: 
# Auth: 
#   docker login username:FacundoBettella password:xxxx
#   docker image tag cron-ticker FacundoBettella/cron-ticker
#   docker push FacundoBettella/cron-ticker:latest