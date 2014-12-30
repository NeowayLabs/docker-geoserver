# docker-geoserver

[Geoserver](http://geoserver.org/) docker

## Environment settings:

* JAVA_OPTS (default: -Xms128m -Xmx512m -XX:MaxPermSize=512m)
* ADMIN_PASSWD (default: geoserver)

## Exposed TCP ports:

* 8080: REST and Admin interface

## Internal volumes:

* /opt/geoserver/data_dir: default application data directory
* /opt/geoserver/data_dir/styles: styles (sld, xml, images) directory
