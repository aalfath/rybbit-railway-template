#!/bin/sh
# Caps ClickHouse for Railway (memory, threads), turns off its system log tables,
# enables the settings Rybbit needs, then runs the official entrypoint.
set -e
D=/etc/clickhouse-server
MEM="${CLICKHOUSE_MAX_MEMORY_BYTES:-2147483648}"
THREADS="${CLICKHOUSE_MAX_THREADS:-4}"
R='remove="remove"'
cat > "$D/config.d/railway.xml" <<XML
<clickhouse>
  <max_server_memory_usage>$MEM</max_server_memory_usage>
  <concurrent_threads_soft_limit_num>$THREADS</concurrent_threads_soft_limit_num>
  <logger><level>warning</level><console>true</console></logger>
  <query_thread_log $R/><query_log $R/><query_views_log $R/><query_metric_log $R/>
  <error_log $R/><opentelemetry_span_log $R/><text_log $R/><trace_log $R/>
  <metric_log $R/><asynchronous_metric_log $R/><session_log $R/><part_log $R/>
  <latency_log $R/><processors_profile_log $R/>
</clickhouse>
XML
cat > "$D/users.d/railway.xml" <<XML
<clickhouse>
  <profiles><default>
    <enable_json_type>1</enable_json_type>
    <async_insert>1</async_insert>
    <wait_for_async_insert>1</wait_for_async_insert>
    <log_queries>0</log_queries>
    <max_threads>$THREADS</max_threads>
  </default></profiles>
</clickhouse>
XML
exec /entrypoint.sh "$@"
