CREATE TABLE pollresponse(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    poll_id INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    response VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
    --FOREIGN KEY poll_id REFERENCES poll(poll_id),
    --FOREIGN KEY username REFERENCES users(username)
);
