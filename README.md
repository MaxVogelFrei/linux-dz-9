# Домашнее задание 9

[репозиторий dockerhub](https://hub.docker.com/r/maxvogelfrei/nginx)

[dockerfile для сборки образа](Dockerfile)

## Docker

* Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx)

* Собранный образ необходимо запушить в docker hub и дать ссылку на ваш репозиторий.

* Определите разницу между контейнером и образом. Вывод опишите в домашнем задании.

* Ответьте на вопрос: Можно ли в контейнере собрать ядро?

## Процесс решения

### создаю файлы для копирования в образ при сборке

[nginx.conf](nginx.conf)  
указание nginx прочитать дополнительный конфиг

      include /etc/nginx/conf.d/*.conf;


[default.conf](default.conf)  
на каком порту принимать соединения, путь к корню и страница "по умолчанию"

    server {
      listen       80;
      server_name  localhost;
      location / {
      root   /usr/share/nginx/html;
      index  index.html index.htm;
      }


[index.html](index.html)  
страничка на замену дефолту

      <p style="text-align: center;">OTUS-LINUX DZ 7 Docker test html text</p>
      <p style="text-align: center;"><a href="https://github.com/MaxVogelFrei/linux-dz-9">GitHub</a></p>
      
### пишу Dockerfile  
за основу беру alpine  

      FROM alpine:latest
внутри образа создам папку для копирования в нее своего конфига  

      WORKDIR /nginxconfig
      COPY . .
обновление, установка nginx, создание папок для pid и html, копирование конфига  

      RUN apk update && apk upgrade && apk add nginx && mkdir -p /run/nginx && mkdir /usr/share/nginx && mkdir /usr/share/nginx/html/ && cp /nginxconfig/index.html /usr/share/nginx/html/ && cp /nginxconfig/nginx.conf /etc/nginx/ && cp /nginxconfig/default.conf /etc/nginx/conf.d/
запуск nginx  

      CMD ["nginx", "-g", "daemon off;"]

### сборка, загрузка в dockerhub, проверка

    docker build -t maxvogelfrei/nginx:1 .
    docker push maxvogelfrei/nginx:1
    docker run -d -p 80:80 maxvogelfrei/nginx:1
