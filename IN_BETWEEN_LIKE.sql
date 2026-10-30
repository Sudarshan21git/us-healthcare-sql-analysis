USE [Medical_SQL(MRF)];

SELECT * FROM eligibility;


--Q1.Display members whose FIRST_NAME starts with A.
SELECT * FROM eligibility WHERE FIRST_NAME LIKE 'A%';

--Q2.Display members whose LAST_NAME ends with n.
SELECT * FROM eligibility WHERE LAST_NAME LIKE '%N';

--Q3.Display members whose CARRIER_NAME is either Cigna or Aetna. Use IN.
SELECT * FROM eligibility WHERE CARRIER_NAME IN('Cigna','Aetna');

--Q4.Display members whose EFFECTIVE_DATE is between January 1, 2023 and December 31, 2025, including both dates.
SELECT * FROM eligibility  
WHERE EFFECTIVE_DATE BETWEEN '2023-01-01' AND '2025-12-31';

--Q5.Display active members whose FIRST_NAME contains a and whose COVERAGE_TYPE is either Family or EE + Spouse.
SELECT * FROM eligibility WHERE MEMBER_STATUS='Active' AND 
FIRST_NAME LIKE '%a%' AND COVERAGE_TYPE IN ('Family' ,'EE+Spouse');


