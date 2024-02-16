create database financial_loan;
use financial_loan;
select*from financial_loan;

---KPIS

--A) TOTAL LOAN APPLICATIONS
SELECT COUNT(id) AS Total_Applications 
FROM financial_loan;

--MTD Loan Applications
SELECT COUNT(id) AS MTD_Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 12;

--PMTD Loan Applications
SELECT COUNT(id) AS PMTD_Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 11


--B) TOTAL FUNDED AMOUNT
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan;

--MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12

--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 11


--C) Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan

--MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan
WHERE MONTH(issue_date) = 12

--PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM financial_loan
WHERE MONTH(issue_date) = 11


--D) Average Interest Rate
SELECT ROUND(AVG(int_rate),4)*100 AS Avg_Int_Rate 
FROM financial_loan

--MTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS MTD_Avg_Int_Rate 
FROM financial_loan
WHERE MONTH(issue_date) = 12

--PMTD Average Interest
SELECT ROUND(AVG(int_rate),4)*100 AS PMTD_Avg_Int_Rate 
FROM financial_loan
WHERE MONTH(issue_date) = 11


--E) Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS Avg_DTI 
FROM financial_loan

--MTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS MTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 12

--PMTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 11


----------------GOOD LOAN ISSUED--------------------

--Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan

--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount 
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received 
FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-------------------BAD LOAN ISSUED--------------------

--Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan

--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Charged Off'

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM financial_loan
WHERE loan_status = 'Charged Off'

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM financial_loan
WHERE loan_status = 'Charged Off'






--A)LOAN STATUS
--1)
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM financial_loan
GROUP BY loan_status

--2)
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status








--B)BANK LOAN REPORT | OVERVIEW
--1) MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--2)STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY COUNT(id) DESC

--3)TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY COUNT(id) DESC

--4)EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY COUNT(id) DESC

--5)PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC

--6)HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC



SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY COUNT(id) DESC


























