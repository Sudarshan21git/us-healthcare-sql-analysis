USE [Medical_SQL(MRF)];

--1.Find claims where PAID_AMOUNT is greater than the average paid amount.
SELECT * FROM medical
WHERE PAID_AMOUNT>(SELECT AVG(PAID_AMOUNT) FROM medical);


--Q2.Find claims where BILLED_AMOUNT equals the maximum billed amount.

SELECT * FROM medical WHERE BILLED_AMOUNT=(SELECT MAX(BILLED_AMOUNT) FROM medical);


--Q3.Find claims where PATIENT_RESPONSIBILITY is less than the average patient responsibility.

SELECT * FROM medical WHERE PATIENT_RESPONSIBILITY<(SELECT AVG(PATIENT_RESPONSIBILITY) FROM medical);


--Q4.Find claims where PAID_AMOUNT is greater than the maximum PATIENT_RESPONSIBILITY.

SELECT * FROM medical
WHERE 
PAID_AMOUNT > 
(SELECT MAX(PATIENT_RESPONSIBILITY) FROM medical);


--Q5.1. Find members whose MEMBER_ID matches the MEMBER_ID of the member with the maximum billed claim. 
--Think carefully about whether the inner query returns one value.

SELECT * FROM  medical;
SELECT * FROM eligibility;
SELECT * FROM pharmacy;

SELECT *
FROM eligibility
WHERE MEMBER_ID IN (
    SELECT MEMBER_ID
    FROM medical
    WHERE BILLED_AMOUNT = (
        SELECT MAX(BILLED_AMOUNT)
        FROM medical
    )
);





--Find all members whose total BILLED_AMOUNT is greater than the average total billed amount per member.

SELECT MEMBER_ID,SUM(BILLED_AMOUNT) AS Total_billed FROM medical
GROUP BY MEMBER_ID
HAVING SUM(BILLED_AMOUNT)>(SELECT AVG(Total_billed) FROM (SELECT SUM(BILLED_AMOUNT) AS Total_billed FROM medical 
GROUP BY MEMBER_ID) As member_totals);

SELECT MEMBER_ID,
       SUM(BILLED_AMOUNT) AS Total_billed
FROM medical
GROUP BY MEMBER_ID
HAVING SUM(BILLED_AMOUNT) > (
    SELECT AVG(Total_billed)
    FROM (
        SELECT SUM(BILLED_AMOUNT) AS Total_billed
        FROM medical
        GROUP BY MEMBER_ID
    ) AS member_totals
);
