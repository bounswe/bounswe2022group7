ALTER TABLE artshare.art_item_info
    ADD FULLTEXT(name, description, category, labels);

ALTER TABLE artshare.event_info
    ADD FULLTEXT(title, description, category, labels);

ALTER TABLE artshare.discussion_post
    ADD FULLTEXT(title, text_body);

ALTER TABLE artshare.account_info
    ADD FULLTEXT(name, surname, username, country);