#!/bin/bash

# turn on bash's job control
set -m

# Start the primary process and put it in the background
/bin/sh /opt/geoserver/bin/startup.sh 

# Start the helper process
# go-cron "*/3 * * * *" /bin/sh /opt/geoserver/bin/backup.sh 

# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns


# now we bring the primary process back into the foreground
# and leave it there
# fg %1

#!/bin/sh
# set -e

# if [ -n "${ADMIN_PASSWD}" ]; then
#     cat > /opt/geoserver/data_dir/security/usergroup/default/users.xml <<EOF
# <?xml version="1.0" encoding="UTF-8"?>
# <userRegistry version="1.0" xmlns="http://www.geoserver.org/security/users">
# <users><user enabled="true" name="admin" password="plain:${ADMIN_PASSWD}"/></users>
# <groups/></userRegistry>
# EOF
# fi
# exec go-cron "*/1 * * * *" /bin/sh /opt/geoserver/bin/backup.sh
# exec /bin/sh /opt/geoserver/bin/startup.sh
