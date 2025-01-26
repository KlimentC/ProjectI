import os
import json
import psycopg2
import boto3
from flask import Flask, render_template, jsonify, request
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

app = Flask(__name__)


def get_secret(secret_name):
    session = boto3.session.Session()
    client = session.client(service_name="secretsmanager", region_name="us-east-1")

    try:
        response = client.get_secret_value(SecretId=secret_name)
        secret = response["SecretString"]
        return secret
    except (NoCredentialsError, PartialCredentialsError) as e:
        print(f"Error retrieving credentials: {str(e)}")
        return None


def get_db_connection():
    secret = get_secret("postgres-credentials")

    if secret:
        secret_dict = json.loads(secret)
        db_user = secret_dict.get("username")
        db_password = secret_dict.get("password")
    else:
        db_user = os.environ.get("DB_USER", "admin")
        db_password = os.environ.get("DB_PASSWORD", "no")

    conn = psycopg2.connect(
        host=os.environ.get("DB_HOST", "localhost"),
        dbname=os.environ.get("DB_NAME", "personalinfo"),
        user=db_user,
        password=db_password,
    )
    return conn


@app.route("/")
def home():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM info_table")
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("index.html", data=data)


@app.route("/api/greet", methods=["GET"])
def api_greet():
    name = request.args.get("name", "World")
    return jsonify({"message": f"Hello, {name}!"})


@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/submit", methods=["POST"])
def submit():
    name = request.form.get("name", "Guest")
    return render_template("greet.html", name=name)


if __name__ == "__main__":
    app.run(port=os.environ.get("PORT", 3000), host="0.0.0.0")
