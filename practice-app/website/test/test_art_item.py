import unittest

import datetime

from .. import create_app, db
from ..models import ArtItem

from ..api.art_item import name_exists, create_art_item_record

TEST_DB_NAME = "test_database.db"


class TestArtItem(unittest.TestCase):

    def setUp(self):

        app = create_app(TEST_DB_NAME)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        # create the first artist object (artist #1) in order to set it
        #  as the owner of all pre-created art items
        self.initial_artist_data = {
            "email": "first_creator@mail.com",
            "password": "first",
            "first_name": "FirstCreator",
            "last_name": "TestArtist",
            "is_artist": "on"
        }
        response = self.client.post("/api/signup",
                                    json=self.initial_artist_data,
                                    content_type="application/json; charset=UTF-8")
        self.assertEqual(response.status, "201 CREATED")

        # the artist user to be used
        self.artist_data = {
            "email": "artist@mail.com",
            "password": "pass",
            "first_name": "ArtistName",
            "last_name": "Test",
            "is_artist": "on"
        }

        # the regular user to be used
        self.user_data = {
            "email": "user@mail.com",
            "password": "pass",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": None
        }

        # correctly built art item objects
        self.corrrect_data = [
            {
                "id": 1,
                "name": "Art Item 1",
                "description": "Description 1",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 1)
            },
            {
                "id": 2,
                "name": "Art Item 2",
                "description": "Description 2",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 2)
            },
            {
                "id": 3,
                "name": "Art Item 3",
                "description": "Description 3",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 3)
            },
            {
                "id": 4,
                "name": "Art Item 4",
                "description": "Description 4",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 4)
            },
            {
                "id": 5,
                "name": "Art Item 5",
                "description": "Description 5",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 5)
            },
            {
                "id": 6,
                "name": "Art Item 6",
                "description": "Description 6",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 6)
            }
        ]

        # test data that will be used to make for creating new objects
        self.test_data = {
            "name": "Art Item 7 (Test Data)",
            "description": "Description 7 (Test Data)",
            "content_uri": "https://random.imagecdn.app/500/150"
        }

        # get access token for the test artist user
        response = self.client.post("/api/signup",
                                    json=self.artist_data,
                                    content_type="application/json; charset=UTF-8")

        self.artist_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        # get access token for the test regular user
        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type="application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        # push the prepared data to the database, and get the ID list
        self.art_item_ids = []
        for json in self.corrrect_data:
            art_item = create_art_item_record(json)
            db.session.add(art_item)
            db.session.commit()
            self.art_item_ids.append(json["id"])

    # helper functions to prepare the requests

    def make_create_art_item_request(self, json, token):
        return self.client.post("/api/art_item",
                                json=json,
                                content_type="application/json; charset=UTF-8",
                                headers={"Authorization": "Bearer %s" % token})

    def make_view_art_item_request(self, art_item_id):
        return self.client.get(f"/api/art_item/{art_item_id}")

    # test view_art_item API endpoint

    def test_view_existing_art_item(self):
        response = self.make_view_art_item_request(self.art_item_ids[0])
        self.assertEqual(response.status, "200 OK")

    def test_view_nonexisting_art_item(self):
        response = self.make_view_art_item_request(self.art_item_ids[-1] + 1)
        self.assertEqual(response.status, "404 NOT FOUND")

    # test create_art_item API endpoint

    def test_create_art_item_endpoint(self):
        response = self.make_create_art_item_request(
            self.test_data, self.artist_access_token)

        self.assertEqual(response.status, "201 CREATED")  # item created
        # its id is correct
        self.assertEqual(response.json["id"], self.art_item_ids[-1] + 1)

        # the element is in the database
        self.assertIsNotNone(ArtItem.query.get(response.json["id"]))
        self.assertIsNone(ArtItem.query.get(response.json["id"] + 1))

    def test_create_duplicate_art_item(self):
        response = self.make_create_art_item_request(
            self.corrrect_data[0], self.artist_access_token)
        self.assertEqual(response.status, "409 CONFLICT")

    def test_missing_field(self):
        keys = list(self.test_data.keys()).copy()
        for key in keys:
            value = self.test_data.pop(key)
            response = self.make_create_art_item_request(
                self.test_data, self.artist_access_token)
            self.test_data[key] = value

            self.assertEqual(response.status, "400 BAD REQUEST")
            self.assertTrue("error" in response.json)
            self.assertEqual(
                response.json["error"], "You have not provided some of the required fields. You are missing: {'%s'}" % key)

    def test_authorisation(self):
        response = self.make_create_art_item_request(
            self.test_data, self.user_access_token)
        self.assertEqual(response.status, "403 FORBIDDEN")

    # test art_item helper method

    def test_name_exists(self):
        self.assertTrue(name_exists("Art Item 1"))
        self.assertFalse(name_exists("A Name That Doesn't Exist"))

    def tearDown(self):
        db.drop_all()
        self.ctx.pop()


if __name__ == "__main__":
    unittest.main()
