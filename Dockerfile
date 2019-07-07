FROM debian:latest

MAINTAINER Hans-Willi Werres

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		apache2 \
		libapache2-mod-wsgi \
		libapache2-mod-dnssd \
	; \
	rm -rf /var/lib/apt/lists/*
RUN a2enmod auth_digest auth_form authz_groupfile cache_disk cache cache_socache cgid cgi headers info macro proxy_ajp \
            proxy proxy_connect proxy_fcgi proxy_html proxy_http2 proxy_http proxy_scgi proxy_wstunnel request rewrite \
	    sed session_cookie session_crypto session ssl substitute vhost_alias xml2enc

COPY startup /
RUN chmod +x /startup

EXPOSE 80
EXPOSE 443
CMD ["/startup"]

#ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update && apt-get install -y apache2 libapache2-mod-wsgi libapache2-mod-dnssd

#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		locales \
	; \
	rm -rf /var/lib/apt/lists/*
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \dpkg-reconfigure --frontend=noninteractive locales && \update-locale LANG=de_DE.UTF-8
ENV LANG de_DE.UTF-8 

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime
ENV TZ Europe/Berlin

#WORKDIR /opt/scripts/

#ADD scripts/avahi_startup.sh avahi_startup.sh

#CMD ["sh", "/opt/scripts/iobroker_startup.sh"]

ENV DEBIAN_FRONTEND teletype
