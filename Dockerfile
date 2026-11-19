# Rybbit backend v2.9.3, built from this repo so Railway sends deployers update notices,
# with a one-time admin bootstrap so public sign-up can stay disabled from the first boot.
FROM ghcr.io/rybbit-io/rybbit-backend:v2.9.3@sha256:2e87bf8be399da2cb5dede1c6edc746abd59472f89e88dc36cc28656875f24a9
COPY railway-start.sh /railway-start.sh
ENTRYPOINT ["/railway-start.sh"]
