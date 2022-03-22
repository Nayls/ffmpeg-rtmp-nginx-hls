#!/usr/bin/env bash
set -Eeo pipefail

if [[ "$1" = 'app' ]]; then
    sed -i "s~%RTMP_SERVER_HOST%~${RTMP_SERVER_HOST}~g" /usr/local/nginx/html/index.html

    exec /usr/local/nginx/sbin/nginx -g "daemon off;"
else
    exec "$@"
fi
