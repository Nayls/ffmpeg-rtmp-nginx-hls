FROM debian:bullseye as build-image

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
    ./configure --prefix=/usr/local/nginx --with-http_ssl_module --add-module=../modules/nginx-rtmp-module-${NGINX_MODULES_RTMP} && \
    make -j 1 && \
    make install && \
    \
    chmod +x /usr/local/nginx/sbin/nginx


FROM debian:bullseye as runtime-image

COPY --from=build-image /usr/local/nginx /usr/local/nginx
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/player.html /usr/local/nginx/html/index.html

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh /

EXPOSE 8080
EXPOSE 1935
STOPSIGNAL SIGQUIT

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "app" ]
