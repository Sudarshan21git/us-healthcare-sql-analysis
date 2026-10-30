USE [Medical_SQL(MRF)];

SELECT * from eligibility;

--Q1.ind active members that belong to either group GRP1001or GRP1006
SELECT * FROM eligibility 
WHERE (GROUP_ID='GRP1001' OR
GROUP_ID='GRP1006') AND MEMBER_STATUS='Active' ;

--Q2.Find the 3 oldest Terminated employees, based on date of birth.
SELECT TOP 3 MEMBER_STATUS,DOB FROM eligibility
WHERE MEMBER_STATUS='Terminated'
AND DOB IS NOT NULL
ORDER BY DOB ;

--Q3.Find members who might have data entry errors: active members who have a TERMINATION_DATE before today’s date. 
SELECT *
FROM eligibility
WHERE MEMBER_STATUS = 'Active'
  AND TERMINATION_DATE < CAST(GETDATE() AS DATE);


  --  Questions Medical:

 
--Q1.Find all claim lines that were Denied and had a BILLED_AMOUNT greater than $5,000 
SELECT * FROM medical
WHERE CLAIM_STATUS='Denied'
and BILLED_AMOUNT>5000;

--Q2.Find claim lines from Emergency Room visits (POS_CODE = '23') that occurred in 2025.
SELECT * FROM medical
WHERE POS_CODE='23' 
AND SERVICE_DATE BETWEEN '2025-01-01' AND '2025-12-31';

--Q3.Find claim lines that are Paid and were billed at either Inpatient (POS_CODE = '21') or Emergency Room (POS_CODE = '23') — these are the highest-severity, highest-cost encounters.

SELECT * FROM medical
WHERE CLAIM_STATUS='Paid'
AND POS_CODE IN('21','23');

--Q4.Find claims that are Professional type, occurred in 2024, and involve either the diagnosis J06.9 (respiratory infection) or R51 (headache).
SELECT * FROM medical
WHERE CLAIM_TYPE='Professional'
AND SERVICE_DATE BETWEEN '2024-01-01' AND '2024-12-31'
AND DIAGNOSIS_CODE IN('J06.9','R51');

SELECT *
FROM medical
WHERE CLAIM_TYPE = 'Professional'
  AND SERVICE_DATE >= '2024-01-01'
  AND SERVICE_DATE < '2025-01-01'
  AND DIAGNOSIS_CODE IN ('J06.9', 'R51');

  --Q5.Find claim lines from Emergency Room visits (POS_CODE = '23') that occurred in 2025.
  SELECT * FROM medical 
  WHERE POS_CODE='23' 
  AND SERVICE_DATE>='2025-01-01'
  AND SERVICE_DATE<'2026-01-01';

  --Find claim lines that are Paid and were billed at either Inpatient (POS_CODE = '21') or Emergency Room (POS_CODE = '23') — these are the highest-severity, highest-cost encounters.

  SELECT * FROM medical
  WHERE CLAIM_STATUS='Paid'
  AND POS_CODE IN('23','21');
  
  --Q4.Find claims that are Professional type, occurred in 2024, and involve either the diagnosis J06.9 (respiratory infection) or R51 (headache).

  SELECT * FROM medical
  WHERE CLAIM_TYPE='Professional' 
  AND SERVICE_DATE>='2024-01-01'
  AND SERVICE_DATE<'2025-01-01'
  AND DIAGNOSIS_CODE IN ('J06.9','R51');


  
--Questions Pharmacy:
--Q1. Find prescriptions with a DAYS_SUPPLY greater than 60 that also cost more than $300 submitted.

SELECT * FROM Pharmacy;

SELECT * FROM pharmacy
WHERE DAYS_SUPPLY >60
AND SUBMITTED_AMOUNT>300;

--Q2.Find fills where CLAIM_STATUS = 'Paid' but PAID_AMOUNT = 0 

SELECT * FROM pharmacy
WHERE  PAID_AMOUNT=0
AND CLAIM_STATUS='Paid';

--Q3.Find the top 5 most expensive prescriptions by SUBMITTED_AMOUNT that are still Pending.

SELECT TOP 5 * FROM pharmacy
WHERE CLAIM_STATUS='Pending'
ORDER BY SUBMITTED_AMOUNT DESC;

--Find prescriptions filled in 2025 for Lipitor 20mg Tablet where the DAYS_SUPPLY is 90 days or more 
SELECT * FROM pharmacy
WHERE FILL_DATE>='2025-01-01'
AND FILL_DATE<'2026-01-01'
AND DRUG_NAME='Lipitor 20 mg tablet'
AND DAYS_SUPPLY>=90;


