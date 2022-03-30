#!/usr/bin/env bash
set -Eeo pipefail

if [[ "$1" = 'app' ]]; then
    sed -i "s~%HLS_SERVER_HOST%~${HLS_SERVER_HOST}~g" /usr/local/nginx/html/live.html
    sed -i "s~%RTMP_SERVER_HOST%~${RTMP_SERVER_HOST}~g" /usr/local/nginx/html/obs.html
    sed -i "s~%RTMP_STREAM_KEY%~${RTMP_STREAM_KEY}~g" /usr/local/nginx/html/obs.html

    exec /usr/local/nginx/sbin/nginx -g "daemon off;"
else
    exec "$@"
fi
