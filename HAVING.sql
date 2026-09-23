USE [Medical_SQL(MRF)];
SELECT * FROM eligibility;


--HAVING
--Q1.Find carriers that have more than 10 members. Display the carrier name and member count.
SELECT CARRIER_NAME,COUNT(*) AS MEMBER_COUNT FROM eligibility
GROUP BY CARRIER_NAME HAVING COUNT(*)>10;

--Q2.Find health plans that have more than 5 members. Display the plan name and member count.
SELECT PLAN_NAME,COUNT(*) AS MEMBER_COUNT FROM eligibility
GROUP BY	PLAN_NAME
HAVING COUNT(*)>5;

--Q3.Find coverage types that have at least 10 members. Display the coverage type and member count.
SELECT COVERAGE_TYPE,COUNT(*) AS MEMBER_COUNT FROM eligibility
GROUP BY COVERAGE_TYPE HAVING COUNT(*)>=10;

--Q4.Find carriers that have more than 5 active members. Display the carrier name and active member count.
SELECT CARRIER_NAME,COUNT(*) AS Active_Member FROM eligibility
WHERE MEMBER_STATUS='Active' 
GROUP BY CARRIER_NAME
HAVING COUNT(*)>5;


--Q5.Find combinations of carrier and plan that have more than 3 members. Display the carrier name, plan name and member count.
SELECT  CARRIER_NAME,PLAN_NAME,COUNT(*) AS MEMBER_COUNT FROM eligibility
GROUP BY CARRIER_NAME,PLAN_NAME
HAVING COUNT(*)>3;


