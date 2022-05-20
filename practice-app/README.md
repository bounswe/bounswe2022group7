# ArtShare - The Practice App

This folder contains the source code and the workflow we prepared as group 7 for the second milestone of Software Engineering Course (CMPE352), The Practice App. We have named our app **ArtShare**.

Before developing this app, we have done research on the tech topics involved, we have planned our progress with software engineering methods and frequently held meetings to track our progress and discuss development.

## How to Run the App

Before running the app, an `.env` needs to be created in the `website` directory. In this file, keys should be provided as follows:
```
TRANSLATE_API_KEY = <TRANSLATE_API_KEY>
WEATHER_API_KEY = <WEATHER_API_KEY>
SHORTENER_API_KEY = <SHORTENER_API_KEY>
COLOR_FINDER_API_KEY = <COLOR_FINDER_API_KEY>
COLOR_FINDER_API_SECRET = <COLOR_FINDER_API_SECRET>
ON_THIS_DAY_API_KEY = <ON_THIS_DAY_API_KEY>
SIMILARITY_SCORE_API_KEY = <SIMILARITY_SCORE_API_KEY>
JWT_SECRET_KEY = <JWT_SECRET_KEY>
FLASK_SECRET_KEY = <FLASK_SECRET_KEY>
DB_NAME = <DB_NAME>
```

Once the `.env` file is created, app can either be run locally or in a docker container. In the following sections, we show how the app can be deployed.

### Local 

App can be run locally after the requirements are installed: 
```bash
pip install -r requirements.txt
flask run
```

### Docker

App can also be deployed into a Docker container with the following commands:

```bash
docker-compose up
```
