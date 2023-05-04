SELECT t.lang, 
     COUNT(*) as COUNT
FROM (
     SELECT DISTINCT data->>'id',
                     data->>'lang' as lang
     FROM tweets_jsonb
     WHERE data ->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
       UNION 
     SELECT DISTINCT data->>'id',
            data->>'lang' as lang
     FROM tweets_jsonb
     WHERE  data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
)t
GROUP BY lang
ORDER BY COUNT desc, lang;
