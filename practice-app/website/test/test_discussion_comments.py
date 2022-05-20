import unittest
# from unittest import mock
from ..api.discussion_forum import translate

from .. import create_app, db
from ..models import PostComment

from ..api.event import title_exists, date_valid
import json

class TestPostComment(unittest.TestCase):

    def setUp(self):

        app = create_app(testing=True)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        self.artist_data = {
            "email": "artist@mail.ru",
            "password": "password",
            "first_name": "Name",
            "last_name": "Surname",
            "is_artist": "on"
        }

        self.user_data = {
            "email": "user@mail.ru",
            "password": "password",
            "first_name": "UserName",
            "last_name": "UserSurname",
            "is_artist": None
        }


        self.correct_data = [
            {
                "parent_post": "1",
                "text": "Comment",
                "content_uri": "https://random.imagecdn.app/500/150"
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": ""
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
            }
        ]

        self.test_data = {
            "parent_post": "1",
            "text": "Hi",
            "content_uri": "https://random.imagecdn.app/500/150"
        }
        self.post_data = {
            "title": "sample",
            "description": "description",
            "content_uri": "https://www.hepsiburada.com/hayatburada/wp-content/uploads/2021/10/shutterstock_1024133086.jpg"
        }

        response = self.client.post("/api/signup",
                                    json=self.artist_data,
                                    content_type = "application/json; charset=UTF-8")
        self.artist_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type = "application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        post_response = self.client.post("/api/forum_post/", json=self.post_data, content_type="application/json; charset=UTF-8", 
                                headers = {"Authorization": "Bearer " + self.user_access_token})
        self.assertEqual(response.status, "201 CREATED")
        self.post_id = post_response.json["id"]

        self.comment_ids = []
        for json in self.correct_data:
            response = self.make_create_post_comment_request(json, self.user_access_token)

            self.assertEqual(response.status, "201 CREATED")
            self.comment_ids.append(response.json["id"])

    def make_create_post_comment_request(self, json, token):
        return self.client.post("/api/forum_comment_post",
                                json=json,
                                content_type="application/json; charset=UTF-8",
                                headers = {"Authorization": "Bearer %s" % token})

    def make_view_discussion_post_request(self, post_id):
        return self.client.get(f"/api/get_discussion_post/{post_id}")


    def test_create_post_comment_endpoint_user(self):
        response = self.make_create_post_comment_request(self.test_data, self.user_access_token)
        
        self.assertEqual(response.status, "201 CREATED")
        self.assertEqual(response.json["id"], self.comment_ids[-1] + 1)

        self.assertIsNotNone(PostComment.query.get(response.json["id"]))
        self.assertIsNone(PostComment.query.get(response.json["id"] + 1))

    def test_create_post_comment_endpoint_artist(self):
        response = self.make_create_post_comment_request(self.test_data, self.artist_access_token)
        
        self.assertEqual(response.status, "201 CREATED")
        self.assertEqual(response.json["id"], self.comment_ids[-1] + 1)

        self.assertIsNotNone(PostComment.query.get(response.json["id"]))
        self.assertIsNone(PostComment.query.get(response.json["id"] + 1))


    def test_missing_field(self):
        keys = list(self.test_data.keys()).copy()
        for key in keys:
            value = self.test_data.pop(key)
            response = self.make_create_post_comment_request(self.test_data, self.user_access_token)
            self.test_data[key] = value

            self.assertEqual(response.status, "400 BAD REQUEST")
            self.assertTrue("error" in response.json)
            self.assertEqual(response.json["error"], "There was an error on key / value pairs on request body.")

    def test_empty_parent_post(self):
        value = self.test_data.pop("parent_post")
        self.test_data["parent_post"] = ""
        response = self.make_create_post_comment_request(self.test_data, self.user_access_token)
        self.test_data["parent_post"] = value
        self.assertEqual(response.status, "400 BAD REQUEST")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], "Parent post id is empty")

    def test_empty_body_text(self):
        value = self.test_data.pop("text")
        self.test_data["text"] = ""
        response = self.make_create_post_comment_request(self.test_data, self.user_access_token)
        self.test_data["text"] = value
        self.assertEqual(response.status, "400 BAD REQUEST")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], "You have not provided body of the comment text")


    def test_authorization(self):
        response = self.client.post("/api/forum_comment_post",
                                json=self.test_data,
                                content_type="application/json; charset=UTF-8")
        self.assertEqual(response.status, "401 UNAUTHORIZED")
    
    def test_view_existing_forum_post(self):
        response = self.make_view_discussion_post_request(self.comment_ids[0])
        self.assertEqual(response.status, "200 OK")

    def test_view_nonexisting_forum_post(self):
        response = self.make_view_discussion_post_request(self.comment_ids[-1] + 1)
        self.assertEqual(response.status, "404 NOT FOUND")


    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()