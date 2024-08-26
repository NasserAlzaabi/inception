# base image
FROM alpine:3.19

# installing neccessary packages
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# creating neccessary folders
RUN mkdir -p /etc/nginx /run/nginx /usr/share/nginx/html /etc/nginx/certs 

# copy the custom conf file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# expose port for other container
# EXPOSE 80
EXPOSE 443

# changing ownership of these directory to the nginx user
RUN chown -R nginx:nginx /usr/share/nginx/html && \
  chown -R nginx:nginx /etc/nginx/certs/

# RUN it
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]