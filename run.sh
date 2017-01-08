#!/bin/sh

KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE


chmod 600 /root/.ssh/authorized_keys

/usr/sbin/sshd -D -f /app/sshrun/sshd_config

mkdir -p /root/web/ && cd /root/web/
django-admin startproject mysharesite
cd /root/web/mysharesite
python manage.py runserver 0.0.0.0:8000
