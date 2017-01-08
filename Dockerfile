# maintainer yellowkingdom
# we use the alpine,keep small
FROM python:2.7
MAINTAINER yellowkingdom@live.cn
COPY . /app/sshrun/
COPY ./sources.list /etc/apt/sources.list

# init the openssh service
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server \
apt-utils \
apt-transport-https \
ca-certificates \
build-essential \
libxml2-dev \
libxslt-dev \
python-dev


RUN chmod +x /app/sshrun/run.sh
WORKDIR /app/sshrun/
#RUN adduser ssh -D -s /bin/sh -G ssh

# change the pip source to aliyun
RUN mkdir /root/.pip
RUN mkdir -p /home/ssh/.pip
RUN echo "[global]\
 \
index-url = http://mirrors.aliyun.com/pypi/simple/\
 \
[install]\
trusted-host=mirrors.aliyun.com" > /root/.pip/pip.conf
COPY /root/.pip/pip.conf /home/ssh/.pip

#install the python libs
RUN pip install lxml
RUN pip install numpy
RUN pip install requests
RUN pip install pandas

EXPOSE 22
ENTRYPOINT ["./run.sh"]
