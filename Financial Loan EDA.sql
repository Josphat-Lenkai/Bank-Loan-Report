----------------------------------------- KEY PERFOMANCE INDICATERS ----------------------------------------------

--This is a select all staments
SELECT * FROM Financial_Loan

--Total Number of Applicants
SELECT COUNT(id) AS Total_Number_of_Loan_Applicants FROM financial_loan

--Total Number of Applicants as of MTD (monthly to date)
SELECT COUNT(id) AS MTD_Total_Number_of_Loan_Applicants FROM financial_loan
WHERE MONTH(issue_date) = 12

--Total Number of Applicants as of PMTD (Previous month to date)
SELECT COUNT(id) AS PMIT_TOTAL_APPLICANTS FROM Financial_Loan
WHERE MONTH(issue_date) = 11

--Total Amount of Loan Given
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan

--Total Amount of Loan Given as MTD
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan 
WHERE MONTH(issue_date) = 12

--Total Amount of Loan Given AS PMTD
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan 
WHERE MONTH(issue_date) = 11


--Total Amount of loan recieved
SELECT SUM(total_payment) AS Total_Amount_Recieved
FROM Financial_Loan

--Total Amount of loan recieved as MTD
SELECT SUM(total_payment) AS Total_Amount_Recieved
FROM Financial_Loan
WHERE MONTH(issue_date) = 12

--Total Amount of loan recieved as PMTD
SELECT SUM(total_payment) AS Total_Amount_Recieved
FROM Financial_Loan
WHERE MONTH(issue_date) = 11

--Percentage Avarage Interest Rate
SELECT AVG(int_rate) * 100 AS Avarage_interest_rate 
FROM Financial_Loan

--Percentage Avarage Interest Rate as MTD
SELECT AVG(int_rate) * 100 AS Avarage_interest_rate 
FROM Financial_Loan
WHERE MONTH(issue_date) = 12

--Percentage Avarage Interest Rate as MTD
SELECT AVG(int_rate) * 100 AS Avarage_interest_rate 
FROM Financial_Loan
WHERE MONTH(issue_date) = 11

--Percentage Avarage date to income ratio
SELECT AVG(dti) * 100 AS Avarage_debt_to_income_ratio 
FROM Financial_Loan

--Percentage Avarage date to income ratio as MTD
SELECT AVG(dti) * 100 AS Avarage_debt_to_income_ratio 
FROM Financial_Loan
WHERE MONTH(issue_date) = 12

--Percentage Avarage date to income ratio as PMTD
SELECT AVG(dti) * 100 AS Avarage_debt_to_income_ratio 
FROM Financial_Loan
WHERE MONTH(issue_date) = 11

--------------------------------------GOOD LOAN--------------------------------

--Good loan Percentage
SELECT COUNT(CASE 
WHEN loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'
THEN 1
ELSE NULL
END) * 100 / COUNT(loan_status)  AS Good_Loan_Percentage
FROM Financial_Loan


--Total Number Of Good Loan Application
SELECT COUNT(CASE
WHEN loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'
THEN 1
ELSE NULL
END) AS Total_number_of_Good_Application
FROM Financial_Loan

--Total Number Of Good Loan Application
SELECT COUNT(id) AS Total_number_of_Good_Application
FROM Financial_Loan
WHERE loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'

--Total_funding_for_Good_loan
SELECT SUM(loan_amount) AS Total_Amount_of_good_loan 
FROM Financial_Loan
WHERE loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'

--Total Amount Received from Good Loans

SELECT SUM(total_payment) AS Total_Amount_received_good_loan 
FROM Financial_Loan
WHERE loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'

----------------BAD LOAN----------------------

--Total Number of percentage Bad Loan
SELECT COUNT(CASE
WHEN 
loan_status LIKE 'Charged off'
THEN 1
ELSE NULL
END) * 100 / COUNT(loan_status) AS Bad_loan_Percenatage   
FROM Financial_Loan

--total number of bad loans

SELECT COUNT(id) AS Number_of_Bad_Loans FROM Financial_Loan
WHERE loan_status LIKE 'Charged off'


--total amount disbureded as bad loans
SELECT SUM(loan_amount) AS Total_Amount_of_bad_loan 
FROM Financial_Loan
WHERE loan_status LIKE 'Charged off'


--total amount of bad loan received
SELECT SUM(total_payment) AS Total_Amount_received_bad_loan 
FROM Financial_Loan
WHERE loan_status LIKE 'Charged off'

----------------------------------- LOAN STATUS GRID VIEW ---------------------------------------

--Loan Status Grid View

SELECT loan_status,
SUM(id) AS Total_Loan_Applicants,
SUM(loan_amount) AS Total_Loan_Given,
SUM(total_payment) AS Total_loan_paid,
AVG(int_rate * 100) AS Avarage_interest_rate,
AVG(dti * 100) AS Avarage_debt_to_income 
FROM Financial_Loan
GROUP BY loan_status


SELECT
MONTH(issue_date) AS date_month,
DATENAME(MONTH, issue_date) AS date_name,
COUNT(id) AS Total_Applicants,
SUM(loan_amount) AS Amount_given,
SUM(total_payment) AS Amount_given
FROM Financial_Loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
HAVING MONTH(issue_date) IS NOT NULL
ORDER BY MONTH(issue_date),DATENAME(MONTH, issue_date)



