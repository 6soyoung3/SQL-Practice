-- Part 2.5 delete.sql
--
-- Submitted by: <Soyoung Park>, <student number: 1902717 k-number: k1924928>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- write the DELETE statement(s) that removes this contender and all their related data from the database

-- Contender with the lowest total salary 
SET @lowestStageName = (SELECT U.stagename FROM (SELECT T.stageName AS stagename, MIN(total)
FROM Contender, Participants,
(SELECT stagename, SUM(hourlySalary) AS total
FROM Participants, Contender
WHERE FKContender = idContender
GROUP BY FKContender
ORDER BY total) T
WHERE FKContender = idContender) U);

-- Delete data from contenderInShow
DELETE FROM contenderInShow
WHERE FKContender IN (SELECT idContender FROM Contender WHERE stageName = @lowestStageName);

-- Delete data from Contender
DELETE FROM Contender 
WHERE @lowestStageName = stageName;

-- Query for deleting data in Participants is not needed due to ON DELETE CASCADE
