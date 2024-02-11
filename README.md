## docker-basic-buildx

Aplicación básica que permite la ejecución de un proceso cada 5 segundos.

Comandos permitidos

npm install
npm run test
npm start

Comandos importantes usados:
BUILDX:

Creamos un builder (imagen) para definir la construccion de imagenes con la aqruitectura definida:

```
docker buildx create --name mybuilder --bootstrap --use

```

Para usar el builder:

```
docker buildx use mybuilder

```

Para chequear que es el nuevo buildx a utilizar:

```
docker buildx ls

```

Para hacer inspect y ver en que plataformas va a correr la imagenes que construyamos con el:

```
docker buildx inspect

```

Hacemos la construcción de la imagen con las plataformas indicadas (descarga las imagenes con los OS para los diferentes entornos y luego los sube a DOCKER):

```
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \

-t facundoBettella/cron-ticker:latest --push .
```

# Desde dockerfile

Plataforma especifica mediante dockerfile.

```
FROM --platform=linux/amd64 node:19.2-alpine3.16
```

Si quisiera usar las plataformas definidas en mi buildx

```
# FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16
```

## Si quisieramos hacer la construcción multiplataforma de la imagen de forma manual y pushear la imagen:

```
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
-t FacundoBettella/cron-ticker:latest --push .
```

Buildx Referencia:
**https://docs.docker.com/build/building/multi-platform/#getting-started**
