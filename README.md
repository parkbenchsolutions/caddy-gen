# caddy-gen

Generates a new caddy file when a docker instance is started
with the following
  - environmental variable of VIRTUAL_HOST set
  - has an exposed port

If the environmental variable of TLS is set, it will
be added to the caddy file.

The new file is placed into /app/data.  This volume should
be shared with the caddy instance.

When rebuilt, it sends a SIGHUP to the docker instance named caddy

## EXAMPLE

```
version: '2'
services:
  caddy-gen:
    image: my.caddy-gen
    build: ./caddy-gen
    container_name: caddy-gen
    restart: always
    environment:
      TLS: me@example.com
    volumes:
      - caddy:/app/data
      - /var/run/docker.sock:/tmp/docker.sock:ro
  caddy:
    image: my.caddy
    build: ./caddy
    container_name: caddy
    restart: always
    ports:
      - "80:80"
      - "443:443"
    environment:
      CADDYPATH: /app/certs
    volumes:
      - caddy:/app/data:ro
      - certs:/app/certs
  tester:
    image: alpine
    environment:
      VIRTUAL_HOST: example.com
    expose:
      - "80:80"
    command: ["sleep", "100"]
volumes:
  caddy:
  certs:
```

