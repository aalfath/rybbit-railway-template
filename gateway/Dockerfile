# Caddy router: serves the Rybbit client and API on one public domain.
# Needs RYBBIT_BACKEND and RYBBIT_CLIENT (host:port on the private network); listens on PORT (8080).
FROM caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 8080
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
