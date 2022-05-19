import unittest
import requests

from .. import create_app, db
from ..models import User, Artist

from ..api.auth import signup, login


class TestAuth(unittest.TestCase):

    def setUp(self):
        app = create_app(testing=True)
        self.context = app.app_context()
        self.context.push()
        self.client = app.test_client()

        self.user = requests.get(
            'https://randomuser.me/api/'
        ).json()['results'][0]

        self.user = {
            'email': self.user['email'],
            'password': self.user['login']['password'],
            'first_name': self.user['name']['first'],
            'last_name': self.user['name']['last'],
            'is_artist': False
        }

        self.response = self.client.post(
            "/api/signup",
            json=self.user,
            content_type='application/json; charset=UTF-8'
        )

    def test_signup_successful(self):
        self.assertIn('201', self.response.status)

    def test_signup_user_already_exists(self):
        response2 = self.client.post(
            'api/signup',
            json=self.user,
            content_type='application/json; charset=UTF-8'
        )
        self.assertIn('409', response2.status)

    def test_login_successfull(self):
        response2 = self.client.post(
            "/api/login",
            json={
                'email': self.user['email'],
                'password': self.user['password']
            },
            content_type='application/json; charset=UTF-8'
        )
        token = response2.json.get('access_token')

        self.assertIsNotNone(token)
        self.assertIn('200', response2.status)

    def test_login_incorrect_credentials(self):
        response2 = self.client.post(
            "/api/login",
            json={
                'email': 'incorrect@email.com',
                'password': 'crazy_wrong_password_666'
            },
            content_type='application/json; charset=UTF-8'
        )
        token = response2.json.get('access_token')
        error_msg = response2.json.get('error')

        self.assertIsNone(token)
        self.assertEqual(error_msg, 'Incorrect email or password.')
        self.assertIn('401', response2.status)

    def tearDown(self):
        db.drop_all()
        self.context.pop()


if __name__ == "__main__":
    unittest.main()
