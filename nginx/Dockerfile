FROM nginx:latest
COPY ./www/index.html        /usr/share/nginx/html/index.html
COPY ./conf/nginx.conf       /etc/nginx/conf.d/default.conf
COPY ./conf/.htpasswd  	     /etc/nginx/.htpasswd
COPY ./www/health/index.html /usr/share/nginx/html/health/index.html
