WITH posts AS (
    SELECT
        e.timestamp,
        e.repo AS user_id,
        replace(e.path, 'app.bsky.feed.post/', '') AS post_id,
        e.text,
        e.langs
    FROM {{ ref('stg__events') }} e
    WHERE e.path LIKE 'app.bsky.feed.post/%'
)

SELECT
    md5_number(concat(user_id, post_id)) as post_key,
    md5_number(user_id) AS user_key,
    post_id,
    text,
    langs,
    CAST(timestamp AS TIMESTAMP) AS created_at,
    current_timestamp AS last_updated_at
FROM posts
