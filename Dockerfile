FROM neowaylabs/java8:latest

MAINTAINER Rodrigo Zanato Tripodi <rodrigo.tripodi@neoway.com.br>

EXPOSE 8080

ENV JAVA_OPTS -Xms128m -Xmx512m -XX:MaxPermSize=512m
ENV ADMIN_PASSWD geoserver

RUN apt-get install -qqy unzip && \
    wget -c http://downloads.sourceforge.net/project/geoserver/GeoServer/2.6.1/geoserver-2.6.1-bin.zip \
         -O /tmp/geoserver-2.6.1-bin.zip && \
    unzip /tmp/geoserver-2.6.1-bin.zip -d /opt && \
    cd /opt && \
    ln -s geoserver-2.6.1 geoserver

RUN sed -i "s/digest1\:D9miJH\/hVgfxZJscMafEtbtliG0ROxhLfsznyWfG38X2pda2JOSV4POi55PQI4tw/plain:$ADMIN_PASSWD/g" \
        /opt/geoserver/data_dir/security/usergroup/default/users.xml

ADD 01_geoserver.sh /etc/my_init.d/01_geoserver.sh
RUN chmod +x /etc/my_init.d/01_geoserver.sh

CMD ["/sbin/my_init"]

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
