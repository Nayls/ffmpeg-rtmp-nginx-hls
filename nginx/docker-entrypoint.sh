#!/usr/bin/env bash
set -Eeo pipefail

if [[ "$1" = 'app' ]]; then
    envsubst < ${APP_HOME}/html/live.html > ${APP_HOME}/html/live.html.tmp && mv ${APP_HOME}/html/live.html.tmp ${APP_HOME}/html/live.html
    envsubst < ${APP_HOME}/html/obs.html > ${APP_HOME}/html/obs.html.tmp && mv ${APP_HOME}/html/obs.html.tmp ${APP_HOME}/html/obs.html

    exec ${APP_HOME}/sbin/nginx -g "daemon off;"
else
    exec "$@"
fi
