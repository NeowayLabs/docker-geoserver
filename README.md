# docker-geoserver

[Geoserver](http://geoserver.org/) docker

## Environment settings

* JAVA_OPTS (default: -Xms128m -Xmx512m -XX:MaxPermSize=512m)
* ADMIN_PASSWD (default: geoserver)

## Exposed TCP ports

* 80: REST and Admin interface

## Internal volumes

* /geoserver_data: default application data directory

## Plugins installed

* backup/restore

## Docker compose

* Download data directory (e.g. kubectl -n geoserver-prod cp geoserver-prod/geoserver-prod-0:/geoserver_data/data .). Run via docker-compose -f docker-compose.yaml up --build 
* You can then find the geoserver at localhost/geoserver/
