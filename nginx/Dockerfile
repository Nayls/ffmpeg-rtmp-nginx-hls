ARG APP_HOME="/usr/local/nginx"

FROM debian:bullseye as build-image

ARG APP_HOME

RUN apt-get update && \
    \
    apt-get install -y \
        git \
        build-essential \
        ffmpeg \
        libpcre3 \
        libpcre3-dev \
        libssl-dev \
        zlib1g-dev

ARG NGINX_VERSION=1.20.2
ARG NGINX_MODULES_RTMP=1.2.2

WORKDIR /build

COPY modules/nginx-rtmp-module-${NGINX_MODULES_RTMP} ./modules/nginx-rtmp-module-${NGINX_MODULES_RTMP}
COPY nginx-${NGINX_VERSION} ./nginx-${NGINX_VERSION}

RUN cd nginx-${NGINX_VERSION} && \
    chmod +x configure && \
    ./configure --prefix=${APP_HOME} --with-http_ssl_module --add-module=../modules/nginx-rtmp-module-${NGINX_MODULES_RTMP} && \
    make -j 1 && \
    make install && \
    \
    chmod +x ${APP_HOME}/sbin/nginx


FROM debian:bullseye as runtime-image

ARG APP_HOME
ENV APP_HOME=${APP_HOME}

RUN apt-get update && \
    apt-get install -y \
        gettext-base \
        && \
    \
    apt-get clean cache && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build-image ${APP_HOME} ${APP_HOME}
COPY conf/ ${APP_HOME}/conf/
COPY html/ ${APP_HOME}/html/

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh /

EXPOSE 8080
EXPOSE 1935
STOPSIGNAL SIGQUIT

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "app" ]
