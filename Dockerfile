FROM alpine:3.18 AS source

WORKDIR /app
COPY index.html .
COPY nginx.conf .

FROM nginx:1.25-alpine

RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=source /app/nginx.conf /etc/nginx/nginx.conf

COPY --from=source /app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
