-- Populate forum table
COPY forum FROM 'PATHVAR/dynamic/forum_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate forum_person table
COPY forum_person FROM 'PATHVAR/dynamic/forum_hasMember_person_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate forum_tag table
COPY forum_tag FROM 'PATHVAR/dynamic/forum_hasTag_tag_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate organisation table
COPY organisation FROM 'PATHVAR/static/organisation_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person table
COPY person FROM 'PATHVAR/dynamic/person_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person_email table
COPY person_email FROM 'PATHVAR/dynamic/person_email_emailaddress_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person_tag table
COPY person_tag FROM 'PATHVAR/dynamic/person_hasInterest_tag_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate knows table
COPY knows ( k_person1id, k_person2id, k_creationdate) FROM 'PATHVAR/dynamic/person_knows_person_0_0.csv' WITH DELIMITER '|' CSV HEADER;
COPY knows ( k_person2id, k_person1id, k_creationdate) FROM 'PATHVAR/dynamic/person_knows_person_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate likes table
COPY likes FROM 'PATHVAR/dynamic/person_likes_post_0_0.csv' WITH DELIMITER '|' CSV HEADER;
COPY likes FROM 'PATHVAR/dynamic/person_likes_comment_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person_language table
COPY person_language FROM 'PATHVAR/dynamic/person_speaks_language_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person_university table
COPY person_university FROM 'PATHVAR/dynamic/person_studyAt_organisation_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate person_company table
COPY person_company FROM 'PATHVAR/dynamic/person_workAt_organisation_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate place table
COPY place FROM 'PATHVAR/static/place_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate message_tag table
COPY message_tag FROM 'PATHVAR/dynamic/post_hasTag_tag_0_0.csv' WITH DELIMITER '|' CSV HEADER;
COPY message_tag FROM 'PATHVAR/dynamic/comment_hasTag_tag_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate tagclass table
COPY tagclass FROM 'PATHVAR/static/tagclass_0_0.csv' WITH DELIMITER '|' CSV HEADER;

-- Populate tag table
COPY tag FROM 'PATHVAR/static/tag_0_0.csv' WITH DELIMITER '|' CSV HEADER;


-- PROBLEMATIC

-- Populate message table
COPY message (m_messageid, m_ps_imagefile, m_creationdate, m_locationip, m_browserused, m_ps_language, m_content, m_length, m_creatorid, m_ps_forumid, m_locationid) FROM 'PATHVAR/dynamic/post_0_0.csv' WITH (FORCE_NOT_NULL ("m_content"),  DELIMITER '|', HEADER, FORMAT csv);
COPY message FROM 'PATHVAR/dynamic/comment_0_0-postgres.csv' WITH (FORCE_NOT_NULL ("m_content"),  DELIMITER '|', HEADER, FORMAT csv);

create view country as select city.pl_placeid as ctry_city, ctry.pl_name as ctry_name from place city, place ctry where city.pl_containerplaceid = ctry.pl_placeid and ctry.pl_type = 'country';

vacuum analyze;
