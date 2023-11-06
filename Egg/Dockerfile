FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN	apt update -y && apt upgrade -y \
    && apt-get install -y ca-certificates lsb-release apt-transport-https iproute2 tzdata curl unzip git jq xmlstarlet \
    && adduser --disabled-password --home /home/container container \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update && apt -y install php7.4

RUN apt-get install -y php7.4-zip php7.4-gd php7.4-mysql php7.4-curl php7.4-simplexml php7.4-mbstring
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

USER container
ENV  USER=container HOME=/home/container
WORKDIR	/home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]