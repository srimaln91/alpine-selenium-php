FROM alpine:3.7
RUN apk update && apk upgrade
RUN apk add chromium wget curl openssh-client openjdk8-jre php7 php7-curl php7-zip php7-phar php7-openssl php7-mbstring php7-json php7-tokenizer php7-dom php7-xmlwriter php7-xml
RUN apk add chromium-chromedriver
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install Selenium.
RUN wget -N http://selenium-release.storage.googleapis.com/3.11/selenium-server-standalone-3.11.0.jar -P ~/
RUN mv -f ~/selenium-server-standalone-3.11.0.jar /usr/bin/selenium-server-standalone.jar
RUN chown root:root /usr/bin/selenium-server-standalone.jar
RUN chmod 0755 /usr/bin/selenium-server-standalone.jar

ADD ./selenium /usr/bin/selenium
RUN chmod +x /usr/bin/selenium
ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 4444/tcp
ENTRYPOINT ["/entrypoint.sh"]
