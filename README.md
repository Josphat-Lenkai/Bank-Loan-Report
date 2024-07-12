# Financial Loan Performance Analysis

This project performs a detailed analysis of financial loan data to derive key performance indicators (KPIs) and insights on loan status, loan disbursement, and repayments. The analysis includes examining the total number of applicants, loan amounts disbursed, repayments received, interest rates, and debt-to-income ratios. Additionally, the project differentiates between good and bad loans, providing further insights into loan performance.


## Key Performance Indicators

### Initial Data Retrieval

```sql
-- This is a select all statement
SELECT * FROM Financial_Loan;
```
### Total Number of Applicants

```sql
-- Total Number of Applicants
SELECT COUNT(id) AS Total_Number_of_Loan_Applicants FROM Financial_Loan;
```

### Total Number of Applicants as of MTD (Monthly to Date)
```sql
-- Total Number of Applicants as of MTD (monthly to date)
SELECT COUNT(id) AS MTD_Total_Number_of_Loan_Applicants FROM Financial_Loan
WHERE MONTH(issue_date) = 12;

```
### Total Number of Applicants as of PMTD (Previous Month to Date)
```sql
-- Total Number of Applicants as of PMTD (Previous month to date)
SELECT COUNT(id) AS PMIT_TOTAL_APPLICANTS FROM Financial_Loan
WHERE MONTH(issue_date) = 11;

```
### Total Amount of Loan Given
```sql
-- Total Amount of Loan Given
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM Financial_Loan;

```
### Total Amount of Loan Given as MTD
```sql
-- Total Amount of Loan Given as MTD
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM Financial_Loan 
WHERE MONTH(issue_date) = 12;

```
### Total Amount of Loan Given as PMTD
```sql
-- Total Amount of Loan Given as PMTD
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM Financial_Loan 
WHERE MONTH(issue_date) = 11;

```
### Total Amount of Loan Received

```sql
-- Total Amount of loan received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan;

```
### Total Amount of Loan Received as MTD

```sql
-- Total Amount of loan received as MTD
SELECT SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan
WHERE MONTH(issue_date) = 12;

```

### Total Amount of Loan Received as PMTD
```sql
-- Total Amount of loan received as PMTD
SELECT SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan
WHERE MONTH(issue_date) = 11;


```

### Percentage Average Interest Rate
```sql
-- Percentage Average Interest Rate
SELECT AVG(int_rate) * 100 AS Average_Interest_Rate 
FROM Financial_Loan;


```

### Percentage Average Interest Rate as MTD
```sql
-- Percentage Average Interest Rate as MTD
SELECT AVG(int_rate) * 100 AS Average_Interest_Rate 
FROM Financial_Loan
WHERE MONTH(issue_date) = 12;

```

### Percentage Average Interest Rate as PMTD
```sql
-- Percentage Average Interest Rate as PMTD
SELECT AVG(int_rate) * 100 AS Average_Interest_Rate 
FROM Financial_Loan
WHERE MONTH(issue_date) = 11;

```

### Percentage Average Debt to Income Ratio
```sql
-- Percentage Average Debt to Income Ratio
SELECT AVG(dti) * 100 AS Average_Debt_to_Income_Ratio 
FROM Financial_Loan;

```

### Percentage Average Debt to Income Ratio as MTD
```sql
-- Percentage Average Debt to Income Ratio as MTD
SELECT AVG(dti) * 100 AS Average_Debt_to_Income_Ratio 
FROM Financial_Loan
WHERE MONTH(issue_date) = 12;

```

### Percentage Average Debt to Income Ratio as PMTD
```sql
-- Percentage Average Debt to Income Ratio as PMTD
SELECT AVG(dti) * 100 AS Average_Debt_to_Income_Ratio 
FROM Financial_Loan
WHERE MONTH(issue_date) = 11;

```
## Good Loan Analysis
### Good Loan Percentage
```sql
-- Good loan Percentage
SELECT COUNT(CASE 
WHEN loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'
THEN 1
ELSE NULL
END) * 100 / COUNT(loan_status) AS Good_Loan_Percentage
FROM Financial_Loan;

```
### Total Number of Good Loan Applications
```sql
-- Total Number of Good Loan Applications
SELECT COUNT(CASE
WHEN loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current'
THEN 1
ELSE NULL
END) AS Total_Number_of_Good_Applications
FROM Financial_Loan;

```

### Total Funding for Good Loans
```sql
-- Total funding for Good loans
SELECT SUM(loan_amount) AS Total_Amount_of_Good_Loans 
FROM Financial_Loan
WHERE loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current';

```
### Total Amount Received from Good Loans
```sql
-- Total Amount Received from Good Loans
SELECT SUM(total_payment) AS Total_Amount_Received_Good_Loans 
FROM Financial_Loan
WHERE loan_status LIKE 'Fully Paid' OR loan_status LIKE 'Current';

```
## Bad Loan Analysis
### Bad Loan Percentage
```sql
-- Total Number of Percentage Bad Loans
SELECT COUNT(CASE
WHEN loan_status LIKE 'Charged off'
THEN 1
ELSE NULL
END) * 100 / COUNT(loan_status) AS Bad_Loan_Percentage   
FROM Financial_Loan;


```
### Total Number of Bad Loans
```SQL
-- Total Number of Bad Loans
SELECT COUNT(id) AS Number_of_Bad_Loans 
FROM Financial_Loan
WHERE loan_status LIKE 'Charged off';

```
### Total Amount Disbursed as Bad Loans
```SQL
-- Total Amount Disbursed as Bad Loans
SELECT SUM(loan_amount) AS Total_Amount_of_Bad_Loans 
FROM Financial_Loan
WHERE loan_status LIKE 'Charged off';

```
### Total Amount of Bad Loans Received
```SQL
-- Total Amount of Bad Loans Received
SELECT SUM(total_payment) AS Total_Amount_Received_Bad_Loans 
FROM Financial_Loan
WHERE loan_status LIKE 'Charged off';

```
## Loan Status Grid View
### Loan Status Grid View
```SQL
-- Loan Status Grid View
SELECT loan_status,
SUM(id) AS Total_Loan_Applicants,
SUM(loan_amount) AS Total_Loan_Given,
SUM(total_payment) AS Total_Loan_Paid,
AVG(int_rate * 100) AS Average_Interest_Rate,
AVG(dti * 100) AS Average_Debt_to_Income 
FROM Financial_Loan
GROUP BY loan_status;

```

### Monthly Loan Summary
```SQL
-- Monthly Loan Summary
SELECT
MONTH(issue_date) AS date_month,
DATENAME(MONTH, issue_date) AS date_name,
COUNT(id) AS Total_Applicants,
SUM(loan_amount) AS Amount_Given,
SUM(total_payment) AS Amount_Received
FROM Financial_Loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
HAVING MONTH(issue_date) IS NOT NULL
ORDER BY MONTH(issue_date), DATENAME(MONTH, issue_date);


```

 # Conclusion
This financial loan performance analysis provides comprehensive insights into the loan portfolio, highlighting key performance indicators such as the total number of applicants, loan amounts disbursed, repayments received, and average interest rates. The analysis distinguishes between good and bad loans, offering valuable information on the quality of the loan portfolio. These insights can aid in making informed decisions to enhance loan management strategies, improve risk assessment, and optimize financial outcomes.
