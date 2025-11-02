ARG TAG=2.4
FROM httpd:${TAG}

ARG UID=82 # www-data user
ARG GID=82 # www-data group

RUN \
	mkdir -p /usr/local/apache2/dav/data \
	# TODO Could be enhanced by only targeting required files, thereby reducing image size.
	&& chown -R "${UID}:${GID}" /usr/local/apache2 \
	&& chmod -R go-rwx /usr/local/apache2 \
	&& chmod -R a+rw /usr/local/apache2/dav

USER ${UID}:${GID}
VOLUME /usr/local/apache2/dav/data
VOLUME /usr/local/apache2/dav/user.passwd

COPY --chmod=500 --chown="${UID}:${GID}" httpd.conf ./conf/

ENTRYPOINT ["httpd-foreground"]
