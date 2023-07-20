FROM docker.osgeo.org/geoserver:2.23.1

#
# Set GeoServer version and data directory
#
ARG GEOSERVER_VERSION=2.23
ARG PATCH_NUMBER=1
ARG CORS_ENABLED=true
ARG CORS_ALLOWED_METHODS=GET,POST,PUT,HEAD,OPTIONS
ENV GEOSERVER_DATA_DIR="/geoserver_data"

#
# Download and install GeoServer
#
RUN apt update && \
    apt upgrade -y && \
    apt install unzip

# Download the backup/restore plugin
RUN mkdir geoserver-backup-plugin && cd geoserver-backup-plugin && \
    wget -c https://build.geoserver.org/geoserver/${GEOSERVER_VERSION}.x/community-latest/geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip && \
    unzip geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip && \
    rm geoserver-${GEOSERVER_VERSION}-SNAPSHOT-backup-restore-plugin.zip

# Place the backup/restore plugin to be installed on startup
RUN mkdir /opt/additional_libs && \
    cp geoserver-backup-plugin/* /opt/additional_libs/ && \
    rm -rf geoserver-backup-plugin

ENV JAVA_OPTS="-Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true"

