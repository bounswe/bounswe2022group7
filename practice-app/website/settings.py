import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

TRANSLATE_API_KEY = os.environ.get("TRANSLATE_API_KEY")
WEATHER_API_KEY = os.environ.get("WEATHER_API_KEY")
COLOR_FINDER_API_KEY =  os.environ.get("COLOR_FINDER_API_KEY")
COLOR_FINDER_API_SECRET = os.environ.get("COLOR_FINDER_API_SECRET")
