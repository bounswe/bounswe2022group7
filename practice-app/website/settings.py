import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

WEATHER_API_KEY = os.environ.get("WEATHER_API_KEY")