import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

TRANSLATE_API_KEY = os.environ.get("TRANSLATE_API_KEY")