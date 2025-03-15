SELECT
    minute,
    likes
FROM {{ ref('agg__time_minutely') }}
ORDER BY minute DESC;