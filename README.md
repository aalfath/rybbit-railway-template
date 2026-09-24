# Deploy and Host Rybbit on Railway

Rybbit is an open-source, privacy-friendly web and product analytics platform and a modern alternative to Google Analytics. A tiny script records pageviews, custom events, errors and web vitals without cookies, and dashboards show traffic, funnels, goals, journeys, retention, user profiles, session replay and real-time visitors.

## About Hosting Rybbit

This template deploys Rybbit v2.9.0 as six services: the web client, the backend, ClickHouse for events, Railway Postgres, Railway Redis and a Caddy router that serves the client and API on one domain. On the very first start the backend creates the admin from environment variables, while public sign-up stays disabled. ClickHouse memory and threads are capped for Railway, and its system logs are off. The backend is built from a small wrapper repository because the large upstream image stalls when pulled at deploy time. ClickHouse is capped at 2 GB, so plan for about 3 GB across all services.

## Common Use Cases

- Cookieless website analytics for products, blogs and docs
- Product analytics with custom events, funnels and goals
- Replacing Google Analytics while keeping data in your own databases

## Dependencies for Rybbit Hosting

- `ghcr.io/rybbit-io/rybbit-client:v2.9.0`
- `aalfath/rybbit-railway-template` (backend, built from `ghcr.io/rybbit-io/rybbit-backend:v2.9.0`)
- `clickhouse/clickhouse-server:26.3.17.4` with a volume
- Railway Postgres (`ghcr.io/railwayapp-templates/postgres-ssl:18`) with a volume
- Railway Redis with a volume
- `caddy:2.11.4-alpine` router

### Deployment Dependencies

- [Rybbit documentation](https://www.rybbit.io/docs)
- [Rybbit v2.9.0 release](https://github.com/rybbit-io/rybbit/releases/tag/v2.9.0)
- [Tracking script](https://www.rybbit.io/docs/script)
- [Wrapper repository](https://github.com/aalfath/rybbit-railway-template)

### Implementation Details

| Service | Source | Networking | Storage |
| --- | --- | --- | --- |
| gateway | `caddy:2.11.4-alpine` | public domain on 8080 | none |
| client | `ghcr.io/rybbit-io/rybbit-client:v2.9.0` | private, 3002 | none |
| backend | `aalfath/rybbit-railway-template` | private, 3001 | none |
| clickhouse | `clickhouse/clickhouse-server:26.3.17.4` | private, 8123 | volume at `/var/lib/clickhouse` |
| Postgres / Redis | Railway databases | private only | volumes |

Sign in, create an organization and a site, then add the script to your pages:

```html
<script src="https://<domain>/api/script.js" data-site-id="1" defer></script>
```

| Variable | Service | Default | Purpose |
| --- | --- | --- | --- |
| `RYBBIT_ADMIN_EMAIL` / `RYBBIT_ADMIN_PASSWORD` | backend | `admin@example.com` / generated | Admin, created on the first start |
| `DISABLE_SIGNUP` | backend | `true` | Public sign-up |
| `CLICKHOUSE_MAX_MEMORY_BYTES` / `CLICKHOUSE_MAX_THREADS` | clickhouse | 2 GiB / 4 | ClickHouse limits |

Notes:

- The client calls `/api` on its own domain, so keep the router; put custom domains on the `gateway` service.
- Invite teammates from the organization settings after signing in.

This is a community-maintained deployment package and does not imply affiliation with or endorsement by the Rybbit project or its maintainers.

## Why Deploy Rybbit on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Rybbit on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
