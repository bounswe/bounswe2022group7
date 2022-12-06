# How to build/run with Docker:

## Docker Compose:

#### Current docker-compose configuration runs the development version of the application.

`docker-compose up` command will build the images from scratch and run the containers with determined environment varibles in the first run. If this command is previously ran and a change is done on **backend**, `docker-compose up --build` command should be used if hot reload doesn't detect the changes.

`docker-compose up -d` command will detach the containers upon execution.

To stop and remove the containers use `docker-compose down`

### Note: 

MySQL data is assigned to a certain volume, so in each rebuild it will conserve the changes. To start with a clear volume, you can either remove the volume part from `docker-compose.yml` file or remove the volume with `docker volume rm mysql_data`

---
# Docker Build & Run
## Backend

`WORKDIR=./docker`

### Development

To run the development version of the application use the following commands **filling "image-name" field with your chosen name**:

```bash
docker build -f backend.development.Dockerfile -t "image-name" ../backend
docker run --env-file=.env -p 8080:8080 -t "image-name"
```

### Production

To run the production version of the application use the following commands:

#### Notes:
- Fill the "image-name" with your chosen image name
- For **"production-env-file.env"** create an environment variable file, you can use the current `.env` file uploaded to repository as your template.

```bash
docker build -f backend.production.Dockerfile -t "image-name" ../backend
docker run --env-file="production-env-file.env" -p 8080:8080 -t "image-name"
```

---

## Frontend

`WORKDIR=./docker`

### Development

To run the frontend in development mode (with hot reload), `docker-compose up` will be the best way, but if you want to manually build and run the image the following command will work:

```bash
docker build -f frontend.development.Dockerfile -t "frontend-image-name"  ../frontend
docker run -p 3000:3000 -t "frontend-image-name" 
```

### Production

The production build of frontend uses NGINX to serve static files, also NGINX works as a reverse proxy for backend application. To create the image and run:

```bash
docker build -f frontend.production.Dockerfile -t "production-frontend-image" ../frontend
docker run -p 80:80 -t "production-frontend-image
```

#### Notes:
- Fill the parts between `""` as you wish.


---

## Annotation

`WORKDIR=./docker`

### Development

To run the annotation microservice in development mode `docker-compose up` will be the best way, but if you want to manually build and run the image the following command will work:

```bash
docker build -f annotation.development.Dockerfile -t "annotation-image-name"  ../annotations
docker run -p 3001:3001 -t "annotation-image-name" 
```

### Production

The production build doesn't work differently then the development build, the only difference is the db connection settings on production environment. Using the following commands will build and run the image.

```bash
docker build -f annotation.production.Dockerfile -t "production-annotation-image" ../annotations
docker run -p 3001:3001 -t "production-annotation-image
```
