-- Part 2.3 select.sql
--
-- Submitted by: <Soyoung Park>, <student number: 1902717 k-number: k1924928>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 


-- 1. Average Female Salary
SELECT AVG(dailySalary)
FROM Participants
WHERE gender = ‘F’;

-- 2. Coaching Report.
SELECT *, (SELECT COUNT(idContender) FROM Contender WHERE Contender.FKCoach = Coach.idCoach) AS Number_Of_Contenders
FROM Coach;

-- 3. Coach Monthly Attendance Report
SELECT name as CoachName, MONTH(showDate) as Month, COUNT(FKCoach) AS numberOfAttended
FROM Coach, coachInShow, TVShow
WHERE idCoach = FKCoach AND idShow = FKShow
GROUP BY idCoach, MONTH(showDate);

-- 4. Most Expensive Contender
SELECT T.stagename AS stageName, MAX(total) AS highestTotalDailySalary
FROM Contender, Participants,
(SELECT stagename, SUM(dailySalary) AS total
FROM Participants, Contender
WHERE FKContender = idContender
GROUP BY FKContender
ORDER BY total DESC) T
WHERE FKContender = idContender
LIMIT 1;

-- 5. March Payment Report
(SELECT name, surname, dailySalary, COUNT(coachInShow.FKCoach) AS numberOfAttendedInMarch, COUNT(coachInShow.FKCoach) * dailySalary AS MarchTotalSalary
FROM coachInShow, TVShow, Coach
WHERE FKCoach = idCoach AND FKShow = idShow AND MONTH(showDate) = 3
GROUP BY idCoach)
UNION
(SELECT name, surname, dailySalary, COUNT(contenderInShow.FKContender) AS numberOfAttendedInMarch, COUNT(contenderInShow.FKContender) * dailySalary AS MarchTotalSalary
FROM Participants, contenderInShow, TVShow
WHERE contenderInShow.FKContender = Participants.FKContender AND idShow = FKShow AND MONTH(showDate) = 3
GROUP BY idParticipant);

-- total amount to be paid in March

SET @coachSalary = (SELECT SUM(B.MarchTotalSalary) 
FROM (SELECT COUNT(coachInShow.FKCoach) * dailySalary AS MarchTotalSalary
FROM coachInShow, TVShow, Coach
WHERE FKCoach = idCoach AND FKShow = idShow AND MONTH(showDate) = 3
GROUP BY idCoach) B);

SET @participantsSalary = (SELECT SUM(C.MarchTotalSalary) 
FROM (SELECT COUNT(contenderInShow.FKContender) * dailySalary AS MarchTotalSalary
FROM contenderInShow, TVShow, Participants
WHERE contenderInShow.FKContender = Participants.FKContender AND idShow = FKShow AND MONTH(showDate) = 3
GROUP BY idParticipant) C);

SELECT CONCAT("The total amount to be paid in March: £ ", ROUND((@coachSalary + @participantsSalary), 1)) AS Total;

-- 6. Well Formed Groups!
SELECT IF((T.numberOfMembers > 1 AND T.type = 'G') OR (T.numberOfMembers = 1 AND T.type = 'I'), 'True', 'False') AS isWellFormed
FROM (SELECT type, COUNT(idParticipant) AS numberOfMembers FROM Participants, Contender WHERE FKContender = idContender GROUP BY FKContender) T;
