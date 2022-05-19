import sys

sys.path.append('./website') #to run the test without import errors, one should call from one directory above this line's directory
sys.path.append('.')

from website import create_app, db
import unittest

TEST_DB_NAME = "test_database.db"

class TestForum(unittest.TestCase):
    def setUp(self):
        app = create_app()
        app.testing = True
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()
        self.sample_data = [
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
        ]
        
        self.user_data = {
            "email": "user@mail.com",
            "password": "password",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": False
        }
        
        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type = "application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")
        

    def make_post_request(self, json):
        return self.client.post("/api/forum_post/", json=json, content_type="application/json; charset=UTF-8", 
                                headers = {"Authorization": "Bearer " + self.user_access_token})

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_to_forum(self):
        response = self.make_post_request(self.sample_data[0])
        self.assertEqual(response.status, "201 CREATED")
        
    def test_posting_to_forum_unauthorized(self):
        response = self.client.post("/api/forum_post/", json=self.sample_data[0], content_type="application/json; charset=UTF-8")
        self.assertEqual(response.status, "401 UNAUTHORIZED")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_without_description(self):
        response = self.make_post_request(self.sample_data[1])
        self.assertEqual(response.status, "400 BAD REQUEST")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_nonexisting_uri(self):
        response = self.make_post_request(self.sample_data[2])
        self.assertEqual(response.status, "201 CREATED")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_censor(self):
        response = self.make_post_request(self.sample_data[3])
        self.assertEqual(response.status, "201 CREATED")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_without_uri(self):
        response = self.make_post_request(self.sample_data[4])
        self.assertEqual(response.status, "201 CREATED")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_title_only(self):
        response = self.make_post_request(self.sample_data[5])
        self.assertEqual(response.status, "400 BAD REQUEST")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_description_only(self):
        response = self.make_post_request(self.sample_data[6])
        self.assertEqual(response.status, "201 CREATED")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_uri_only(self):
        response = self.make_post_request(self.sample_data[7])
        self.assertEqual(response.status, "400 BAD REQUEST")

    # @mock.patch('jwt.user_token_required', side_effect=mock_jwt_required)
    def test_posting_with_nothing(self):
        response = self.make_post_request(self.sample_data[8])
        self.assertEqual(response.status, "400 BAD REQUEST")    

    def tearDown(self):
        db.drop_all()
        self.ctx.pop()

    if __name__ == "__main__":
        unittest.main()