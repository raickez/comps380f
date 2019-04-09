CREATE TABLE comment (
    username VARCHAR(50) NOT NULL,
    lecture_id INTEGER NOT NULL, 
    comment VARCHAR(255) NOT NULL,
    PRIMARY KEY (username,lecture_id),
    FOREIGN KEY (username) REFERENCES users(username), 
    FOREIGN KEY (lecture_id) REFERENCES lecture(id) 
);