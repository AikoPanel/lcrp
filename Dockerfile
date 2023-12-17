# Sử dụng hình ảnh Alpine Linux phiên bản 3.15
FROM alpine:3.15

# Đặt nhãn cho hình ảnh
LABEL org.opencontainers.image.source="https://github.com/AikoPanel/lcrp"

# Cập nhật gói và cài đặt các gói cần thiết
RUN apk update && apk add --no-cache \
    bash \
    php7.4 \
    curl \
    supervisor \
    redis \
    php7.4-zlib \
    php7.4-xml \
    php7.4-phar \
    php7.4-intl \
    php7.4-dom \
    php7.4-xmlreader \
    php7.4-ctype \
    php7.4-session \
    php7.4-mbstring \
    php7.4-tokenizer \
    php7.4-gd \
    php7.4-redis \
    php7.4-bcmath \
    php7.4-iconv \
    php7.4-pdo \
    php7.4-posix \
    php7.4-gettext \
    php7.4-simplexml \
    php7.4-sodium \
    php7.4-sysvsem \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-json \
    php7.4-openssl \
    php7.4-curl \
    php7.4-sockets \
    php7.4-zip \
    php7.4-pdo_mysql \
    php7.4-xmlwriter \
    php7.4-opcache \
    php7.4-gmp \
    php7.4-pdo_sqlite \
    php7.4-sqlite3 \
    php7.4-pcntl \
    php7.4-fileinfo \
    git \
    mailcap \
    caddy

RUN curl -O http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar xvf ioncube_loaders_lin_x86-64.tar.gz \
    && cp ioncube/ioncube_loader_lin_7.4.so /usr/lib/php7/modules/ioncube_loader_lin_7.4.so \
    && rm -rf ioncube ioncube_loaders_lin_x86-64.tar.gz

RUN echo "zend_extension=/usr/lib/php7/modules/ioncube_loader_lin_7.4.so" > /etc/php7/conf.d/ioncube.ini

RUN mkdir /www /wwwlogs /rdb
RUN mkdir -p /run/php /run/caddy/run/supervisor

COPY config/php-fpm.conf /etc/php7/php-fpm.d/www.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /www

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf