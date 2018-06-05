#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
if [ -n "${SHED_PKG_LOCAL_OPTIONS[bootstrap]}" ]; then
    chgrp -v utmp /var/log/lastlog &&
    chgrp -v -R shedmake /var/shedmake/repos/local &&
    chmod -v -R 775 /var/shedmake/repos/local &&
    chmod -v g+s /var/shedmake/repos/local &&
    chgrp -v shedmake /var/tmp/shedmake &&
    chmod -v 775 /var/tmp/shedmake || exit 1
fi
# HACK: Clean up duplicate symlink that results from installing over an existing system
if [ -L /run/run ]; then
    rm /run/run
fi
