import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

WEATHER_API_KEY = os.environ.get("WEATHER_API_KEY")
SIMILARITY_SCORE_API_KEY = os.environ.get("SIMILARITY_SCORE_API_KEY")
COLOR_FINDER_API_KEY =  os.environ.get("COLOR_FINDER_API_KEY")
COLOR_FINDER_API_SECRET = os.environ.get("COLOR_FINDER_API_SECRET")
