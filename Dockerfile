FROM debian:latest

MAINTAINER Hans-Willi Werres

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r www-data && useradd -r --create-home -g www-data www-data

# install httpd runtime dependencies
# https://httpd.apache.org/docs/2.4/install.html#requirements
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		apache2 \
		libapache2-mod-wsgi \
		libapache2-mod-dnssd \
	; \
	rm -rf /var/lib/apt/lists/*

COPY httpd-foreground /usr/local/bin/

EXPOSE 80
EXPOSE 443
CMD ["httpd-foreground"]

#ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update && apt-get install -y apache2 libapache2-mod-wsgi libapache2-mod-dnssd

#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash

RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \dpkg-reconfigure --frontend=noninteractive locales && \update-locale LANG=de_DE.UTF-8
ENV LANG de_DE.UTF-8 
RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime
ENV TZ Europe/Berlin

#WORKDIR /opt/scripts/

#ADD scripts/avahi_startup.sh avahi_startup.sh

#CMD ["sh", "/opt/scripts/iobroker_startup.sh"]

ENV DEBIAN_FRONTEND teletype
