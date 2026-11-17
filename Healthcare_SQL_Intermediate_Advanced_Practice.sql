USE [Medical_SQL(MRF)];
SELECT * FROM eligibility;
SELECT * FROM pharmacy;
SELECT * FROM medical;

/*
1.	Display all members and show: (Also create a column called MEMBERSHIP_END_DATE.)
?	TERMINATION_DATE if available
?	Otherwise today's date

*/

SELECT MEMBER_ID,FIRST_NAME,LAST_NAME,COALESCE(TERMINATION_DATE,CAST(GETDATE()AS DATE)) AS DATE FROM eligibility

/*2.	 Display:
?	Member ID
?	Full name in uppercase
?	Carrier name in uppercase
?	Plan name in lowercase
*/

SELECT MEMBER_ID,UPPER(CONCAT(FIRST_NAME ,' ' ,LAST_NAME)) AS FULL_NAME ,UPPER(CARRIER_NAME) CARRIER_NAME,LOWER(PLAN_NAME) AS PLAN_NAME  FROM eligibility;

--3.	 Display the first three characters of each member ID along with the member's name and carrier.
SELECT LEFT(CAST(MEMBER_ID AS varchar(50)),3) AS MEMBER_ID,
CONCAT(FIRST_NAME,'',LAST_NAME) AS FULL_NAME,
CARRIER_NAME 
FROM eligibility;

--4.4.	For every medical claim, calculate the percentage of the billed amount that was paid. Avoid division by zero using NULLIF.
SELECT CLAIM_ID,BILLED_AMOUNT,PAID_AMOUNT,(PAID_AMOUNT*100.0/NULLIF(BILLED_AMOUNT,0)) AS PERCENTAGE FROM medical;


--5.	Display MEMBER_ID, member name, total medical paid amount, and total pharmacy paid amount for members who have both medical and pharmacy claims--

SELECT E.MEMBER_ID,CONCAT(E.FIRST_NAME,'',E.LAST_NAME)AS FULL_NAME,
P.TOTAL_PAID_AMNT,M.TOTAL_PAID_AMNT
FROM eligibility AS E
INNER JOIN(SELECT MEMBER_ID,SUM(PAID_AMOUNT) AS TOTAL_PAID_AMNT FROM medical GROUP BY MEMBER_ID ) AS M ON 
E.MEMBER_ID=M.MEMBER_ID 
INNER JOIN (
SELECT MEMBER_ID,SUM(PAID_AMOUNT) AS TOTAL_PAID_AMNT  FROM pharmacy GROUP BY MEMBER_ID) AS P ON E.MEMBER_ID=P.MEMBER_ID;

;
WITH MedicalTotals AS (
    SELECT 
        MEMBER_ID, 
        SUM(PAID_AMOUNT) AS TOTAL_MEDICAL_PAID
    FROM medical
    GROUP BY MEMBER_ID
),pharmanchy_total as(
SELECT MEMBER_ID,SUM(PAID_AMOUNT) AS TOTAL_PAID FROM pharmacy
GROUP BY MEMBER_ID)

SELECT E.MEMBER_ID,CONCAT(E.FIRST_NAME,'',E.LAST_NAME)AS FULL_NAME,M.TOTAL_MEDICAL_PAID,P.TOTAL_PAID
FROM eligibility AS E
INNER JOIN MedicalTotals AS M ON E.MEMBER_ID=M.MEMBER_ID
INNER JOIN pharmanchy_total AS P ON E.MEMBER_ID=P.MEMBER_ID;
