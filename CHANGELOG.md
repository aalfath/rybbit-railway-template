# Changelog

## 2026-11-19: Rybbit v2.9.3 (security release)

Breaking changes: none. Rybbit v2.9.3 has no database migrations; data in Postgres and ClickHouse is kept.

- Rybbit [v2.9.3](https://github.com/rybbit-io/rybbit/releases/tag/v2.9.3) is a security release: it updates dependencies with published vulnerabilities.
- Backend: `ghcr.io/rybbit-io/rybbit-backend:v2.9.3@sha256:2e87bf8be399da2cb5dede1c6edc746abd59472f89e88dc36cc28656875f24a9`.
- Client: `ghcr.io/rybbit-io/rybbit-client:v2.9.3@sha256:39947e9e4da4248de27f78e2fa691eb86654945dff7b74c1d732b78f13273fb3`.

## 2026-11-17: Rybbit v2.9.2, every service built from this repo

Breaking changes: none. Existing data in Postgres and ClickHouse is kept; the backend applies one small Postgres migration (`invitation.createdAt`) on start.

- Backend: `ghcr.io/rybbit-io/rybbit-backend` v2.9.0 → v2.9.2 (`sha256:e5fc900b…`). Upstream pins Node 24.22.1 for CVE-2026-111497.
- Client: new `client/` folder, `ghcr.io/rybbit-io/rybbit-client` v2.9.2 (`sha256:9beb1cfe…`). Previously the template pulled the v2.9.0 image directly, and fresh deploys could fail with "The registry could not be reached".
- Gateway: new `gateway/` folder, Caddy 2.11.9 (`sha256:003a9780…`) with the Caddyfile baked in (it was a `CADDYFILE` variable before).
- ClickHouse: new `clickhouse/` folder, ClickHouse 26.3.17.4 (`sha256:85c43481…`, the version Rybbit pins) with the Railway limits in `railway-start.sh` instead of a long start command.
- Deployments made before this change keep running their image services; only the backend picks up this update from the repo. To move the other services to the repo, redeploy the template.

## 2026-11-12

- README: Deploy on Railway button.

## 2026-09-24: Rybbit v2.9.0

- First release: backend wrapper on `ghcr.io/rybbit-io/rybbit-backend:v2.9.0` with a first-start admin bootstrap, so public sign-up stays disabled from the first boot.
