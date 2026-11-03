from flask import Flask, jsonify, render_template_string
from datetime import datetime, timezone

app = Flask(__name__)

PAGE = """
<!doctype html>
<title>Terraform + Flask on AWS</title>
<body style="font-family:sans-serif;max-width:640px;margin:60px auto;line-height:1.6">
  <h1>Hello from AWS!</h1>
  <p>This Flask app runs on an EC2 server created with <b>Terraform</b> (Infrastructure as Code).</p>
  <p>Server time (UTC): {{ now }}</p>
  <p><a href="/health">/health</a></p>
</body>
"""

@app.route("/")
def home():
    return render_template_string(PAGE, now=datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S"))

@app.route("/health")
def health():
    return jsonify(status="ok")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
