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




--sUBQUERY
SELECT * FROM medical;
SELECT * FROM pharmacy;
SELECT * FROM eligibility;
--Q1.Find all medical claims where PAID_AMOUNT is greater than the average PAID_AMOUNT of all medical claims.
SELECT MEMBER_ID,CLAIM_ID,PAID_AMOUNT FROM medical WHERE PAID_AMOUNT>(SELECT AVG(PAID_AMOUNT) FROM medical);
--Q2.Find the medical claim(s) with the highest BILLED_AMOUNT.
SELECT MEMBER_ID,CLAIM_ID,BILLED_AMOUNT FROM medical WHERE BILLED_AMOUNT =(SELECT MAX(BILLED_AMOUNT) FROM medical);
SELECT MAX(BILLED_AMOUNT) FROM medical;
--Q3.Find all pharmacy claims where PAID_AMOUNT is equal to the minimum PAID_AMOUNT in the pharmacy table.
SELECT MEMBER_ID,RX_CLAIM_ID,PAID_AMOUNT FROM pharmacy 
WHERE PAID_AMOUNT =(SELECT MIN(PAID_AMOUNT) FROM pharmacy);
--Q4.4. Intermediate — Comparing two tables;
--Find all medical claims where PAID_AMOUNT is greater than the average PAID_AMOUNT in the pharmacy table.
SELECT MEMBER_ID,PAID_AMOUNT FROM medical WHERE PAID_AMOUNT>(SELECT AVG(PAID_AMOUNT) FROM pharmacy);
--Q5.Find the second-highest distinct PAID_AMOUNT in the medical table using nested subqueries.
SELECT DISTINCT PAID_AMOUNT FROM medical WHERE PAID_AMOUNT=
(SELECT MAX(PAID_AMOUNT) FROM medical WHERE PAID_AMOUNT<(SELECT MAX(PAID_AMOUNT) FROM medical));




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



--Find all members from eligibility who have at least one medical claim.
SELECT MEMBER_ID,CONCAT(FIRST_NAME,'',LAST_NAME) AS FULL_NAME 
FROM eligibility
WHERE MEMBER_ID IN(SELECT MEMBER_ID FROM medical);
--WE CAN DO THIS BY USING INNER JOIN
SELECT E.MEMBER_ID,CONCAT(FIRST_NAME,'',LAST_NAME) AS FULL_NAME
FROM eligibility AS E
INNER JOIN 
medical AS M ON E.MEMBER_ID=M.MEMBER_ID;

--Find members from eligibility who do not have any pharmacy claims.
SELECT MEMBER_ID,CONCAT(FIRST_NAME,'',LAST_NAME) AS FULL_NAME  FROM eligibility
WHERE MEMBER_ID NOT IN(SELECT MEMBER_ID FROM pharmacy);


SELECT e.member_id, e.first_name, e.last_name
FROM eligibility e
LEFT JOIN pharmacy p ON e.member_id = p.member_id
WHERE p.member_id IS NULL;

--Find the MEMBER_ID, FIRST_NAME, and LAST_NAME of members who have at least one medical claim with PAID_AMOUNT > 5000.
SELECT MEMBER_ID,CONCAT(FIRST_NAME,'',LAST_NAME) AS FULL_NAME
FROM eligibility 
WHERE MEMBER_ID 
IN 
(SELECT MEMBER_ID FROM medical WHERE PAID_AMOUNT>5000);

SELECT E.MEMBER_ID,CONCAT(E.FIRST_NAME,'',E.LAST_NAME) AS FULL_NAME,M.PAID_AMOUNT	  FROM eligibility AS E
INNER JOIN medical AS M
ON E.MEMBER_ID =M.MEMBER_ID
WHERE PAID_AMOUNT>5000;


--Find medical claims whose PAID_AMOUNT is greater than at least one pharmacy claim's PAID_AMOUNT.

SELECT MEMBER_ID,PAID_AMOUNT FROM 
medical WHERE
PAID_AMOUNT >ANY(SELECT PAID_AMOUNT FROM pharmacy);


--Find medical claims whose PAID_AMOUNT is greater than every pharmacy claim's PAID_AMOUNT.
SELECT MEMBER_ID,PAID_AMOUNT FROM
medical
WHERE PAID_AMOUNT >ALL(SELECT PAID_AMOUNT FROM pharmacy);

SELECT * FROM medicaL;
SELECT * FROM pharmacy;

--correlated subquery
--Find medical claims where PAID_AMOUNT is greater than the average paid amount of that same member.
SELECT M1.MEMBER_ID,
M1.CLAIM_ID,
M1.PAID_AMOUNT 
FROM medical AS M1
WHERE
M1.PAID_AMOUNT>
(SELECT AVG(M2.PAID_AMOUNT)
FROM medical as M2
WHERE M1.MEMBER_ID=M2.MEMBER_ID
);

--Find medical claims whose PAID_AMOUNT equals the highest medical paid amount for that same member.
SELECT M1.MEMBER_ID,
M1.CLAIM_ID,
M1.PAID_AMOUNT
FROM medical AS M1
WHERE M1.PAID_AMOUNT =
(SELECT MAX(M2.PAID_AMOUNT) FROM medical AS M2 WHERE M1.MEMBER_ID=M2.MEMBER_ID);

--Find pharmacy claims where PAID_AMOUNT is less than the average pharmacy paid amount of the same member.
SELECT P1.MEMBER_ID,
P1.RX_CLAIM_ID,
P1.PAID_AMOUNT
FROM pharmacy AS P1
WHERE 
P1.PAID_AMOUNT<(SELECT AVG(P2.PAID_AMOUNT) AS AVG_PAID
FROM pharmacy AS P2
WHERE 
P1.MEMBER_ID=P2.MEMBER_ID);


SELECT * FROM eligibility;
SELECT * FROM medical;
--Find members from eligibility who have at least one medical claim using a correlated EXISTS subquery.
SELECT E.MEMBER_ID,
CONCAT(E.FIRST_NAME,'',LAST_NAME) AS FULL_NAME
FROM eligibility AS E
WHERE 
EXISTS (SELECT  1 FROM medical AS M WHERE E.MEMBER_ID=M.MEMBER_ID);


--Find members from eligibility who do not have any pharmacy claims using a correlated NOT EXISTS subquery.
SELECT E.MEMBER_ID,
CONCAT(E.FIRST_NAME,'',LAST_NAME) AS FULL_NAME
FROM eligibility AS E
WHERE 
NOT EXISTS (SELECT  1 FROM pharmacy AS P WHERE E.MEMBER_ID=P.MEMBER_ID);



