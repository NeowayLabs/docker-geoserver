FROM java:openjdk-8-jre-alpine

EXPOSE 8080

ARG GEOSERVER_VERSION=2.14.0
ARG GEOSERVER_PLUGIN_VERSION=2.14.x

ENV JAVA_OPTS -Xms128m -Xmx512m -XX:MaxPermSize=512m
ENV ADMIN_PASSWD geoserver

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

RUN apk add --update openssl
RUN wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip \
         -O /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip && \
    mkdir /opt && \
    unzip /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip -d /opt && \
    cd /opt && \
    ln -s geoserver-${GEOSERVER_VERSION} geoserver && \
    rm /tmp/geoserver-${GEOSERVER_VERSION}-bin.zip
RUN mkdir geoserver-backup-plugin && cd geoserver-backup-plugin && \
    wget -c https://build.geoserver.org/geoserver/2.14.x/community-2019-03-15/geoserver-2.14-SNAPSHOT-backup-restore-plugin.zip && \
    unzip geoserver-2.14-SNAPSHOT-backup-restore-plugin.zip && \
    rm geoserver-2.14-SNAPSHOT-backup-restore-plugin.zip
RUN cp /geoserver-backup-plugin/* /opt/geoserver/webapps/geoserver/WEB-INF/lib/ && \
    rm -rf /geoserver-backup-plugin
ADD my_startup.sh /opt/geoserver/bin/my_startup.sh
RUN chmod +x /opt/geoserver/bin/my_startup.sh
WORKDIR /opt/geoserver
CMD ["sh", "/opt/geoserver/bin/my_startup.sh"]


