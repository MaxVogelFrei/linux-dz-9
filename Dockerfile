FROM alpine:latest
WORKDIR /nginxconfig
COPY . .
RUN apk update &&\
 apk upgrade &&\
 apk add nginx &&\
 mkdir -p /run/nginx &&\
 mkdir /usr/share/nginx &&\
 mkdir /usr/share/nginx/html/ &&\
 cp /nginxconfig/index.html /usr/share/nginx/html/ &&\
 cp /nginxconfig/nginx.conf /etc/nginx/ &&\
 cp /nginxconfig/default.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]
