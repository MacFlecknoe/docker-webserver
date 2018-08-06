FROM ubuntu:18.04

LABEL maintainer "Michael Lambert"
LABEL image_type "Apache Webserver with PHP"

ARG JQUERY_VERSION=3.2.0

ENV DOC_ROOT /var/www/mysite-dev
ENV JQUERY_VERSION ${JQUERY_VERSION}

RUN apt-get update \
	&& apt-get upgrade -y \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	apache2 \
	libapache2-mod-php \
	php7.0 \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR ${DOC_ROOT}

COPY code/sites/mysite ${DOC_ROOT}
ADD code/apache/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD https://code.jquery.com/jquery-${JQUERY_VERSION}.min.js ${DOC_ROOT}/js/

EXPOSE 80 

CMD apachectl -D FOREGROUND
