FROM alpine:3.7
RUN apk update && apk upgrade
RUN apk add chromium wget curl openjdk8-jre php7 php7-curl php7-zip php7-phar php7-openssl php7-mbstring php7-json
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install ChromeDriver.
RUN wget https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/bin/chromedriver
RUN adduser -SD chromium && addgroup -S chromium
RUN chown chromium:chromium /usr/bin/chromedriver
RUN chmod 0755 /usr/bin/chromedriver

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
