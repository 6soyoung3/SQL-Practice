 -- Part 2.1 schema.sql
--
-- Submitted by: <Soyoung Park>, <student number: 1902717 k-number: k1924928>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
-- error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- DDL:

CREATE TABLE Coach(
	idCoach TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(15) NOT NULL,
	surname VARCHAR(15) NOT NULL,
	DoB DATE,
	phone VARCHAR(15) NOT NULL, -- for both Coach and Participants, phone numbers should not be null as the TV show needs to be keep in touch with them
	gender CHAR(1) NOT NULL, -- assume there are only two genders (F/M)
	dailySalary FLOAT NOT NULL, -- the dailySalary can be xxx.5 which means it is not necessarily int value 
	PRIMARY KEY (idCoach)
);

CREATE TABLE TVShow(
	idShow TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	showDate DATE NOT NULL,
	startTime TIME NOT NULL,
	endTime TIME NOT NULL,
	location VARCHAR(20) DEFAULT 'studio', -- unless specified, the default is Studio
	PRIMARY KEY (idShow)
);	

-- trigger for valid show's startTime and endTime
delimiter //
CREATE TRIGGER validShowTime BEFORE INSERT ON TVShow
FOR EACH ROW
BEGIN
	IF NEW.endTime < NEW.startTime THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid endTime or startTime';
	END IF;
END; //
	
CREATE TABLE Contender(
	idContender TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	type CHAR(1) NOT NULL, -- must be either I or G
	stageName VARCHAR(20) UNIQUE NOT NULL, -- there cannot be two different teams with the same stageName
	FKCoach TINYINT UNSIGNED,
	PRIMARY KEY(idContender),

	FOREIGN KEY (FKCoach) REFERENCES Coach (idCoach)
	ON DELETE SET NULL ON UPDATE CASCADE
);

-- replace the previous coach to different coach who has idCoach = 1 (default coach)
CREATE TRIGGER replaceCoach BEFORE DELETE ON Coach
FOR EACH ROW
  UPDATE Contender SET idCoach = 1 WHERE idCoach = old.idCoach;

-- checks if the contender's type is 'I' or 'G'
delimiter //
CREATE TRIGGER invalidTypeChar BEFORE INSERT ON Contender
FOR EACH ROW
BEGIN
	IF NEW.type != 'I' AND NEW.type != 'G' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid contender type';
	END IF;
END; //

CREATE TABLE Participants(
	idParticipant TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(15) NOT NULL,
	surname VARCHAR(15) NOT NULL,
	DoB DATE,
	phone VARCHAR(15) NOT NULL,
	gender CHAR(1) NOT NULL,
	dailySalary FLOAT NOT NULL,
	FKContender TINYINT UNSIGNED,
	PRIMARY KEY(idParticipant),

	FOREIGN KEY (FKContender) REFERENCES Contender(idContender)
	ON DELETE CASCADE ON UPDATE CASCADE -- if contender removed or updated, participants forming the group must be removed or updated as well
);

CREATE TABLE coachInShow(
	FKCoach TINYINT UNSIGNED NOT NULL,
	FKShow TINYINT UNSIGNED NOT NULL,
	
	PRIMARY KEY(FKCoach, FKShow),

	FOREIGN KEY(FKCoach) REFERENCES Coach(idCoach)
	ON DELETE CASCADE ON UPDATE CASCADE, -- DELETE CASCADE is used as the coach information must be deleted 
	FOREIGN KEY(FKShow) REFERENCES TVShow(idShow)
	ON DELETE RESTRICT ON UPDATE CASCADE -- if the coach already attended the show, the record of show cannot be deleted
);
-- updating is allowed as either coach or TVShow might have been a typo which needs to be updated

CREATE TABLE contenderInShow(
	FKContender TINYINT UNSIGNED NOT NULL,
	FKShow TINYINT UNSIGNED NOT NULL,
	PRIMARY KEY(FKContender, FKShow),

	FOREIGN KEY(FKContender) REFERENCES Contender(idContender)
	ON DELETE CASCADE ON UPDATE CASCADE, -- DELETE CASCADE is used as the contender information must be deleted
	FOREIGN KEY(FKShow) REFERENCES TVShow(idShow)
	ON DELETE RESTRICT ON UPDATE CASCADE -- if the contender already attended the show, the record cannot be deleted
);
-- updating is allowed as either contender or TVShow might have been a typo which needs to be updated
