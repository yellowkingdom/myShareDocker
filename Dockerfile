# maintainer yellowkingdom
# we use the alpine,keep small
FROM python:2.7
MAINTAINER yellowkingdom@live.cn
RUN sed -i 's/httpredir.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# init the openssh service
RUN apt-get update && apt-get install -y --no-install-recommends openssh \
build-essential \
libxml2-dev \
libxslt-dev \
python-dev

COPY . /app/sshrun/
RUN chmod +x /app/sshrun/run.sh
WORKDIR /app/sshrun/
RUN addgroup ssh
RUN adduser ssh -D -s /bin/sh -G ssh

# change the pip source to aliyun
RUN mkdir /root/.pip
RUN echo "[global]\
 \
index-url = http://mirrors.aliyun.com/pypi/simple/\
 \
[install]\
trusted-host=mirrors.aliyun.com" > /root/.pip/pip.conf

#install the python libs
RUN pip install lxml
RUN pip install numpy
RUN pip install requests
RUN pip install pandas

EXPOSE 22
ENTRYPOINT ["./run.sh"]
