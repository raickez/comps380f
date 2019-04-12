INSERT INTO lecture(name,subject) VALUES ('Week 1: Overview, HTML5, CSS, JavaScript','Overview of Web Applications');
INSERT INTO lecture(name,subject) VALUES ('Week 2: Servlet, XML, JSON','Servlet');
INSERT INTO lecture(name,subject) VALUES ('Week 3: JSP, JavaBean','JSP, JavaBean');
INSERT INTO lecture(name,subject) VALUES ('Week 4: Session','Session');

INSERT INTO users VALUES ('keith', 'keithpw');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_USER');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO users VALUES ('tsli', 'tslipw');
INSERT INTO user_roles(username, role) VALUES ('tsli', 'ROLE_ADMIN');

INSERT INTO users VALUES ('kevin', 'kevinpw');
INSERT INTO user_roles(username, role) VALUES ('kevin', 'ROLE_USER');

INSERT INTO users VALUES ('oliver', 'oliverpw');
INSERT INTO user_roles(username, role) VALUES ('oliver', 'ROLE_USER');

INSERT INTO users VALUES ('dan', 'danpw');
INSERT INTO user_roles(username, role) VALUES ('dan', 'ROLE_USER');


INSERT INTO comment(username,lecture_id,comment) VALUES ('keith',1,'Welcome to my class!');
INSERT INTO comment(username,lecture_id,comment) VALUES ('dan',1,'Hello Keith!');

INSERT INTO poll(question,response1,response2,response3,response4) VALUES ('What date do you prefer for the midterm test?','1st Apr,2019','2nd Apr,2019','3rd Apr,2019','4th Apr,2019');
INSERT INTO pollresponse(poll_id,username,response) VALUES (1,'dan','1st Apr,2019');
INSERT INTO pollresponse(poll_id,username,response) VALUES (1,'oliver','2nd Apr,2019');
