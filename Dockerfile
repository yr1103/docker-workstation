FROM nginx:alpine
COPY app/ /usr/share/nginx/html/
ENV APP_ENV=dev
