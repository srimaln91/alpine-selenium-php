FROM alpine:3.7
RUN apk update && apk upgrade
RUN apk add chromium wget php7 php7-curl php7-zip php7-phar php7-openssl
RUN RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
