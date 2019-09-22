# Simple docker container for murmur

[![](https://images.microbadger.com/badges/image/alex2242/murmur.svg)](https://microbadger.com/images/alex2242/murmur) [![](https://images.microbadger.com/badges/version/alex2242/murmur.svg)](https://microbadger.com/images/alex2242/murmur)

This docker container is built over alpine and uses the
[official](https://www.mumble.info/) murmur binaries.

## Usage

The simplest way to run the container is:

```bash
$ docker run -d -p 64738:64738 -p 64738:64738/udp alex2242/murmur:latest
```

_A minimal default configuration file is embedded in the image, the container can run with it._

### Docker compose

Using docker-compose is recommended, here is a sample configuration:

```yaml
version: '3.6'

services:
  murmur:
    image: alex2242/murmur:latest
    container_name: murmur
    volumes:
      - /local/path/murmur.ini:/etc/murmur/murmur.ini:ro
      - /local/path/murmur.sqlite:/var/opt/murmur/murmur.sqlite
      # certs location in the container are to be defined in murmur.ini
      - /local/path/fullchain.pem:/etc/ssl/murmur/fullchain.pem
      - /local/path/privkey.pem:/etc/ssl/murmur/privkey.pem
    ports:
      - "64738:64738"
      - "64738:64738/udp"
```

_Be sure that mounted files are accessible by un-privileged user_
