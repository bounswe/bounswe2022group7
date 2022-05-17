import unittest

from .. import create_app, db
from ..models import Event

from ..api.event import title_exists, date_valid

TEST_DB_NAME = "test_database.db"

class TestEvent(unittest.TestCase):

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

        self.test_data = {
            "title": "Title 7",
            "description": "Description 7",
            "poster_link": "https://random.imagecdn.app/500/150",
            "date": "2022-05-07",
            "city": "City 7"
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

    # test create_event API endpoint

    def test_create_event_endpoint(self):
        response = self.make_create_event_request(self.test_data, self.artist_access_token)
        
        self.assertEqual(response.status, "201 CREATED")
        self.assertEqual(response.json["id"], self.event_ids[-1] + 1)

        self.assertIsNotNone(Event.query.get(response.json["id"]))
        self.assertIsNone(Event.query.get(response.json["id"] + 1))

    def test_create_duplicate_event(self):
        response = self.make_create_event_request(self.corrrect_data[0], self.artist_access_token)
        self.assertEqual(response.status, "409 CONFLICT")

    def test_missing_field(self):
        keys = list(self.test_data.keys()).copy()
        for key in keys:
            value = self.test_data.pop(key)
            response = self.make_create_event_request(self.test_data, self.artist_access_token)
            self.test_data[key] = value

            self.assertEqual(response.status, "400 BAD REQUEST")
            self.assertTrue("error" in response.json)
            self.assertEqual(response.json["error"], "You have not provided some of the required fields. You are missing: {'%s'}" % key)

    def test_date_format(self):
        
        wrong_dates = ["12-04-2007",
                       " 2005-04-03  ",
                       "2001.03.10",
                       "12.04.2007",
                       "Hello World!",
                       1234,
                       True]

        correct_date = self.test_data["date"]
        for date in wrong_dates:
            self.test_data["date"] = date
            response = self.make_create_event_request(self.test_data, self.artist_access_token)
            self.assertEqual(response.status, "400 BAD REQUEST")
            self.assertTrue("error" in response.json)
            self.assertEqual(response.json["error"], f"Date you have entered is not valid. Format is \"%Y-%m-%d\". You entered \"{date}\"." )

    def test_authorisation(self):

        response = self.make_create_event_request(self.test_data, self.user_access_token)
        self.assertEqual(response.status, "403 FORBIDDEN")
            
    # test view_event API endpoint

    def test_view_existing_event(self):
        response = self.make_view_event_request(self.event_ids[0])
        self.assertEqual(response.status, "200 OK")

    def test_view_nonexisting_event(self):
        response = self.make_view_event_request(self.event_ids[-1] + 1)
        self.assertEqual(response.status, "404 NOT FOUND")

    # test event helper methods

    def test_title_exists(self):
        self.assertTrue(title_exists("Title 1"))
        self.assertFalse(title_exists("Title That Doesn't Exist"))

    def test_date_valid(self):
        self.assertFalse(date_valid("2014-14-22"))
        self.assertTrue(date_valid("1020-4-14"))

    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()