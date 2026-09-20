USE [Medical_SQL(MRF)];
SELECT * FROM eligibility;


--Q1.Display each member status and the number of members with that status.
SELECT MEMBER_STATUS,COUNT(*) AS number_of_members FROM eligibility  GROUP BY MEMBER_STATUS;
--Q2.Display each carrier name and its total number of members.
SELECT  CARRIER_NAME ,COUNT(*) AS total_number FROM eligibility GROUP BY CARRIER_NAME;
--Q3.Display each coverage type and its total number of members.
SELECT COVERAGE_TYPE,COUNT(*) AS total_number FROM eligibility GROUP BY COVERAGE_TYPE; 
--Q4.Display each plan name and its total number of members, sorted from highest to lowest count.
SELECT PLAN_NAME,COUNT(*) AS Total_number
FROM eligibility GROUP BY PLAN_NAME 
ORDER BY Total_number DESC;
--Q5.Count only active members for each carrier.
SELECT  CARRIER_NAME,COUNT(*) as Total_active_number
FROM eligibility WHERE MEMBER_STATUS='Active'
GROUP BY CARRIER_NAME;
--Q6.Display each carrier name and member status combination, with its member count.
SELECT CARRIER_NAME,MEMBER_STATUS,COUNT(*) AS Member_Count
FROM eligibility 
GROUP BY CARRIER_NAME,MEMBER_STATUS;
--Q7.Display only carriers that have more than 10 members.
SELECT CARRIER_NAME,COUNT(*) AS total_member FROM eligibility GROUP BY CARRIER_NAME HAVING COUNT(*)>10;
--Q8.Display only plans that have more than 5 active members, sorted from highest to lowest count.
SELECT PLAN_NAME, MEMBER_STATUS ,COUNT(*) total_number_member  FROM eligibility WHERE MEMBER_STATUS='Active' GROUP BY PLAN_NAME,MEMBER_STATUS HAVING COUNT(*)>5 ORDER BY COUNT(*)  DESC;


