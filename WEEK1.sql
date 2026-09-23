USE [Medical_SQL(MRF)];
SELECT * FROM eligibility;


--PART 1:
--Q1.1.	How many records are in the eligibility table?
SELECT COUNT(*) FROM eligibility;

--Q2.2.	Display all columns from the eligibility table.
SELECT * FROM eligibility;

--Q3.3.	Display only the member ID, first name, last name, and member status.
SELECT MEMBER_ID,FIRST_NAME,LAST_NAME,MEMBER_STATUS FROM eligibility;

--Q4.4.	Display the member ID, carrier name, and plan name.
SELECT MEMBER_ID,CARRIER_NAME,PLAN_NAME FROM eligibility;

--PART 2:
--Q5.	Find all active members.
SELECT * FROM eligibility WHERE MEMBER_STATUS='Active';

--Q6.	Find all terminated members.
SELECT * FROM eligibility WHERE MEMBER_STATUS='Terminated';

--Q7.	Find all members enrolled with Cigna.
SELECT * FROM eligibility WHERE CARRIER_NAME='Cigna';

--Q8.Find members enrolled in the PPO Platinum 500 plan.
SELECT * FROM eligibility WHERE  PLAN_NAME='PPO Platinum 500';

--PART 3:
--Q9.9.	Find members whose effective date is after January 1, 2025.
SELECT * FROM eligibility WHERE EFFECTIVE_DATE>'2025-01-01';

--Q.10.10.	Find members whose effective date is before January 1, 2023.
SELECT * FROM eligibility WHERE EFFECTIVE_DATE<'2023-01-01';

--Q11.11.	Find members whose status is NOT Active.
SELECT * FROM eligibility WHERE  MEMBER_STATUS != 'Active';

--PART 4:
--Q12.12.	Find all active members enrolled with Cigna.
SELECT * FROM eligibility WHERE MEMBER_STATUS='Active' AND CARRIER_NAME='Cigna';
--Q13.13.	Find active members who are enrolled in the PPO Platinum 500 plan.
SELECT * FROM eligibility WHERE MEMBER_STATUS='Active' AND PLAN_NAME='PPO Platinum 500';

--Q14.14.	Find active members with Family coverage.
SELECT * FROM eligibility WHERE COVERAGE_TYPE='Family';

--PART 5:
--Q15. 15.	Find members enrolled with either Cigna or Aetna.
SELECT * FROM eligibility WHERE CARRIER_NAME='Cigna' OR CARRIER_NAME='Aetna';

--Q16.16.	Find members whose coverage type is either Family or EE + Spouse.
SELECT * FROM eligibility WHERE COVERAGE_TYPE='Family' OR COVERAGE_TYPE='EE + Spouse';
SELECT  * FROM eligibilitY  WHERE COVERAGE_TYPE IN ('Family', 'EE + Spouse');

--PART 6:
--Q17.17.	Display all members sorted by first name alphabetically.
SELECT * FROM eligibility ORDER BY FIRST_NAME ASC;

--Q18.18.	Display members sorted by effective date from oldest to newest.
SELECT * FROM	eligibility ORDER BY EFFECTIVE_DATE ASC ;

--Q19.19.	Display members sorted by effective date from newest to oldest.
SELECT * FROM eligibility ORDER BY EFFECTIVE_DATE DESC;

--PART 6.
--Q20.20.	Show the first 5 members.
SELECT TOP 5 * FROM eligibility ORDER BY MEMBER_ID ASC;


--Q21.21.	Show the 10 most recently effective members.
SELECT TOP 10 * FROM eligibility ORDER BY EFFECTIVE_DATE DESC ,MEMBER_ID ASC;

--PAR 8:

--Q22	Find members who have no termination date.

SELECT * FROM eligibility WHERE TERMINATION_DATE IS NULL;

--Q23. 23.	Find members who have a termination date.
SELECT * FROM eligibility WHERE TERMINATION_DATE IS NOT NULL;

--PART 9:
--Q24.24.	Find active Cigna members and display their name, plan, and coverage type.
SELECT FIRST_NAME+LAST_NAME AS NAME,PLAN_NAME,COVERAGE_TYPE FROM eligibility WHERE 
CARRIER_NAME ='Cigna' AND MEMBER_STATUS='Active';

--Q25.25.	Find active members with Family coverage and sort them alphabetically by last name.
SELECT FIRST_NAME+LAST_NAME AS FULL_NAME,COVERAGE_TYPE,MEMBER_STATUS FROM  eligibility
WHERE MEMBER_STATUS='Active' AND COVERAGE_TYPE='Family' ORDER BY LAST_NAME ASC;

--Q26 26.	Find the 5 most recently enrolled active members.
SELECT TOP 5 * FROM eligibility WHERE MEMBER_STATUS='Active' ORDER BY EFFECTIVE_DATE DESC;

--Q27.27.	Find terminated members and display their termination dates from newest to oldest.
SELECT MEMBER_ID,MEMBER_STATUS,TERMINATION_DATE FROM eligibility WHERE MEMBER_STATUS='Terminated' ORDER BY TERMINATION_DATE DESC;


--PAET 10:

--28.28.	Which carrier has members in this eligibility dataset?
SELECT DISTINCT CARRIER_NAME FROM eligibility;

--29.	Which health plans are available in the dataset?
SELECT DISTINCT PLAN_NAME FROM eligibility;

--30.30.	Find all members belonging to Acme Manufacturing Inc.
SELECT * FROM eligibility WHERE GROUP_NAME='Acme Manufacturing Inc';

--31. 31.	Find active members belonging to Acme Manufacturing Inc.
SELECT * FROM eligibility WHERE GROUP_NAME='Acme Manufacturing Inc' AND MEMBER_STATUS='Active';

