import unittest

from .. import create_app, db
from ..models import ForumPost

from ..api.discussion_forum import bad_word_check
from flask_jwt_extended import jwt_required

import mock


class TestForum(unittest.TestCase):

    def initiate(self):
        app = create_app()
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()
        self.sample_data = {
            {
                "title": "standard_sample",
                "description": "description1",
                "content_uri": "https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title": "sample_without_description",
                "description": "",
                "conent_uri": "https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title": "sample_with_wrong_uri",
                "description": "description2",
                "content_uri": "gibberish"
            },
            {
                "title": "sample_with_bad_words",
                "description": "fuck this shit i'm out",
                "content_uri": "https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title": "sample_without_image",
                "description": "description3",
                "content_uri": ""
            },
            {
                "title": "sample_with_only_title",
                "description": "",
                "content_uri": ""
            },
            {
                "title": "",
                "description": "sample with only description",
                "content_uri": ""
            },
            {
                "title": "",
                "description": "",
                "content_uri": "https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
            },
            {
                "title": "",
                "description": "",
                "content_uri": ""
            }
        }

        self.post_ids = []
        for json in self.sample_data:
            response = self.make_post_request(json)

            self.assertEqual()

    def make_post_request(self, json):
        mock.patch()
        return self.client.post("/api/forum_post/", json=json, content_type="application/json; charset=UTF-8")

    def mock_jwt_required(realm):
        return

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_to_forum(self):
        response = self.make_post_request(self.sample_data[0])
        self.assertEqual(response.status, "201 CREATED")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_without_description(self):
        response = self.make_post_request(self.sample_data[1])
        self.assertEqual(response.status, "400 BAD REQUEST")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_nonexisting_uri(self):
        response = self.make_post_request(self.sample_data[2])
        self.assertEqual(response.status, "201 CREATED")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_censor(self):
        response = self.make_post_request(self.sample_data[3])
        self.assertEqual(response.status, "201 CREATED")
        self.assertEqual("**** this **** i'm out",
                         response.json()["description"])

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_without_uri(self):
        response = self.make_post_request(self.sample_data[4])
        self.assertEqual(response.status, "201 CREATED")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_title_only(self):
        response = self.make_post_request(self.sample_data[5])
        self.assertEqual(response.status, "400 BAD REQUEST")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_description_only(self):
        response = self.make_post_request(self.sample_data[6])
        self.assertEqual(response.status, "201 CREATED")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_uri_only(self):
        response = self.make_post_request(self.sample_data[7])
        self.assertEqual(response.status, "400 BAD REQUEST")

    @mock.patch('flask_jwt_extended.jwt_required', side_effect=mock_jwt_required)
    def test_posting_with_nothing(self):
        response = self.make_post_request(self.sample_data[8])
        self.assertEqual(response.status, "400 BAD REQUEST")

    def tearDown(self):
        db.drop_all()
        self.ctx.pop()

    if __name__ == "__main__":
        unittest.main()
