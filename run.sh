#!/bin/sh

KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa
#KEYFILE=/etc/ssh/ssh_host_rsa_key
#KEYFILE=/home/ssh/.ssh/id_rsa

#mkdir -p /root/.ssh/
#touch /root/.ssh/authorized_keys

if [ ! -f $KEYFILE ]; then
  $KEYGEN -q -t rsa -N "" -f $KEYFILE
  cat $KEYFILE.pub >> /root/.ssh/authorized_keys
fi

echo "== Use this private key to log in =="
cat $KEYFILE


chmod 600 /root/.ssh/authorized_keys

/usr/sbin/sshd -D -f /app/sshrun/sshd_config
