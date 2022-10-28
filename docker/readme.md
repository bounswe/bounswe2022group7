# How to build/run with Docker:

## Docker Compose:

#### Current docker-compose configuration runs the development version of the application.

`docker-compose up` command will build the images from scratch and run the containers with determined environment varibles in the first run. If this command is previously ran and a change is done on **backend**, `docker-compose build` command should be used before `docker-compose up`.

`docker-compose up -d` command will detach the containers upon execution.

To stop and remove the containers use `docker-compose down`

### Note: 

MySQL data is assigned to a certain volume, so in each rebuild it will conserve the changes. To start with a clear volume, you can either remove the volume part from `docker-compose.yml` file or remove the volume with `docker volume rm mysql_data`

---


## Docker Build & Run

### Development

To run the development version of the application use the following commands **filling "image-name" field with your chosen name**:

```bash
docker build -f backend.Dockerfile.development -t "image-name" ../backend
docker run --env-file=.env -p 8080:8080 -t "image-name"
```

### Production

To run the production version of the application use the following commands:

#### Notes:
- Fill the "image-name" with your chosen image name
- For **"production-env-file.env"** create an environment variable file, you can use the current `.env` file uploaded to repository as your template.

```bash
docker build -f backend.Dockerfile.production -t "image-name" ../backend
docker run --env-file="production-env-file.env" -p 8080:8080 -t "image-name"
```

