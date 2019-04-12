CREATE TABLE pollresponse(
    poll_id INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
    response VARCHAR(255) NOT NULL,
    PRIMARY KEY(poll_id,username)
  --  FOREIGN KEY poll_id REFERENCES poll(poll_id),
  --  FOREIGN KEY username REFERENCES users(username)
);
