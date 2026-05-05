-- ============================================
-- BANK LOAN ANALYSIS DASHBOARD
-- ============================================

-- ============================================
-- 1. DATABASE & TABLE SETUP
-- ============================================

-- Modify id column to PK -- 
ALTER TABLE financial_loan_data 
MODIFY COLUMN id INT PRIMARY KEY;

-- ============================================
-- 2. OVERVIEW METRICS
-- ============================================

-- Total Records in Database
SELECT DISTINCT 
	COUNT(id) AS total_records
FROM financial_loan_data;

-- ============================================
-- 3. LOAN APPLICATIONS COUNT
-- ============================================

-- Total Loan Applications (All Time)
SELECT 
	COUNT(id) AS total_applications 
FROM financial_loan_data;

-- MTD Total Applications (Current Month: December 2021)
SELECT 
	COUNT(id) AS mtd_total_applications 
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Total Applications (Previous Month: November 2021)
SELECT 
	COUNT(id) AS pmtd_total_applications
FROM financial_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- ============================================
-- 4. FUNDED AMOUNT ANALYSIS
-- ============================================

-- Total Amount Funded (All Time)
SELECT 
	SUM(loan_amount) AS total_funded_amount 
FROM financial_loan_data;

-- MTD Total Amount Funded (December 2021)
SELECT 
	SUM(loan_amount) AS mtd_total_funded_amount
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Total Amount Funded (November 2021)
SELECT 
	SUM(loan_amount) AS pmtd_total_funded_amount
FROM financial_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- ============================================
-- 5. AMOUNT RECEIVED (REPAYMENTS) ANALYSIS
-- ============================================

-- Total Amount Received (All Time)
SELECT 
	SUM(total_payment) AS total_amount_collected 
FROM financial_loan_data;

-- MTD Total Amount Received (December 2021)
SELECT 
	SUM(total_payment) AS mtd_total_amount_collected 
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Total Amount Received (November 2021)
SELECT 
	SUM(total_payment) AS pmtd_total_amount_collected
FROM financial_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- ============================================
-- 6. INTEREST RATE ANALYSIS
-- ============================================

-- Average Interest Rate (All Time)
SELECT 
	ROUND(AVG(int_rate), 4) * 100 AS avg_interest_rate
FROM financial_loan_data;

-- MTD Average Interest Rate (December 2021)
SELECT 
	ROUND(AVG(int_rate), 4) * 100 AS mtd_avg_interest_rate
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Average Interest Rate (November 2021)
SELECT 
	ROUND(AVG(int_rate), 4) * 100 AS pmtd_avg_interest_rate
FROM financial_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- ============================================
-- 7. DEBT-TO-INCOME RATIO (DTI) ANALYSIS
-- ============================================

-- Average DTI (All Time)
SELECT 	
	ROUND(AVG(dti), 4) * 100 AS avg_dti_ratio
FROM financial_loan_data;

-- MTD Average DTI (December 2021)
SELECT 	
	ROUND(AVG(dti), 4) * 100 AS mtd_avg_dti_ratio
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- PMTD Average DTI (November 2021)
SELECT 	
	ROUND(AVG(dti), 4) * 100 AS pmtd_avg_dti_ratio
FROM financial_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- ============================================
-- 8. GOOD LOAN ANALYSIS
-- ============================================

-- Good Loan Applications (Fully Paid + Current)
SELECT
	COUNT(id) AS good_loan_applications
FROM financial_loan_data 
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Percentage
SELECT 
	ROUND((SUM(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN 1 ELSE 0 END) * 100.0) / COUNT(id), 2) AS good_loan_percentage
FROM financial_loan_data;

-- Good Loan Funded Amount
SELECT
	SUM(loan_amount) AS good_loan_funded_amount 
FROM financial_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Received Amount
SELECT
	SUM(total_payment) AS good_loan_received_amount
FROM financial_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- ============================================
-- 9. BAD LOAN ANALYSIS
-- ============================================

-- Bad Loan Applications (Charged Off)
SELECT 
	COUNT(id) AS bad_loan_applications
FROM financial_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Percentage
SELECT 
	ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id), 2) AS bad_loan_percentage
FROM financial_loan_data;

-- Bad Loan Funded Amount
SELECT 
	SUM(loan_amount) AS bad_loan_funded_amount
FROM financial_loan_data 
WHERE loan_status = 'Charged Off';

-- Bad Loan Received Amount
SELECT 
	SUM(total_payment) AS bad_loan_received_amount
FROM financial_loan_data 
WHERE loan_status = 'Charged Off';

-- ============================================
-- 10. LOAN STATUS BREAKDOWN (COMPREHENSIVE)
-- ============================================

-- Summary by Loan Status (All Metrics)
SELECT 
	loan_status,
	COUNT(id) AS total_applications,
	SUM(total_payment) AS total_amount_received,
	SUM(loan_amount) AS total_funded_amount,
	ROUND(AVG(int_rate), 4) * 100 AS avg_interest_rate,
	ROUND(AVG(dti), 4) * 100 AS avg_dti_ratio
FROM financial_loan_data
GROUP BY loan_status;

-- MTD Loan Status Summary (December 2021)
SELECT 
	loan_status,
	COUNT(id) AS mtd_total_applications,
	SUM(total_payment) AS mtd_total_amount_received,
	SUM(loan_amount) AS mtd_total_funded_amount
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status;

-- ============================================
-- 11. TREND ANALYSIS BY MONTH
-- ============================================

-- Monthly Loan Performance
SELECT 
	MONTH(issue_date) AS month_number,
	MONTHNAME(issue_date) AS month_name,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY MONTH(issue_date), MONTHNAME(issue_date) 
ORDER BY MONTH(issue_date);

-- ============================================
-- 12. GEOGRAPHIC ANALYSIS BY STATE
-- ============================================

-- Loan Performance by State (Top States by Funded Amount)
SELECT 
	address_state AS state,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY address_state 
ORDER BY SUM(loan_amount) DESC;

-- ============================================
-- 13. LOAN TERM ANALYSIS
-- ============================================

-- Loan Performance by Term
SELECT 
	term,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY term
ORDER BY term;

-- ============================================
-- 14. EMPLOYMENT LENGTH ANALYSIS
-- ============================================

-- Loan Performance by Employment Length
SELECT 
	emp_length,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

-- ============================================
-- 15. LOAN PURPOSE ANALYSIS
-- ============================================

-- Loan Performance by Purpose (Top Purposes)
SELECT 
	purpose,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- ============================================
-- 16. HOME OWNERSHIP ANALYSIS
-- ============================================

-- Loan Performance by Home Ownership Status
SELECT 
	home_ownership,
	COUNT(id) AS total_loan_applications,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_received_amount
FROM financial_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
