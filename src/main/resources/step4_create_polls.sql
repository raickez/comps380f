 CREATE TABLE poll (
    poll_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), 
    question VARCHAR(255) NOT NULL,
    response1 VARCHAR(255) NOT NULL,
    response2 VARCHAR(255) NOT NULL,
    response3 VARCHAR(255) NOT NULL,
    response4 VARCHAR(255) NOT NULL,
    PRIMARY KEY (poll_id)
);