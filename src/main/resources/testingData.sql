INSERT INTO lecture(name,subject) VALUES ('Week 1: Overview, HTML5, CSS, JavaScript','Lecture 1: Overview of Web Applications');
INSERT INTO lecture(name,subject) VALUES ('Week 2: Servlet, XML, JSON','Lecture 2: Servlet');
INSERT INTO lecture(name,subject) VALUES ('Week 3: JSP, JavaBean','Lecture 3: JSP, JavaBean');
INSERT INTO lecture(name,subject) VALUES ('Week 4: Session','Lecture 4: Session');

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
INSERT INTO comment(username,lecture_id,comment) VALUES ('dan',5,'Hello Keith!');

/*INSERT INTO poll (response1,response2,response3,response4,responsecount1,responsecount2,responsecount3,responsecount4,)*/