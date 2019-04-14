CREATE TABLE pollcomment (
    commentid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    poll_id INTEGER NOT NULL, 
    comment VARCHAR(255) NOT NULL,
    PRIMARY KEY (commentid),
    FOREIGN KEY (poll_id) REFERENCES poll(poll_id) 
);