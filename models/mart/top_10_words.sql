

WITH raw AS (
    SELECT *
    FROM "local_duckdb"."main"."events"
    WHERE action = 'create'
      AND path LIKE 'app.bsky.feed.like/%'
)
SELECT
    DATE_TRUNC('minute', CAST(timestamp AS TIMESTAMP)) as minute_window,
    COUNT(*) as likes
FROM raw
GROUP BY 1
ORDER BY minute_window