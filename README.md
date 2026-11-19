# Deploy and Host Rybbit on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/rybbit-1?utm_medium=integration&utm_source=button&utm_campaign=rybbit)

Rybbit is an open-source, privacy-friendly web and product analytics platform and a modern alternative to Google Analytics. A small script records pageviews, custom events, errors and web vitals without cookies, and dashboards show traffic, funnels, goals, journeys, retention, user profiles, session replay and real-time visitors.

## About Hosting Rybbit

This template deploys Rybbit v2.9.3 as six services: the web client, the backend, ClickHouse for events, Railway Postgres, Railway Redis and a Caddy router that serves the client and API on one public domain. The client, backend, ClickHouse and router all build from one GitHub wrapper repository with pinned upstream images, so you get Railway's "update available" notice when the template is updated. On the first start the backend creates the admin account from its variables, and public sign-up stays disabled. ClickHouse is capped at 2 GB of memory, so plan for about 3 GB across all services.

## Common Use Cases

* Cookieless website analytics for products, blogs and docs
* Product analytics with custom events, funnels and goals
* Replacing Google Analytics while keeping data in your own databases

## Dependencies for Rybbit Hosting

* Rybbit backend and client v2.9.3 (`ghcr.io/rybbit-io/rybbit-backend`, `ghcr.io/rybbit-io/rybbit-client`), built from `aalfath/rybbit-railway-template`
* ClickHouse 26.3 with a volume, Railway Postgres with a volume, Railway Redis with a volume, and a Caddy router

### Deployment Dependencies

* [Rybbit documentation](https://www.rybbit.io/docs)
* [Rybbit v2.9.3 release](https://github.com/rybbit-io/rybbit/releases/tag/v2.9.3)
* [Tracking script](https://www.rybbit.io/docs/script)
* [Wrapper repository and changelog](https://github.com/aalfath/rybbit-railway-template)

### Implementation Details

| Service | Built from | Networking | Storage |
| --- | --- | --- | --- |
| gateway | repo `gateway/` (Caddy 2.11.9) | public domain on 8080 | none |
| client | repo `client/` (Rybbit client v2.9.3) | private, 3002 | none |
| backend | repo root (Rybbit backend v2.9.3) | private, 3001 | none |
| clickhouse | repo `clickhouse/` (ClickHouse 26.3.17.4) | private, 8123 | volume at `/var/lib/clickhouse` |
| Postgres / Redis | Railway databases | private only | volumes |

After the deploy, open the `backend` service's variables to find the admin login (`RYBBIT_ADMIN_EMAIL`, default `admin@example.com`, and the generated `RYBBIT_ADMIN_PASSWORD`). Sign in, create an organization and a site, then add the script to your pages:

```html
<script src="https://YOUR-DOMAIN/api/script.js" data-site-id="YOUR-SITE-ID" defer></script>
```

| Variable | Service | Default | Purpose |
| --- | --- | --- | --- |
| `RYBBIT_ADMIN_EMAIL` / `RYBBIT_ADMIN_PASSWORD` | backend | `admin@example.com` / generated | Admin, created on the first start only |
| `DISABLE_SIGNUP` | backend | `true` | Public sign-up |
| `CLICKHOUSE_MAX_MEMORY_BYTES` / `CLICKHOUSE_MAX_THREADS` | clickhouse | 2 GiB / 4 | ClickHouse limits |

Notes:

* The client calls `/api` on its own domain, so keep the router and put custom domains on the `gateway` service.
* Rybbit's bot filter is on by default for new sites, so scripted test requests show up under bots rather than as pageviews.
* Invite teammates from the organization settings after signing in. Email (SMTP) and Google or GitHub login are optional; see the Rybbit docs.

This is a community-maintained deployment package and does not imply affiliation with or endorsement by the Rybbit project or its maintainers.

## Updates

Every service except Postgres and Redis builds from this repository's `main` branch. When a change is merged here, Railway shows everyone who deployed the template an "update available" notice, and you choose when to apply it. Read [CHANGELOG.md](CHANGELOG.md) first: breaking changes are listed at the top of each entry.

| Folder | Service |
| --- | --- |
| `/` (`Dockerfile`, `railway-start.sh`) | backend |
| `client/` | client |
| `gateway/` | gateway |
| `clickhouse/` | clickhouse |

## Why Deploy Rybbit on Railway?

<!-- Recommended: Keep this section as shown below -->
Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Rybbit on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
<!-- End recommended section -->
