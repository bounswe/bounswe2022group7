ALTER TABLE testdb.art_item_info
    ADD FULLTEXT(name, description, category, labels);

ALTER TABLE testdb.event_info
    ADD INDEX(title, description, category, labels);

ALTER TABLE testdb.discussion_ost
    ADD FULLTEXT(title, text_body);

ALTER TABLE testdb.account_info
    ADD FULLTEXT(name, surname, username, country);