FROM alpine:3.13
#docker run -i -t alpine:latest /bin/ash

#ARG BUILD_DATE
#ARG VERSION
#LABEL build_date="${BUILD_DATE}"
LABEL version="0.1.0"

RUN \
 echo "**** Install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies --upgrade \
    build-base \
    git \
    jpeg-dev \
    musl-dev \
    python3-dev \
    zlib-dev && \
 #apk add --no-cache --virtual=build-dependencies --upgrade build-base git jpeg-dev musl-dev python3-dev zlib-dev 
 echo "**** Install runtime packages ****" && \
 apk add --no-cache --upgrade \
    bash \
    exiftool \
    perl-image-exiftool \
    python3 \
    python3-dev \
    py3-pip \
    su-exec && \
 #apk add --no-cache --upgrade bash exiftool perl-image-exiftool python3 python3-dev py3-pip su-exec && \
 echo "**** Install Elodie ***" && \
 git clone https://github.com/jmathai/elodie.git /app && \
    pip install -r /app/requirements.txt --ignore-installed six  && \
    ln -s /app/elodie.py /usr/bin/elodie && \
    ln -s /usr/bin/python3 /usr/bin/python && \
 #git clone https://github.com/jmathai/elodie.git /app 
 #pip install -r /app/requirements.txt --ignore-installed six 
 #ln -s /app/elodie.py /usr/bin/elodie 
 #ln -s /usr/bin/python3 /usr/bin/python
 echo "**** cleanup ****" && \
 apk del --purge \
    build-dependencies && \
 rm -rf \
    /root/.cache \
    /tmp/*

#ENV ELODIE_APPLICATION_DIRECTORY="/config"

#ADD entrypoint.sh /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["/bin/bash"]
#CMD [ "--help" ]
