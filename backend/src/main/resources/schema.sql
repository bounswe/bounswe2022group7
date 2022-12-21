ALTER TABLE ${MYSQL_DATABASE}.art_item_info
    ADD FULLTEXT(name, description, category, labels);

ALTER TABLE ${MYSQL_DATABASE}.event_info
    ADD INDEX(title, description, category, labels);

ALTER TABLE ${MYSQL_DATABASE}.discussion_ost
    ADD FULLTEXT(title, text_body);

ALTER TABLE ${MYSQL_DATABASE}.account_info
    ADD FULLTEXT(name, surname, username, country);