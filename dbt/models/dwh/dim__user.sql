WITH users AS (
    SELECT DISTINCT
        repo AS user_id
    FROM {{ ref('stg__events') }}
    WHERE repo IS NOT NULL
)

SELECT
    md5_number(user_id) AS user_key,
    user_id,
    current_timestamp AS created_at -- or any metadata about the load
FROM users
