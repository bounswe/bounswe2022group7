import unittest
from unittest import mock
from ..api.discussion_forum import translate

from .. import create_app, db
from ..models import PostComment

from ..api.event import title_exists, date_valid
import json

class TestPostComment(unittest.TestCase):

    def setUp(self):

        app = create_app()
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        self.correct_data = [
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
            },
            {
                "parent_post": "1",
                "text": "Hi",
                "content_uri": "https://random.imagecdn.app/500/150"
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

        self.comment_ids = []
        for json in self.correct_data:
            response = self.make_create_post_comment_request(json)

            self.assertEqual(response.status, "201 CREATED")
            self.comment_ids.append(response.json["id"])

    # This method will be used by the mock to replace requests.get
    def mocked_request_external(*args, **kwargs):
        class MockResponse:
            def __init__(self, json_data, status_code):
                self.json_data = json_data
                self.status_code = status_code

            def json(self):
                return self.json_data

        if args[0] == 'https://deep-translate1.p.rapidapi.com/language/translate/v2':
            return MockResponse(json.stringify({
                "data": {
                    "translations": {
                        "translatedText": "Merhaba"
                    }
                }
            }), 200)

        return MockResponse(None, 404)

    def make_create_post_comment_request(self, json):
        return self.client.post("/api/forum_comment_post",
                                json=json,
                                content_type="application/json; charset=UTF-8")

    def make_view_discussion_post_request(self, post_id):
        return self.client.get(f"/api//get_discussion_posts/{post_id}")

    # test create_event API endpoint

    @mock.patch('api.discussion_forum.translate.request', side_effect=mocked_request_external)
    def test_create_post_comment_endpoint(self):
        response = self.make_create_post_comment_request(self.test_data)
        
        self.assertEqual(response.status, "201 CREATED")
        self.assertEqual(response.json["id"], self.comment_ids[-1] + 1)

        self.assertIsNotNone(PostComment.query.get(response.json["id"]))
        self.assertIsNone(PostComment.query.get(response.json["id"] + 1))

    # def test_create_duplicate_event(self):
    #     response = self.make_create_post_comment_request(self.correct_data[0])
    #     self.assertEqual(response.status, "409 CONFLICT")

    # @mock.patch('api.discussion_forum.translate.request', side_effect=mocked_request_external)
    # def test_missing_field(self):
    #     keys = ["parent_post", "text"]
    #     for key in keys:
    #         value = self.test_data.pop(key)
    #         response = self.make_create_post_comment_request(self.test_data)
    #         self.test_data[key] = value

    #         self.assertEqual(response.status, "400 BAD REQUEST")
    #         self.assertTrue("error" in response.json)
    #         self.assertEqual(response.json["error"], "There was an error on key / value pairs on request body.")

    # @mock.patch('api.discussion_forum.translate.request', side_effect=mocked_request_external)
    # def test_empty_parent_post(self):
    #     value = self.test_data.pop("parent_post")
    #     self.test_data["parent_post"] = ""
    #     response = self.make_create_post_comment_request(self.test_data)
    #     self.test_data["parent_post"] = value
    #     self.assertEqual(response.status, "400 BAD REQUEST")
    #     self.assertTrue("error" in response.json)
    #     self.assertEqual(response.json["error"], "Parent post id is missing")



    # def test_date_format(self):
        
    #     wrong_dates = ["12-04-2007",
    #                    " 2005-04-03  ",
    #                    "2001.03.10",
    #                    "12.04.2007",
    #                    "Hello World!",
    #                    1234,
    #                    True]

    #     correct_date = self.test_data["date"]
    #     for date in wrong_dates:
    #         self.test_data["date"] = date
    #         response = self.make_create_post_comment_request(self.test_data)
    #         self.assertEqual(response.status, "400 BAD REQUEST")
    #         self.assertTrue("error" in response.json)
    #         self.assertEqual(response.json["error"], f"Date you have entered is not valid. Format is \"%Y-%m-%d\". You entered \"{date}\"." )
            
    # # test view_event API endpoint

    # def test_view_existing_event(self):
    #     response = self.make_view_event_request(self.comment_ids[0])
    #     self.assertEqual(response.status, "200 OK")

    # def test_view_nonexisting_event(self):
    #     response = self.make_view_event_request(self.comment_ids[-1] + 1)
    #     self.assertEqual(response.status, "404 NOT FOUND")

    # # test event helper methods

    # def test_title_exists(self):
    #     self.assertTrue(title_exists("Title 1"))
    #     self.assertFalse(title_exists("Title That Doesn't Exist"))

    # def test_date_valid(self):
        self.assertFalse(date_valid("2014-14-22"))
        self.assertTrue(date_valid("1020-4-14"))

    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()