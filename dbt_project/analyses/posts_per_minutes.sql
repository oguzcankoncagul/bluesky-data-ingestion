SELECT
    minute,
    posts
FROM {{ ref('agg__time_minutely') }}
ORDER BY minute DESC;