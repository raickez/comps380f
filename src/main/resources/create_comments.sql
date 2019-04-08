CREATE TABLE comment (
    user_role_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL, 
    comment VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_role_id,course_id),
    FOREIGN KEY (user_role_id) REFERENCES user_roles(user_role_id), 
    FOREIGN KEY (course_id) REFERENCES course(id) 
);