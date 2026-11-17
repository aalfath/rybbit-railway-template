# ClickHouse for Rybbit's event data (the version Rybbit's own docker-compose.yml pins),
# capped for Railway by railway-start.sh. Data lives on the Railway volume at /var/lib/clickhouse.
FROM clickhouse/clickhouse-server:26.3.17.4@sha256:85c434814ac8905e5648027ce926f74ab067edd6aadbccb6c0c165cd3571ea49
COPY --chmod=0755 railway-start.sh /railway-start.sh
ENV CLICKHOUSE_DB=analytics \
    CLICKHOUSE_USER=default \
    CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1
EXPOSE 8123
ENTRYPOINT ["/railway-start.sh"]
