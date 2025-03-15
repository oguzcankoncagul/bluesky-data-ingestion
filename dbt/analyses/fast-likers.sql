-- Step 1: Extract relevant columns and ensure timestamp is correct
WITH user_like_timestamps AS (
    
    SELECT 
        user_key,
        created_at AS like_time
    FROM {{ ref('fct__like') }}
    
),
-- Step 2: Count likes in any rolling 60-second window per user
rolling_like_counts AS (
    
    SELECT 
        user_key,
        like_time,
        COUNT(*) OVER (
            PARTITION BY user_key 
            ORDER BY like_time 
            RANGE BETWEEN INTERVAL '59 seconds' PRECEDING AND CURRENT ROW
        ) AS likes_in_rolling_minute
    FROM user_like_timestamps

),
-- Step 3: Identify users who had 50+ likes in any rolling 60-second window
fast_likers AS (
    
    SELECT DISTINCT user_key
    FROM rolling_like_counts
    WHERE likes_in_rolling_minute >= 25

),
-- Step 4: Aggregate total likes per user and flag fast likers
final_aggregation AS (
    
    SELECT 
        ult.user_key,
        COUNT(*) AS total_likes,
        1 AS is_fast_liker  -- We only select fast likers now
    FROM user_like_timestamps ult
    INNER JOIN fast_likers fl
    ON ult.user_key = fl.user_key
    GROUP BY ult.user_key
    ORDER BY total_likes DESC

)

-- Step 5: Only return fast likers
SELECT * FROM final_aggregation;
