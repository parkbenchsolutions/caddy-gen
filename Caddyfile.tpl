{{ range $host, $containers := groupByMulti $ "Env.VIRTUAL_HOST" "," }}
{{ $host }} {
    {{ $tls := $.Env.TLS }}
    {{ if $tls }}
      tls {{ $tls }}
    {{ else }}
      tls off
    {{ end }}
    log stdout
    errors stderr
    gzip
    root /app/public
    proxy / {{ range $container := $containers }}{{ $container.Name }}{{ end }} {
      transparent
    }
}
{{ end }}
