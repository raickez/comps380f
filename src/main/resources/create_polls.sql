CREATE TABLE poll (
    course_id INTEGER NOT NULL, 
    response1 VARCHAR(255) NOT NULL,
    response2 VARCHAR(255) NOT NULL,
    response3 VARCHAR(255) NOT NULL,
    response4 VARCHAR(255) NOT NULL,
    responsecount1 INTEGER default 0,
    responsecount2 INTEGER default 0,
    responsecount3 INTEGER default 0,
    responsecount4 INTEGER default 0,
    PRIMARY KEY (course_id),
    FOREIGN KEY (course_id) REFERENCES course(id) 
);