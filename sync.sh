#!/bin/bash

#
#   sync dot files between current directory and ${HOME} directory
#
#


if [ $# -eq 0 ] ; then
    echo "${0} [toHome|fromHome]."
    exit 1
fi

if [ "toHome" != "$1" -a "fromHome" != "$1" ] ; then
    echo "unknown argument $1"
    exit 2
fi

if [ "$1" == "toHome" ] ; then
    for f in * ; do
	read -p "put ${f} to ${HOME} ? "
	if [ "y" == "${REPLY}" -o "Y" == "${REPLY}" ]; then
	    cp ${f} ${HOME}/.${f}
	fi
    done
else
    for f in ${HOME}/.* ; do
	if [ -f "${f}" ] ; then
	    read -p "get ${f} from ${HOME} ? "
	    if [ "y" == "${REPLY}" -o "Y" == "${REPLY}" ]; then
		dotname=$(basename ${f})
		name=${dotname:1}
		cp ${f} ${name}
	    fi
	fi
    done
fi

