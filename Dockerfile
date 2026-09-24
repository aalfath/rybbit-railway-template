# Rybbit backend v2.9.0 built through Railway (the 2 GB GHCR image stalls when pulled at deploy time),
# with a one-time admin bootstrap so public sign-up can stay disabled from the first boot.
FROM ghcr.io/rybbit-io/rybbit-backend:v2.9.0@sha256:5a824932c8b7b16364c8ee132e29d1d9d9574445e0d1f091e6364695e117bd66
COPY railway-start.sh /railway-start.sh
ENTRYPOINT ["/railway-start.sh"]
