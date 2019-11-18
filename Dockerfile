FROM debian:stretch-slim

LABEL maintainer="Nginx With Memcache Module <emalinuxawy@gmail.com>"
RUN apt-get update && apt-get upgrade -y \
  && apt-get install --no-install-recommends --no-install-suggests -y apt-transport-https ca-certificates gnupg1 git wget libpcre3 build-essential libpcre3-dev libperl-dev libcurl4-openssl-dev memcached $

RUN cd /opt/ && git clone https://github.com/openresty/memc-nginx-module.git \
  && wget https://nginx.org/download/nginx-1.16.1.tar.gz && tar -zxf nginx-1.16.1.tar.gz \
  && cd /opt/nginx-1.16.1 \
  && ./configure --add-module=/opt/memc-nginx-module/ --with-debug --prefix=/usr/share/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log $
  && make && make install \
  && mkdir -p /etc/nginx/tmp/client_body

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
