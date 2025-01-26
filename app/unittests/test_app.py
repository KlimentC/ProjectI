import unittest
from unittest.mock import patch, MagicMock

from app.app import app


class TestApp(unittest.TestCase):
    def setUp(self):
        """Set up the test client before each test."""
        self.client = app.test_client()

    @patch("app.app.get_db_connection")
    def test_home_page(self, mock_get_db_connection):
        """Test the root route '/'."""

        mock_conn = MagicMock()
        mock_cursor = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_cursor.fetchall.return_value = [(1, "John Doee", "2021-01-01")]
        mock_get_db_connection.return_value = mock_conn

        mock_get_db_connection()

        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Welcome to My App!", response.data)
        self.assertIn(b"John Doe", response.data)
        self.assertIn(b"2021-01-01", response.data)

    @patch("app.app.get_db_connection")
    def test_about_page(self, mock_get_db_connection):
        """Test the '/about' route."""
        response = self.client.get("/about")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"About This App", response.data)

    def test_api_greet_default(self):
        """Test the '/api/greet' route with no name parameter."""
        response = self.client.get("/api/greet")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"message": "Hello, World!"})

    def test_api_greet_with_name(self):
        """Test the '/api/greet' route with a name parameter."""
        response = self.client.get("/api/greet?name=Alice")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"message": "Hello, Alice!"})

    def test_submit_form(self):
        """Test the '/submit' route with POST method."""
        response = self.client.post("/submit", data={"name": "Bob"})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Hello, Bob!", response.data)

    def test_submit_form_default(self):
        """Test the '/submit' route with POST method without a name."""
        response = self.client.post("/submit")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Hello, Guest!", response.data)


if __name__ == "__main__":
    unittest.main()
