#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
if [ ! -e /etc/hostname ]; then
    install -v -m644 /usr/share/defaults/etc/hostname /etc/hostname || exit 1
fi
if [ ! -e /etc/hosts ]; then
    install -v -m644 /usr/share/defaults/etc/hosts /etc/hosts || exit 1
fi
if [ ! -e /etc/fstab ]; then
    install -v -m644 /usr/share/defaults/etc/fstab /etc/fstab || exit 1
fi
if [ ! -e /etc/issue ]; then
    install -v -m644 /usr/share/defaults/etc/issue /etc/issue || exit 1
fi
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
