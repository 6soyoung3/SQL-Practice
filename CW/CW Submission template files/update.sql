-- Part 2.4 update.sql
--
-- Submitted by: <Soyoung Park>, <student number: 1902717 k-number: k1924928>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- 1. Update the coach and participant information to only contain the hourly payment
ALTER TABLE Coach
ADD COLUMN hourlySalary FLOAT NOT NULL AFTER dailySalary;
ALTER TABLE Participants
ADD COLUMN hourlySalary FLOAT NOT NULL AFTER dailySalary;

UPDATE Coach SET hourlySalary = dailySalary / 4;
UPDATE Participants SET hourlySalary = dailySalary / 4;

ALTER TABLE Coach
DROP dailySalary;
ALTER TABLE Participants
DROP dailySalary;

-- 2. Add new fields to the attendance table to register when coaches and contenders arrive to and leave the shows
ALTER TABLE coachInShow
ADD COLUMN arriveTime TIME NOT NULL,
ADD COLUMN leaveTime TIME NOT NULL;

ALTER TABLE contenderInShow
ADD COLUMN arriveTime TIME NOT NULL,
ADD COLUMN leaveTime TIME NOT NULL;

-- 3. UPDATE the attendance information to include the arrival and departure times for the past shows
UPDATE coachInShow AS T1, (SELECT idShow, startTime, endTime FROM TVShow) AS T2
SET T1.arriveTime = SUBTIME(T2.startTime, '1:00:00'), T1.leaveTime = ADDTIME(T2.endTime, '1:00:00')
WHERE T1.FKShow = T2.idShow;

UPDATE contenderInShow AS T1, (SELECT idShow, startTime, endTime FROM TVShow) AS T2
SET T1.arriveTime = SUBTIME(T2.startTime, '1:00:00'), T1.leaveTime = ADDTIME(T2.endTime, '1:00:00')
WHERE T1.FKShow = T2.idShow;

