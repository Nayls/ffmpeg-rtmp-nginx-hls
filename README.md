# FFMPEG RTPM NGINX HLS

## Begin start

```bash
cp .env.example .env

docker-compose -f docker-compose.m1.yaml pull
docker-compose -f docker-compose.m1.yaml up --build
```

```bash
# Start streaming with ffmpeg
ffmpeg -re -i example.mp4 -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://localhost/show/stream

# Start streaming with obs
rtmp://localhost/show
stream
```

```bash
# Open in browser player.html
```

## COMMON

https://www.servermania.com/kb/articles/nginx-rtmp/
https://nginx.org/en/download.html
https://github.com/arut/nginx-rtmp-module/tags

```bash
wget https://nginx.org/download/nginx-1.20.2.tar.gz
```

```bash
apt-get install -y git build-essential ffmpeg libpcre3 libpcre3-dev libssl-dev zlib1g-dev
```

```bash
# Configure Nginx
./configure --prefix=/usr/local/nginx --with-http_ssl_module --add-module=../nginx-rtmp-module
make -j 1
make install
```
