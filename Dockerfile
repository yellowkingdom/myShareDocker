# maintainer yellowkingdom
# we use the alpine,keep small
FROM python:2.7
MAINTAINER yellowkingdom@live.cn

# init the openssh service
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openssh-server \
apt-transport-https \
ca-certificates \
build-essential \
python-dev \
libxslt1.1 \
libxslt-dev \
python-lxml \
python-libxslt1

COPY . /app/sshrun/
RUN chmod +x /app/sshrun/run.sh
WORKDIR /app/sshrun/

#install the python libs
RUN pip install --no-cache-dir -r /app/sshrun/requirements.txt
RUN pip install --no-cache-dir tushare

EXPOSE 22 8000
ENTRYPOINT ["./run.sh"]
