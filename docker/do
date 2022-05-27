#!/bin/sh

set -o errexit

command=$1
shift

case "${command}" in
    enter)
        # Use POSIX time zone format so that we don't have to install
        # the Olson timezone databases in the Docker image.  The trick
        # is that we need to invert the hour offset from UTC for POSIX
        # time.
        TZ=$(date +%Z)$(( 12 - $(date -j -f %H%z 12+0000 +%k) ))
        exec docker exec -e TERM -e TERM_PROGRAM -e TZ=$TZ -i -t "$@" bash -l
        ;;

    start)
        export HOST_GID=$(id -g)
        export HOST_UID=$(id -u)
        exec docker-compose up -d "$@"
        ;;

    stop)
        export HOST_GID=$(id -g)
        export HOST_UID=$(id -u)
        exec docker-compose down
        ;;

    *)
        echo "${command}: unknown command" 2>&1
        exit 1
        ;;

esac
