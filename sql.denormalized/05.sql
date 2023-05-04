SELECT 
    '#' || t.hashtag AS tag, 
    count(*)
FROM 
    (SELECT DISTINCT 
        data->>'id' AS id_tweets,
        jsonb_array_elements(data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' as hashtag
    FROM tweets_jsonb
    WHERE data->>'lang'='en'
    AND to_tsvector('english',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english','coronavirus')
) t
GROUP BY 
    t.hashtag
ORDER BY 
    COUNT DESC, 
    t.hashtag
LIMIT 1000;
