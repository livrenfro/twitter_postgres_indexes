CREATE INDEX tt_t_idt ON tweet_tags(tag, id_tweets);
CREATE INDEX tt_idt_t ON tweet_tags(id_tweets, tag);
CREATE INDEX t_idt_l ON tweets(id_tweets, lang);
CREATE INDEX t_ttsv ON tweets USING gin(to_tsvector('english',text) WHERE lang='en');
