import os
from flask import Flask, render_template, jsonify, request

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

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
