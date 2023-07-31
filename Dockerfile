FROM php:cli as php-cli

# Install system dependencies
RUN apk add --no-cache \
		acl \
		fcgi \
		file \
		gettext \
		git \
	;


# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer:latest --link /usr/bin/install-php-extensions /usr/local/bin/

RUN wget -P /etc/ssl/certs/ http://curl.haxx.se/ca/cacert.pem && chmod 744 /etc/ssl/certs/cacert.pem && cp /etc/ssl/certs/cacert.pem /etc/ssl/cert.pem

RUN set -eux; \
    install-php-extensions \
        @fix_letsencrypt \
		intl \
        zip \
        pdo_mysql \
        pdo \
        mcrypt \
        exif \
        gd \
        mysqli \
        sockets \
        pcntl \
        mbstring \
        xdebug \
        imagick \
        opcache \
        ssh2 \
        gettext \
    ;

WORKDIR /srv/tcpdf

COPY . .