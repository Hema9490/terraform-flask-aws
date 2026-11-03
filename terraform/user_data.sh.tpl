#!/bin/bash
dnf install -y python3-pip

mkdir -p /opt/flaskapp
echo "${app_b64}" | base64 -d > /opt/flaskapp/app.py
echo "${req_b64}" | base64 -d > /opt/flaskapp/requirements.txt

pip3 install -r /opt/flaskapp/requirements.txt

cat > /etc/systemd/system/flaskapp.service <<'UNIT'
[Unit]
Description=Flask app with gunicorn
After=network.target

[Service]
WorkingDirectory=/opt/flaskapp
ExecStart=/usr/local/bin/gunicorn -b 0.0.0.0:80 app:app
Restart=always

[Install]
WantedBy=multi-user.target
UNIT

systemctl daemon-reload
systemctl enable --now flaskapp
