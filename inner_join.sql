USE [Medical_SQL(MRF)];

SELECT * FROM eligibility;
SELECT * FROM medical;

--Q1.Display all columns from both tables for members who have medical claims.
SELECT * FROM eligibility AS E
INNER JOIN medical AS M
ON E.MEMBER_ID=M.MEMBER_ID;

--Q2.Display MEMBER_ID, FIRST_NAME, LAST_NAME, SERVICE_DATE, and CLAIM_AMOUNT for members with medical claims.
SELECT E.MEMBER_ID,E.FIRST_NAME,E.LAST_NAME,M.SERVICE_DATE,M.BILLED_AMOUNT
 FROM eligibility AS E
 INNER JOIN medical AS M
 ON E.MEMBER_ID=M.MEMBER_ID;

 --Q3.Display medical records where CLAIM_STATUS is 'Denied', along with the member’s first and last name.
 SELECT E.FIRST_NAME,E.LAST_NAME ,M.CLAIM_STATUS FROM eligibility
 AS E  INNER JOIN medical AS M
 ON E.MEMBER_ID=M.MEMBER_ID
 WHERE M.CLAIM_STATUS='Denied';

 --Q4.Display medical records for active members where BILLED_AMOUNT exceeds 500. Sort by billed amount from highest to lowest.
 SELECT * FROM eligibility AS E
 INNER JOIN medical AS M 
 ON E.MEMBER_ID=M.MEMBER_ID
 WHERE E.MEMBER_STATUS='Active' AND M.BILLED_AMOUNT>500 
 ORDER BY M.BILLED_AMOUNT DESC;


 --Q5.Display the unique member IDs of members who have medical records. Each member ID should appear once.
 SELECT DISTINCT E.MEMBER_ID
 FROM eligibility AS E
 INNER JOIN medical AS M
 ON E.MEMBER_ID=M.MEMBER_ID;





 --Q6.For each CLAIM_TYPE, display the number of matching claim-line rows. Name the count medical_line_count
 SELECT COUNT(*) AS medical_line_count,M.CLAIM_TYPE
 FROM eligibility AS E
 INNER JOIN medical AS M
 ON E.MEMBER_ID=M.MEMBER_ID
 GROUP BY M.CLAIM_TYPE;


 --Q7.Find the total billed amount for each carrier. Include only carriers whose total exceeds 2,000, sorted by total billed amount descending.
 
 SELECT E.CARRIER_NAME,SUM(M.BILLED_AMOUNT) AS
 Total_billed FROM eligibility AS E
 INNER JOIN medical AS M
 ON E.MEMBER_ID=M.MEMBER_ID
 GROUP BY E.CARRIER_NAME
 HAVING SUM(M.BILLED_AMOUNT)>2000
 ORDER BY  Total_billed DESC;

 --Q8.Display the top 3 members with the highest total billed amount, considering only members whose total exceeds 1,000. Show member ID, first name, last name, total billed amount, and total paid amount. Each member should appear once.
 SELECT   DISTINCT TOP 3 
           E.MEMBER_ID,
		   E.FIRST_NAME,
		   E.LAST_NAME,
		   COUNT(M.CLAIM_ID) AS Claim_count,
             SUM(M.BILLED_AMOUNT) AS total_claim_amount,
			 SUM(M.PAID_AMOUNT) AS total_paid_amount
FROM eligibility AS E
INNER JOIN medical AS M
ON 
E.MEMBER_ID=M.MEMBER_ID
GROUP BY E.MEMBER_ID,E.FIRST_NAME,E.LAST_NAME
HAVING SUM(M.BILLED_AMOUNT)>1000
ORDER BY total_claim_amount DESC;


--Q9.Find the top 2 carriers with the highest number of unique members with medical claims. Show carrier name, unique member count, and total claim amount. If the counts are equal, put the carrier with the higher total claim amount first.
SELECT TOP 2  COUNT( DISTINCT E.MEMBER_ID),E.CARRIER_NAME,COUNT(*) AS Member_count,
SUM(M.BILLED_AMOUNT) AS total_number_of_claim
FROM eligibility AS E
INNER JOIN medical AS M
ON
E.MEMBER_ID=M.MEMBER_ID
GROUP BY E.CARRIER_NAME
ORDER BY Member_count DESC,total_number_of_claim DESC;

--Q10.For each plan, calculate the unique member count, claim count, and total claim amount. Include only plans with at least 2 unique members with claims and total claim amount above 3,000. Sort by total claim amount descending
SELECT E.PLAN_NAME, 
COUNT (DISTINCT E.MEMBER_ID) AS Unique_number,
COUNT(DISTINCT M.CLAIM_ID) AS Claim_count,
SUM(M.BILLED_AMOUNT) AS
Total_billed_amount,SUM(M.PAID_AMOUNT) AS Total_paid_amount
FROM eligibility AS E
INNER JOIN medical AS M 
ON E.MEMBER_ID=M.MEMBER_ID
GROUP BY E.PLAN_NAME
HAVING COUNT(DISTINCT E.MEMBER_ID)>=2
AND SUM(M.BILLED_AMOUNT)>3000
ORDER BY Total_billed_amount DESC;
;

--Q11.Consider only medical claims where CLAIM_AMOUNT is greater than 100. Find the top 2 carriers by average claim amount. Show carrier name, claim count, average claim amount, and total claim amount. Include only carriers with at least 2 qualifying claims and an average claim amount above 500. Sort by average claim amount descending

SELECT TOP 2 E.CARRIER_NAME,
COUNT(DISTINCT M.MEMBER_ID) AS Claim_amount,
AVG(M.BILLED_AMOUNT) AS  AVERAGE_PAID_AMOUNT,
SUM(M.BILLED_AMOUNT) AS Total_claim_amount
FROM eligibility AS E
INNER JOIN medical AS M 
ON E.MEMBER_ID=M.MEMBER_ID
WHERE M.PAID_AMOUNT>0
GROUP BY E.CARRIER_NAME
HAVING AVG(M.PAID_AMOUNT)>100 AND COUNT(DISTINCT M.CLAIM_ID)>=2
ORDER BY AVERAGE_PAID_AMOUNT DESC;


SELECT TOP 5 *
FROM eligibility;

 SELECT TOP 5 *
FROM medical;