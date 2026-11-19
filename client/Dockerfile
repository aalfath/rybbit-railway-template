# Rybbit web client v2.9.3 (Next.js). Built through Railway from this repo instead of being
# pulled from GHCR at deploy time, which failed on fresh deploys ("registry could not be reached").
FROM ghcr.io/rybbit-io/rybbit-client:v2.9.3@sha256:39947e9e4da4248de27f78e2fa691eb86654945dff7b74c1d732b78f13273fb3
# Listen on IPv6 too, so the gateway can reach it over Railway's private network.
ENV HOSTNAME=:: \
    PORT=3002
EXPOSE 3002
CMD ["node", "server.js"]
