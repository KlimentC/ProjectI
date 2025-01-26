import os
import json
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
        return json.loads(secret)
    except (NoCredentialsError, PartialCredentialsError) as e:
        print(f"Error retrieving credentials: {str(e)}")
        return None


@app.route("/")
def home():
    secret_name = "postgres-credentials"  # Replace with your secret name
    secret = get_secret(secret_name)

    if secret:
        db_user = secret.get("username")
        db_password = secret.get("password")
        return render_template("index.html", db_user=db_user, db_password=db_password)
    else:
        return "Error retrieving secrets", 500


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
