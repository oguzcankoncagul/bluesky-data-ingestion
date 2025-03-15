

WITH posts AS (
    SELECT
        text,
        JSON_EXTRACT_STRING_LIST(record, '$.langs') as post_langs
    FROM "local_duckdb"."main"."events"
    WHERE action = 'create'
      AND path LIKE 'app.bsky.feed.post/%'
      AND LOWER(text) LIKE '%data%'
)
SELECT
    unnest(post_langs) as lang,
    COUNT(*) as usage_count
FROM posts
GROUP BY lang
ORDER BY usage_count DESC
LIMIT 5