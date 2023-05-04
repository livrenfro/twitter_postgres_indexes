SELECT '#' || t.tag as tag,
          count(*) as count
FROM (
SELECT data->>'id',
              jsonb_path_query(data, '$.extended_tweet.entities.hashtags[*]')->>'text' AS tag
FROM tweets_jsonb
WHERE data ->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
UNION 
SELECT data->>'id',
          jsonb_path_query(data, '$.entities.hashtags[*]')->>'text' as tag
FROM tweets_jsonb
WHERE  data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
)t
GROUP BY (1)
ORDER BY count DESC, (1)
LIMIT 1000;
