FROM java:openjdk-8-jre-alpine

EXPOSE 8080

ARG GEOSERVER_VERSION=2.14.0

ENV JAVA_OPTS -Xms128m -Xmx512m -XX:MaxPermSize=512m
ENV ADMIN_PASSWD geoserver

ADD install.sh install.sh
RUN sh install.sh && rm install.sh
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION eu-west-1

RUN apk add --update openssl
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip \
         -O /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip && \
    mkdir /opt && \
    unzip /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip -d /opt && \
    cd /opt && \
    ln -s geoserver-${GEOSERVER_VERSION} geoserver && \
    rm /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip

ADD backup.sh /opt/geoserver/bin/backup.sh
RUN chmod +x /opt/geoserver/bin/backup.sh
ADD my_startup.sh /opt/geoserver/bin/my_startup.sh
RUN chmod +x /opt/geoserver/bin/my_startup.sh
WORKDIR /opt/geoserver
CMD ["sh", "/opt/geoserver/bin/my_startup.sh"]

