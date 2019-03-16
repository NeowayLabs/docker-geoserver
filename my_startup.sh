#!/bin/bash

# turn on bash's job control
# set -m

# Start the primary process and put it in the background
/bin/sh /opt/geoserver/bin/startup.sh 

if [ -n "${ADMIN_PASSWD}" ]; then
    cat > /opt/geoserver/data_dir/security/usergroup/default/users.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<userRegistry version="1.0" xmlns="http://www.geoserver.org/security/users">
<users><user enabled="true" name="admin" password="plain:${ADMIN_PASSWD}"/></users>
<groups/></userRegistry>
EOF
fi

/bin/sh /opt/geoserver/bin/startup.sh 
