WITH like_metrics AS (

    SELECT
        date_trunc('minute', created_at) AS minute, 
        count(1) AS likes
    FROM "local_db"."main_dwh"."fct__like"
    group by date_trunc('minute', created_at)
),

post_metrics AS (

    SELECT
        date_trunc('minute', created_at) AS minute, 
        count(1) AS posts
    FROM "local_db"."main_dwh"."fct__post"
    group by date_trunc('minute', created_at)
)


SELECT
    like_metrics.minute,
    like_metrics.likes,
    post_metrics.posts

FROM like_metrics
FULL JOIN post_metrics ON post_metrics.minute = like_metrics.minute