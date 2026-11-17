# Rybbit web client v2.9.2 (Next.js). Built through Railway from this repo instead of being
# pulled from GHCR at deploy time, which failed on fresh deploys ("registry could not be reached").
FROM ghcr.io/rybbit-io/rybbit-client:v2.9.2@sha256:9beb1cfe74bbb3bf7d7a74cf5d3b07639610637909f0dfafaa87d3a76b91ce2a
# Listen on IPv6 too, so the gateway can reach it over Railway's private network.
ENV HOSTNAME=:: \
    PORT=3002
EXPOSE 3002
CMD ["node", "server.js"]
