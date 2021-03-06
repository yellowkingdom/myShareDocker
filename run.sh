#!/bin/sh

# refer : https://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html
# refer : https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/uwsgi/
KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE

chmod 600 /root/.ssh/authorized_keys

# create a project
#cd /app/sshrun
#/usr/bin/python /usr/bin/django-admin.py startproject mysite

# setup uwsgi dependences
#mkdir -p /var/log/uwsgi/
#touch /var/log/uwsgi/mysite.log
#start uwsgi
#/usr/sbin/uwsgi --ini /app/sshrun/uwsgi.ini

# nginx settings
adduser -D -u 1000 -g 'www' www
cp -f /app/sshrun/nginx.conf /etc/nginx/nginx.conf

#test
#chown -R www:www /var/lib/nginx
#chown -R www:www /app/sshrun/mysite
#mkdir -p /var/run/
#touch /var/run/nginx.pid

#/usr/sbin/nginx -c /etc/nginx/nginx.conf  & /usr/sbin/sshd -D -f /app/sshrun/sshd_config
#echo "ALLOWED_HOSTS = ['*']" >> /app/sshrun/mysite/mysite/settings.py
/usr/bin/python /app/sshrun/mysite/manage.py runserver 0.0.0.0:8000 & /usr/sbin/sshd -D -f /app/sshrun/sshd_config
