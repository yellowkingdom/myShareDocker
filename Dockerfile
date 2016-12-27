# maintainer yellowkingdom
# we use the alpine,keep small
FROM python:2.7-alpine
MAINTAINER yellowkingdom@live.cn
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories

# init the openssh service
RUN apk add --no-cache openssh,libxml2,py-lxml
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
