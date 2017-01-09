# maintainer yellowkingdom
# we use the alpine,keep small
FROM python:2.7-alpine
MAINTAINER yellowkingdom@live.cn

# init the openssh service
RUN apk add --no-cache openssh \
build-base \
python-dev \
libxml2 \
libxml2-dev \
libxml2-utils \
py-libxml2 \
libxslt \
libxslt-dev \
py-lxml \
py-libxslt \
gfortran \
Cpython

COPY . /app/sshrun/
RUN chmod +x /app/sshrun/run.sh
WORKDIR /app/sshrun/

#install the python libs
RUN pip install --no-cache-dir -r /app/sshrun/requirements.txt
RUN pip install --no-cache-dir tushare

EXPOSE 22 8000
ENTRYPOINT ["./run.sh"]
