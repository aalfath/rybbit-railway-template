# Rybbit backend v2.9.2, built from this repo so Railway sends deployers update notices,
# with a one-time admin bootstrap so public sign-up can stay disabled from the first boot.
FROM ghcr.io/rybbit-io/rybbit-backend:v2.9.2@sha256:e5fc900b59251f4e43f8caef600b0cfd26a63c7b1732e725900bf4ea2ab8a3d7
COPY railway-start.sh /railway-start.sh
ENTRYPOINT ["/railway-start.sh"]
