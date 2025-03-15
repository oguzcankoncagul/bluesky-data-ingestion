WITH likes AS (
    SELECT
        e.timestamp,
        e.repo AS user_id,
        e.uri AS post_uri,
        replace(e.path, 'app.bsky.feed.like/', '') AS post_id,
    FROM {{ ref('stg__events') }} e
    WHERE e.path LIKE 'app.bsky.feed.like/%'
)

SELECT
    md5_number(concat(timestamp, user_id, post_id)) as like_key,
    md5_number(user_id) AS user_key,
    post_uri,
    post_id,
    CAST(timestamp AS TIMESTAMP)  AS created_at,
    current_timestamp AS last_updated_at
FROM likes
