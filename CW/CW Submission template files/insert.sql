-- Part 2.2 insert.sql
--
-- Submitted by: <Soyoung Park>, <student number: 1902717 k-number: k1924928>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
-- error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- Coach: idCoach, name, surname, DoB, phone, gender, dailySalary 
INSERT INTO Coach (name, surname, phone, gender, dailySalary) VALUES ('Alex', 'Smith', '07513443335', 'M', 100), ('Blue', 'Jubilee', '07899990001','F', 200), ('Bang', 'Gang', '07056567878', 'M', 210);
INSERT INTO Coach (name, surname, DoB, phone, gender, dailySalary) VALUES ('Catherine', 'Sky', '1989-11-01', '07410101234', 'F', 150);

-- Contender: idContender, type, stageName, FKCoach
INSERT INTO Contender (type, stageName, FKCoach) VALUES ('G', 'Urbanner', 1), ('I', 'Zara', 1), ('I', 'Becky', 1), ('I', 'Harmony', 2), ('I', 'In the Groove', 2), ('I', 'Soulmate', 3);

-- Participants: idParticipant, name, surname, DoB, phone, dailySalary, gender, FKContender
INSERT INTO Participants(name, surname, phone, dailySalary, gender, FKContender) VALUES ('Louis', 'Johnson', '07912341234', 55, 'M', 1), ('Rosa', 'Fetal', '04519239229', 60, 'F', 1), ('Nevil', 'Grunge', '07869483675', 45, 'F', 1), ('Dave', 'Hedrick', '07654893987', 35, 'M', 1);
INSERT INTO Participants(name, surname, DOB, phone, dailySalary, gender, FKContender) VALUES ('Jack', 'Oval', '1999-12-12', '07910293848', 50, 'M', 1), ('Zara', 'Rola', '2000-06-09', '07934567890', 65, 'F', 2), ('Becky', 'Linda', '2001-05-17', '07856473999', 70, 'F', 3);
INSERT INTO Participants(name, surname, phone, dailySalary, gender, FKContender) VALUES ('Harmony', 'Shein', '07345678901', 60, 'F', 4), ('Paul', 'Lee', '07959483796', 70, 'M', 5), ('Ed', 'Kenny', '07279635735', 50, 'M', 6);

-- TVShow: idShow, showDate, startTime, endTime, location
-- March (10)
INSERT INTO TVShow(showDate, startTime, endTime) VALUES ('2019-03-02', '200000', '220000'), ('2019-03-03', '160000', '180000'), ('2019-03-09', '200000', '220000'), ('2019-03-10', '160000', '180000');
INSERT INTO TVShow(showDate, startTime, endTime, location) VALUES ('2019-03-16', '200000', '220000', 'Bush House');
INSERT INTO TVShow(showDate, startTime, endTime) VALUES ('2019-03-17', '160000', '180000'), ('2019-03-23', '200000', '220000'), ('2019-03-24', '160000', '180000');
INSERT INTO TVShow(showDate, startTime, endTime, location) VALUES ('2019-03-30', '200000', '220000', 'Bush House');
INSERT INTO TVShow(showDate, startTime, endTime) VALUES ('2019-03-31', '160000', '180000');

-- April (8)
INSERT INTO TVShow(showDate, startTime, endTime) VALUES ('2019-04-06', '153000', '173000');
INSERT INTO TVShow(showDate, startTime, endTime, location) VALUES ('2019-04-07', '181000', '201000', 'Bush House');
INSERT INTO TVShow(showDate, startTime, endTime) VALUES ('2019-04-13', '153000', '173000'), ('2019-04-14', '181000', '201000'), ('2019-04-20', '153000', '173000');
INSERT INTO TVShow(showDate, startTime, endTime, location) VALUES ('2019-04-21', '181000', '201000', 'Wembley Stadium'), ('2019-04-27', '153000', '173000', 'Wembley Stadium'), ('2019-04-28', '181000', '201000', 'Wembley Stadium');

-- Coach in show: idCoach, idShow
INSERT INTO coachInShow VALUES (1, 1), (2, 1), (3, 1), (4, 1);
INSERT INTO coachInShow VALUES (1, 2), (2, 2), (3, 2);
INSERT INTO coachInShow VALUES (1, 3), (2, 3), (3, 3), (4, 3);
INSERT INTO coachInShow VALUES (2, 4), (3, 4), (4, 4);
INSERT INTO coachInShow VALUES (3, 5), (4, 5);
INSERT INTO coachInShow VALUES (1, 6), (2, 6), (3, 6), (4, 6);
INSERT INTO coachInShow VALUES (1, 7), (3, 7), (4, 7);
INSERT INTO coachInShow VALUES (1, 8), (2, 8), (3, 8), (4, 8);
INSERT INTO coachInShow VALUES (4, 9);
INSERT INTO coachInShow VALUES (3, 10), (4, 10);
INSERT INTO coachInShow VALUES (2, 11), (3, 11), (4, 11);
INSERT INTO coachInShow VALUES (3, 12);
INSERT INTO coachInShow VALUES (1, 13), (2, 13), (3, 13), (4, 13);
INSERT INTO coachInShow VALUES (1, 14), (3, 14);
INSERT INTO coachInShow VALUES (2, 15), (4, 15);
INSERT INTO coachInShow VALUES (1, 16), (2, 16), (3, 16), (4, 16);
INSERT INTO coachInShow VALUES (2, 17), (3, 17), (4, 17);
INSERT INTO coachInShow VALUES (3, 18), (4, 18);

-- Contender in show: idContender, idShow
INSERT INTO contenderInShow VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18);

INSERT INTO contenderInShow VALUES (2, 1), (2, 2), (2, 3), (2, 4), (2, 6), (2, 7), (2, 8), (2, 9), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18);

INSERT INTO contenderInShow VALUES (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 8), (3, 12), (3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18);

INSERT INTO contenderInShow VALUES (4, 1), (4, 2), (4, 3), (4, 4), (4, 7), (4, 8), (4, 9), (4, 13), (4, 14), (4, 15), (4, 16), (4, 17), (4, 18);

INSERT INTO contenderInShow VALUES (5, 1), (5, 3), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 14), (5, 15), (5, 16), (5, 17), (5, 18);

INSERT INTO contenderInShow VALUES (6, 1), (6, 2), (6, 5), (6, 6), (6, 8), (6, 9), (6, 15), (6, 16), (6, 17), (6, 18);
