import unittest

from .. import create_app, db
from ..models import ForumPost

from ..api.discussion_forum import bad_word_check

class TestForum(unittest.TestCase):
    
    def initiate(self):
        app = create_app()
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()
        self.sample_data = {
            {
                "title":"standard_sample",
                "description":"description1",
                "content_uri":"https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title":"sample_without_description",
                "description":"",
                "conent_uri":"https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title":"sample_with_wrong_uri",
                "description":"description2",
                "content_uri":"gibberish"
            },
            {
                "title":"sample_with_bad_words",
                "description":"fuck this shit i'm out",
                "content_uri":"https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title":"sample_without_image",
                "description":"description3",
                "content_uri":""
            },
            {
                "title":"sample_with_only_title",
                "description":"",
                "content_uri":""
            },
            {
                "title":"",
                "description":"sample with only description",
                "content_uri":""
            },
            {
                "title":"",
                "description":"",
                "content_uri":"https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title":"",
                "description":"sample without title",
                "content_uri":""
            },
            {
                "title":"",
                "description":"",
                "content_uri":""
            }
        }
        
        
        