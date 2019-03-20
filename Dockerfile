FROM tomcat:9-jre8

#
# Set GeoServer version and data directory
#
ARG GEOSERVER_VERSION=2.14
ARG PATCH_NUMBER=2
ENV GEOSERVER_DATA_DIR="/geoserver_data/data"

#
# Download and install GeoServer
#
RUN wget --no-check-certificate --progress=bar:force:noscroll \
    https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}.${PATCH_NUMBER}/geoserver-${GEOSERVER_VERSION}.${PATCH_NUMBER}-war.zip && \
    unzip -q geoserver-${GEOSERVER_VERSION}.${PATCH_NUMBER}-war.zip \
    && mv geoserver.war webapps/ \
    && rm geoserver-${GEOSERVER_VERSION}.${PATCH_NUMBER}-war.zip \
    && cd webapps \
    && unzip -q geoserver.war -d geoserver \
    && rm geoserver.war \
    && mkdir -p $GEOSERVER_DATA_DIR

RUN mkdir geoserver-backup-plugin && cd geoserver-backup-plugin && \
    wget -c https://build.geoserver.org/geoserver/${GEOSERVER_VERSION}.x/community-latest/geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip && \
    unzip geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip && \
    rm geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip

RUN cp geoserver-backup-plugin/* webapps/geoserver/WEB-INF/lib/ && \
    rm -rf geoserver-backup-plugin

RUN mkdir geogig-plugin  && cd geogig-plugin  && \
    wget -c https://build.geoserver.org/geoserver/${GEOSERVER_VERSION}.x/community-latest/geoserver-${GEOSERVER_VERSION}-SNAPSHOT-geogig-plugin.zip  && \
    unzip geoserver-${GEOSERVER_VERSION}-SNAPSHOT-geogig-plugin.zip  && \
    rm geoserver-${GEOSERVER_VERSION}-SNAPSHOT-geogig-plugin.zip

RUN cp geogig-plugin/* webapps/geoserver/WEB-INF/lib/ && \
    rm -rf geogig-plugin

ENV JAVA_OPTS="-Djava.awt.headless=true -XX:MaxPermSize=512m -XX:PermSize=256m -Xms512m -Xmx2048m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true"