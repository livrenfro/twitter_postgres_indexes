CREATE INDEX d_e_e_h ON tweets_jsonb using gin((data ->'extended_tweet'->'entities'->'hashtags'));

CREATE INDEX d_e_h ON tweets_jsonb using gin((data ->'entities'->'hashtags'));

CREATE INDEX d_l ON tweets_jsonb USING gin((data->'lang'));

CREATE INDEX c_d_e_f_t ON tweets_jsonb USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))) WHERE data->>'lang'='en';

CREATE INDEX c_d_e_f_t_e_h ON tweets_jsonb USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')),
    (data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')));
