FROM ubuntu:18.04
LABEL maintainer="Oleg Gorbunov <dev.oleg.gorbunov@gmail.com>"
RUN ulimit -n 10000
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN echo "tzdata tzdata/Areas select Etc" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Etc select UTC" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata
RUN apt-get update && apt-get install -y \
    software-properties-common language-pack-en-base && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get -y install \
    git-core ntp ntpdate build-essential autoconf libtool libtool-bin automake uuid-dev pkg-config libssl-dev \
    php7.3-dev php7.3-opcache php7.3-xml php7.3-cli php7.3-common php7.3-json php7.3-mysql php7.3-readline php7.3-zip php7.3-curl php7.3-mbstring php7.3-gmp \
    php-xdebug \
    libevent-dev libevent-* wget tar
RUN yes '' | pecl install event
RUN echo "extension=event.so" > /etc/php/7.3/mods-available/event.ini
RUN phpenmod event
RUN mkdir -p /mnt/daemon
RUN apt-get install -y unzip curl
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /mnt/daemon
