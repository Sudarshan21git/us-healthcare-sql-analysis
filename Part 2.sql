USE [Medical_SQL(MRF)];
--Aggregations
--How many members are in the eligibility table?
SELECT COUNT(*) AS TOTAL_MEMBER 
FROM eligibility;

--What is the total billed amount of all medical claims?
SELECT SUM(BILLED_AMOUNT) AS Total_billed_amount FROM medical;
--What is the average paid amount for medical claims?
SELECT AVG(PAID_AMOUNT) AS AVG_AMOUNT FROM medical;
--What is the highest patient responsibility in the pharmacy data?
SELECT MAX(PATIENT_RESPONSIBILITY) AS Highest_patient FROM pharmacy;
--How many medical claims are there for each claim status?
SELECT COUNT(*) AS medical_calim,CLAIM_STATUS FROM medical 
GROUP BY CLAIM_STATUS;

SELECT * FROM medical;
SELECT * FROM eligibility;

--GROUP BY
--How many members are enrolled in each plan?
SELECT COUNT(*) AS member ,PLAN_NAME FROM eligibility 
GROUP BY PLAN_NAME;
--How many members are there under each carrier?
SELECT COUNT(*) AS MEMBER ,CARRIER_NAME FROM eligibility
GROUP BY CARRIER_NAME;
--What is the total billed amount for each claim type?
SELECT SUM(BILLED_AMOUNT) AS Total_billed_amount ,CLAIM_TYPE 
FROM medical GROUP BY CLAIM_TYPE;
--What is the total paid amount for each claim status?
SELECT CLAIM_STATUS,SUM(PAID_AMOUNT) AS total_paid_amount FROM medical
GROUP BY CLAIM_STATUS;
--What is the total pharmacy paid amount for each drug?
SELECT DIAGNOSIS_CODE,SUM(PAID_AMOUNT) AS total_paid FROM medical GROUP BY DIAGNOSIS_CODE;


--GROUP BY + ORDER BY
--Which carrier has the most members?
SELECT CARRIER_NAME,COUNT(*) AS total_member FROM eligibility 
GROUP BY CARRIER_NAME
ORDER BY total_member DESC;
--Which drug has the highest total pharmacy paid amount?
SELECT  TOP 1 DIAGNOSIS_CODE,SUM(PAID_AMOUNT) AS Total_AMOUNT FROM medical
GROUP BY DIAGNOSIS_CODE
ORDER BY Total_AMOUNT DESC;
 --Which claim type has the highest average billed amount?
 SELECT CLAIM_TYPE,AVG(BILLED_AMOUNT) AS Average_amount FROM medical
 GROUP BY CLAIM_TYPE
 ORDER BY Average_amount DESC;


 --HAVING
 --Find plans that have more than 15 members.
SELECT PLAN_NAME, COUNT(*) AS member_count
FROM eligibility
GROUP BY PLAN_NAME
HAVING COUNT(*) > 15;
--Find claim statuses where the total paid amount is greater than 10,000.
SELECT CLAIM_STATUS,SUM(PAID_AMOUNT) AS total_amount FROM medical
GROUP BY CLAIM_STATUS
HAVING SUM(PAID_AMOUNT)>10000;


--JOINs
--Display member names with their medical claims.
SELECT CONCAT(e.FIRST_NAME,'',e.LAST_NAME) AS FULL_NAME,m.CLAIM_TYPE,m.CLAIM_ID
FROM eligibility AS e
JOIN medical AS m ON
e.MEMBER_ID=m.MEMBER_ID;




--Display all members and their medical claims.
SELECT * FROM eligibility AS E
JOIN medical AS M
ON E.MEMBER_ID=M.MEMBER_ID;

--Find members who have no medical claims.
SELECT E.* FROM eligibility AS E
 LEFT JOIN medical AS M
ON E.MEMBER_ID=M.MEMBER_ID
WHERE M.MEMBER_ID IS NULL;


--JOIN + Aggregation
--Calculate the total medical paid amount for each member.
SELECT SUM(M.PAID_AMOUNT) AS Total_medical_paid,E.MEMBER_ID,CONCAT(E.FIRST_NAME,' ', E.LAST_NAME) AS FULL_NAME
FROM eligibility AS E
INNER JOIN medical AS M ON
E.MEMBER_ID=M.MEMBER_ID
GROUP BY E.FIRST_NAME,E.LAST_NAME,E.MEMBER_ID;

--Find the members with a total medical paid amount greater than 5,000.
SELECT SUM(M.PAID_AMOUNT) AS Total_medical_paid,E.MEMBER_ID,CONCAT(E.FIRST_NAME,' ', E.LAST_NAME) AS FULL_NAME
FROM eligibility AS E
INNER JOIN medical AS M ON
E.MEMBER_ID=M.MEMBER_ID
GROUP BY E.FIRST_NAME,E.LAST_NAME,E.MEMBER_ID
HAVING SUM(M.PAID_AMOUNT)>5000;

--Pharmacy + Eligibility

--21.Find the total pharmacy paid amount for each member
SELECT * FROM eligibility;
SELECT * FROM Pharmacy;

SELECT SUM(P.PAID_AMOUNT) AS Total_amount,E.MEMBER_ID
FROM eligibility AS E
JOIN pharmacy AS P
ON P.MEMBER_ID=E.MEMBER_ID
GROUP BY E.MEMBER_ID;

--22.Find active members whose total pharmacy paid amount is greater than 500.

SELECT SUM(P.PAID_AMOUNT) AS Total_amount,E.MEMBER_ID
FROM eligibility AS E
JOIN pharmacy AS P
ON P.MEMBER_ID=E.MEMBER_ID
WHERE E.MEMBER_STATUS='Active'
GROUP BY E.MEMBER_ID
HAVING SUM(P.PAID_AMOUNT)>500;

--23.Which health plan has the highest total medical paid amount?
SELECT E.PLAN_NAME,SUM(P.PAID_AMOUNT) AS Total_amnt_paid
FROM eligibility AS E
INNER JOIN pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID
GROUP BY E.PLAN_NAME
ORDER BY Total_amnt_paid DESC;


--24.Calculate the total billed amount for each insurance carrier.
SELECT E.PLAN_NAME,E.CARRIER_NAME,SUM(P.PAID_AMOUNT) AS Total_amnt_paid
FROM eligibility AS E
INNER JOIN pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID
GROUP BY E.PLAN_NAME,E.CARRIER_NAME
ORDER BY Total_amnt_paid DESC;


--25.Calculate the total paid amount for each active member and display the highest-spending members first.

SELECT SUM(P.PAID_AMOUNT) AS Total_paid_amount,E.MEMBER_ID,E.MEMBER_STATUS
FROM eligibility AS E
INNER JOIN pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID 
WHERE E.MEMBER_STATUS='Active'
GROUP BY E.MEMBER_STATUS,E.MEMBER_ID
ORDER BY Total_paid_amount DESC;

--Q26Find the total pharmacy paid amount for each insurance carrier.

SELECT SUM(P.PAID_AMOUNT) AS Total_paid_amount,E.CARRIER_NAME
FROM eligibility AS E
INNER JOIN pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID
GROUP BY E.CARRIER_NAME
ORDER BY Total_paid_amount DESC;