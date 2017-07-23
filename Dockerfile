FROM jwilder/docker-gen

WORKDIR /app
ADD docker-gen.cfg /app/docker-gen.cfg
ADD Caddyfile.tpl /app/Caddyfile.tpl
CMD ["-config", "/app/docker-gen.cfg", "-notify-output"]
