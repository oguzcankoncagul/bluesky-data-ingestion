-- Step 1: Filter posts containing "engineering"
WITH filtered_posts AS (
    
    SELECT text
    FROM {{ ref('fct__post') }}
    WHERE lower(text) LIKE '%engineering%'

),
-- Step 2: Remove punctuation and newlines
cleaned_text AS (
    
    SELECT 
        regexp_replace(lower(text), '[^\w\s]', '', 'g') AS clean_text
    FROM filtered_posts

),
-- Step 3: Split text into individual words
split_words AS (

    SELECT 
        unnest(string_split(clean_text, ' ')) AS word
    FROM cleaned_text

),
-- Step 4: Count occurrences of each word (excluding empty or insignificant words)
word_counts AS (
    
    SELECT 
        word, 
        COUNT(*) AS word_count
    FROM split_words
    WHERE word not in ('', 'and', 'or', 'like', 'the', 'who', 'to', 'is', 'with', 'as', 'in', 'of', 'on')
    GROUP BY word

),
-- Step 5: Rank words by frequency
ranked_words AS (
    
    SELECT 
        word,
        word_count,
        RANK() OVER (ORDER BY word_count DESC) AS popularity_rank
    FROM word_counts

)
-- Step 6: Return final results

SELECT word
FROM ranked_words
ORDER BY popularity_rank ASC
LIMIT 10
