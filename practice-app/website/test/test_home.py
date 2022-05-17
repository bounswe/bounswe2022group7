import unittest

from .. import create_app, db

from ..api.home import *

TEST_DB_NAME = "test_database.db"

class TestHome(unittest.TestCase):

    def setUp(self):
        
        app = create_app(TEST_DB_NAME)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        self.artist_data = {
            "email": "artist@mail.com",
            "password": "pass",
            "first_name": "ArtistName",
            "last_name": "Test",
            "is_artist": "on"
        }

        self.user_data = {
            "email": "user@mail.com",
            "password": "pass",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": None
        }

        self.corrrect_data = [
            {
                "title": "Title 1",
                "description": "Description 1",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-01",
                "city": "City 1"
            },
            {
                "title": "Title 2",
                "description": "Description 2",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-02",
                "city": "City 2"
            },
            {
                "title": "Title 3",
                "description": "Description 3",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-03",
                "city": "City 3"
            },
            {
                "title": "Title 4",
                "description": "Description 4",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-04",
                "city": "City 4"
            },
            {
                "title": "Title 5",
                "description": "Description 5",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-05",
                "city": "City 5"
            },
            {
                "title": "Title 6",
                "description": "Description 6",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-06",
                "city": "City 6"
            }
        ]

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

        self.event_ids = []
        for json in self.corrrect_data:
            response = self.make_create_event_request(json, self.artist_access_token)

            self.assertEqual(response.status, "201 CREATED")
            self.event_ids.append(response.json["id"])

    def make_create_event_request(self, json, token):
        return self.client.post("/api/event",
                                json=json,
                                content_type="application/json; charset=UTF-8",
                                headers = {"Authorization": "Bearer %s" % token})

    def make_view_event_request(self, id):
        return self.client.get(f"/api/event/{id}")


    def test_view_home(self):

        response = self.client.get("/api/search")
        self.assertEqual(response.status, "200 OK")

        for i, (event_data, event_id) in enumerate(zip(self.corrrect_data, self.event_ids)):
            response_event_data = response.json["events"][-i-1]
            self.assertEqual(event_id, response_event_data["id"])
            for field in self.corrrect_data[0].keys():
                if field == "date":
                    continue
                self.assertEqual(event_data[field], response_event_data[field])

    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 