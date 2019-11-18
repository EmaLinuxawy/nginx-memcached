# Nginx-Memcached
Build of Nginx with memcache module.

### Why we need to use this image
In case of mid/large scale we need to avoide hassle to hit all requests to our application server, so i using nginx with memcached module make full page cache to get/set requests from our memcached server if our page is not in cache once we hit it nginx can set the key and any new request in the same page will served from our cache server

## How to use this image
### Run container with specific nginx.conf
```
$ docker run --name web-nginx -v /path/nginx.conf:/etc/nginx/nginx.conf:ro -d -p 8080:80 linuxawy/nginx-memcache
```
You can hit http://localhost:8080 or http://host-ip:8080 in your browser.

## Sample Configuration for memcached module with nginx:
```
   http {
     upstream backend {
       server memcached:11211;

       # a pool with at most 1024 connections
       # and do not distinguish the servers:
       keepalive 1024;
     }

     server {
         ...
         location /memc {
             set $memc_cmd get;
             set $memc_key $arg_key;
             memc_pass backend;
         }
     }
   }
```

## Reference 
* [openresty/memc-nginx-module](https://github.com/openresty/memc-nginx-module) - The author of Memcached module 
