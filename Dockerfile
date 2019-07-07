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
RUN a2enmod auth_digest.load 
RUN a2enmod auth_form.load
RUN a2enmod authz_groupfile.load
RUN a2enmod cache_disk.conf
RUN a2enmod cache_disk.load
RUN a2enmod cache.load
RUN a2enmod cache_socache.load
RUN a2enmod cgid.conf
RUN a2enmod cgid.load
RUN a2enmod cgi.load
RUN a2enmod headers.load
RUN a2enmod info.conf
RUN a2enmod info.load
RUN a2enmod macro.load
RUN a2enmod proxy_ajp.load
RUN a2enmod proxy.conf
RUN a2enmod proxy_connect.load
RUN a2enmod proxy_fcgi.load
RUN a2enmod proxy_html.conf
RUN a2enmod proxy_html.load
RUN a2enmod proxy_http2.load
RUN a2enmod proxy_http.load
RUN a2enmod proxy.load
RUN a2enmod proxy_scgi.load
RUN a2enmod proxy_wstunnel.load
RUN a2enmod request.load
RUN a2enmod rewrite.load
RUN a2enmod sed.load
RUN a2enmod session_cookie.load
RUN a2enmod session_crypto.load
RUN a2enmod session.load
RUN a2enmod ssl.conf
RUN a2enmod ssl.load
RUN a2enmod substitute.load
RUN a2enmod vhost_alias.load
RUN a2enmod xml2enc.load

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
