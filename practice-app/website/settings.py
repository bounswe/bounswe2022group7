import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

WEATHER_API_KEY = os.environ.get("WEATHER_API_KEY")
SHORTENER_API_KEY = os.environ.get("URL_SHORTENER_API_KEY")
COLOR_FINDER_API_KEY =  os.environ.get("COLOR_FINDER_API_KEY")
COLOR_FINDER_API_SECRET = os.environ.get("COLOR_FINDER_API_SECRET")

JWT_SECRET_KEY = os.environ.get("JWT_SECRET_KEY")
FLASK_SECRET_KEY = os.environ.get("FLASK_SECRET_KEY")

DB_NAME = "database.db"
