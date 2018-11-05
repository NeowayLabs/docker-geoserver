FROM java:openjdk-8-jre-alpine

MAINTAINER Rodrigo Zanato Tripodi <rodrigo.tripodi@neoway.com.br>

EXPOSE 8080

ARG GEOSERVER_VERSION=2.14.0

ENV JAVA_OPTS -Xms128m -Xmx512m -XX:MaxPermSize=512m
ENV ADMIN_PASSWD geoserver

RUN apk add --update openssl
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip \
         -O /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip && \
    mkdir /opt && \
    unzip /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip -d /opt && \
    cd /opt && \
    ln -s geoserver-${GEOSERVER_VERSION} geoserver && \
    rm /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip

ADD my_startup.sh /opt/geoserver/bin/my_startup.sh
RUN chmod +x /opt/geoserver/bin/my_startup.sh

WORKDIR /opt/geoserver
CMD ["/opt/geoserver/bin/my_startup.sh"]
