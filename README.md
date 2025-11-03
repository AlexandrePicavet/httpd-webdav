# httpd-webdav

Simple webdav container based on the [official httpd docker image](https://hub.docker.com/_/httpd)

## Usage

### Create your digest file & set the correct permissions

The digest file can be created using the `htdigest` command.

```bash
htdigest -c user.passwd dav USERNAME
```

Or generate it via an `httpd` docker container & write the generated digest to a file:

```bash
docker run -it --rm httpd:latest htdigest -c /dev/stdout dav USERNAME
```

In the commands above, `dav` refers to the realm of the WebDAV server.

The default user of this docker is `www-data` with uid & gid `82`, so fix the owner & permissions on your digest file:

```bash
chmod 400 user.passwd
chown 82:82 user.passwd
```

### Run

```bash
docker run -d \
    -p 8080:8080 \
    --read-only \
    -v $(pwd)/user.passwd:/usr/local/apache2/dav/user.passwd:ro \
    -v $(pwd)/uploads:/usr/local/apache2/dav/data \
    ghcr.io/alexandrepicavet/httpd-webdav
```

## Build

```bash
./build TAG
```

:warning: WebDAV locking mechanism is not available when using alpine-based image.
