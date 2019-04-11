CREATE TABLE comment (
    commentid INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    lecture_id INTEGER NOT NULL, 
    comment VARCHAR(255) NOT NULL,
    PRIMARY KEY (commentid),
    FOREIGN KEY (lecture_id) REFERENCES lecture(id) 
);