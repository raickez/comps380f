CREATE TABLE comment (
    username VARCHAR(50) NOT NULL,
    course_id INTEGER NOT NULL, 
    comment VARCHAR(255) NOT NULL,
    PRIMARY KEY (username,course_id),
    FOREIGN KEY (username) REFERENCES users(username), 
    FOREIGN KEY (course_id) REFERENCES course(id) 
);