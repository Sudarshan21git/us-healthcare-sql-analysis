USE [Medical_SQL(MRF)];

SELECT * FROM eligibility;
SELECT * FROM medical;
SELECT * FROM pharmacy;
---Aggregations

--Q1.1.	How many members are in the eligibility table?
SELECT COUNT(*) FROM eligibility;

--Q2.2.	What is the total billed amount of all medical claims?
SELECT SUM(BILLED_AMOUNT) AS CLAIM_AMOUNT FROM medical;

--Q3.3.	What is the average paid amount for medical claims?
SELECT AVG(PAID_AMOUNT) AS AVG_PAID FROM medical;
--Q4.4.	What is the highest patient responsibility in the pharmacy data?
SELECT MAX(PATIENT_RESPONSIBILITY) AS higesh_patient_with_responsibility FROM pharmacy;
--Q5.5.	How many medical claims are there for each claim status?
SELECT CLAIM_STATUS,COUNT(*) FROM medical GROUP BY CLAIM_STATUS;


--GROUP BY
--6.	How many members are enrolled in each plan?
SELECT PLAN_NAME,COUNT(*) FROM eligibility GROUP BY PLAN_NAME;
--7.	How many members are there under each carrier?
SELECT CARRIER_NAME,COUNT(*) FROM eligibility GROUP BY CARRIER_NAME;
--8.	What is the total billed amount for each claim type?
SELECT SUM(BILLED_AMOUNT),CLAIM_TYPE FROM medical GROUP BY CLAIM_TYPE;
--9.	What is the total paid amount for each claim status?
SELECT SUM(PAID_AMOUNT) AS total_amount,CLAIM_STATUS FROM  medical GROUP BY CLAIM_STATUS;
--10.	What is the total pharmacy paid amount for each drug?
SELECT SUM(PAID_AMOUNT) AS TOTAL_AMOUNT,DRUG_NAME FROM pharmacy GROUP BY DRUG_NAME;



--GROUP BY + ORDER BY
--11.	Which carrier has the most members?
SELECT CARRIER_NAME,COUNT(*) AS Most_member FROM eligibility GROUP BY CARRIER_NAME ORDER BY Most_member  DESC;
--12.	Which drug has the highest total pharmacy paid amount?
SELECT TOP 1 DRUG_NAME,SUM(PAID_AMOUNT) AS TOTAL_PAID_AMOUNT FROM pharmacy GROUP BY DRUG_NAME ORDER BY TOTAL_PAID_AMOUNT DESC;
--13.	 Which claim type has the highest average billed amount?
SELECT AVG(BILLED_AMOUNT) As AVG_BILLED_AMOUNT,CLAIM_TYPE  FROM medical GROUP BY CLAIM_TYPE ORDER BY AVG_BILLED_AMOUNT DESC;


--HAVING
--14.	 Find plans that have more than 15 members.
SELECT COUNT(*) AS TOTAL_MEMBER,PLAN_NAME FROM eligibility GROUP BY PLAN_NAME HAVING COUNT(*)>15 ;
--15.	Find claim statuses where the total paid amount is greater than 10,000.
SELECT CLAIM_STATUS,SUM(PAID_AMOUNT) AS TOTAL_AMOUNT FROM medical GROUP BY CLAIM_STATUS HAVING SUM(PAID_AMOUNT) >10000;

--JOINs
--16.	Display member names with their medical claims.
SELECT E.MEMBER_ID,M.CLAIM_TYPE,CONCAT(E.FIRST_NAME,'' ,E.LAST_NAME) FROM eligibility AS E
INNER JOIN medical AS M
ON E.MEMBER_ID=M.MEMBER_ID;
--17.	Display all members and their medical claims.
SELECT E.MEMBER_ID,CONCAT(E.FIRST_NAME,'',E.LAST_NAME) AS Member_name,M.CLAIM_TYPE FROM eligibility AS E
LEFT JOIN medical AS M
ON M.MEMBER_ID=E.MEMBER_ID;
--18.	Find members who have no medical claims.

SELECT E.MEMBER_ID,CONCAT(E.FIRST_NAME,'',E.LAST_NAME) AS Member_name,M.CLAIM_TYPE FROM eligibility AS E
LEFT JOIN medical AS M
ON M.MEMBER_ID=E.MEMBER_ID
WHERE M.CLAIM_ID IS NULL;


--JOIN + Aggregation
--19.	Calculate the total medical paid amount for each member.
SELECT E.MEMBER_ID ,SUM(M.PAID_AMOUNT) AS PADI_AMOUNT FROM eligibility AS E
INNER JOIN medical AS M ON
M.MEMBER_ID=E.MEMBER_ID GROUP BY E.MEMBER_ID;
--20.	Find the members with a total medical paid amount greater than 5,000.
SELECT E.MEMBER_ID,SUM(M.PAID_AMOUNT) AS Total_paid_amount FROM eligibility AS E
INNER JOIN medical AS M
ON E.MEMBER_ID=M.MEMBER_ID 
GROUP BY E.MEMBER_ID
HAVING SUM(M.PAID_AMOUNT) >5000;


--Pharmacy + Eligibility
SELECT * FROM pharmacy;
SELECT * FROM eligibility;
--21.	Find the total pharmacy paid amount for each member.
SELECT E.MEMBER_ID,SUM(P.PAID_AMOUNT) AS TOTAL_PAID_AMOUNT FROM eligibility
AS E INNER JOIN 
pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID GROUP BY E.MEMBER_ID;
--22.	Find active members whose total pharmacy paid amount is greater than 500.
SELECT E.MEMBER_ID,SUM(P.PAID_AMOUNT) AS TOTAL_PAID_AMOUNT FROM eligibility
AS E INNER JOIN 
pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID WHERE E.MEMBER_STATUS='Active' GROUP BY E.MEMBER_ID
HAVING SUM(P.PAID_AMOUNT)>500;

--23.	Which health plan has the highest total medical paid amount?
SELECT TOP 1
E.MEMBER_ID,SUM(M.PAID_AMOUNT) AS TOTAL_PAID_AMOUNT,E.PLAN_NAME
FROM eligibility
AS E INNER JOIN 
medical AS M
ON E.MEMBER_ID=M.MEMBER_ID GROUP BY E.MEMBER_ID,E.PLAN_NAME ORDER BY TOTAL_PAID_AMOUNT DESC;
--24.	Calculate the total billed amount for each insurance carrier.
SELECT
E.CARRIER_NAME,SUM(P.SUBMITTED_AMOUNT) AS TOTAL_billed_AMOUNT FROM eligibility
AS E INNER JOIN 
pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID GROUP BY E.CARRIER_NAME;
--25.	Calculate the total paid amount for each active member and display the highest-spending members first.
SELECT E.MEMBER_ID,E.MEMBER_STATUS,SUM(P.PAID_AMOUNT) AS TOTAL_PAID_AMOUNT FROM eligibility
AS E INNER JOIN 
pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID WHERE E.MEMBER_STATUS='Active'  GROUP BY E.MEMBER_ID,E.MEMBER_STATUS
ORDER BY TOTAL_PAID_AMOUNT DESC;

---26.	Find the total pharmacy paid amount for each insurance carrier.
SELECT E.MEMBER_ID,E.CARRIER_NAME,SUM(P.PAID_AMOUNT) AS TOTAL_billed_AMOUNT FROM eligibility
AS E INNER JOIN 
pharmacy AS P
ON E.MEMBER_ID=P.MEMBER_ID GROUP BY E.MEMBER_ID,E.CARRIER_NAME;