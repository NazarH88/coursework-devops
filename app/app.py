from flask import Flask, jsonify, render_template
import os
import socket
import datetime

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")
APP_ENV = os.environ.get("APP_ENV", "development")


@app.route("/")
def index():
    return render_template("index.html", version=APP_VERSION, env=APP_ENV)


@app.route("/api/health")
def health():
    return jsonify({
        "status": "ok",
        "version": APP_VERSION,
        "environment": APP_ENV,
        "hostname": socket.gethostname(),
        "timestamp": datetime.datetime.utcnow().isoformat() + "Z"
    })


@app.route("/api/info")
def info():
    return jsonify({
        "app": "DevOps Coursework — Flask Demo",
        "version": APP_VERSION,
        "environment": APP_ENV,
        "hostname": socket.gethostname(),
        "python_path": os.sys.executable
    })


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=(APP_ENV == "development"))
