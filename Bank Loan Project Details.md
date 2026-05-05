# Bank-Loan-Project-
This version of the README focuses on your specific process: using SQL for pre-calculation and validation to ensure data accuracy in Tableau. It follows your requirements for clear, direct, and simple English.

---

# Bank Loan Analysis: SQL Validation & Visualization

## Project Overview
I analyzed a bank loan dataset to evaluate lending performance and credit risk. I used SQL to clean data and calculate key metrics before building the dashboard. This process ensures that every chart in Tableau matches the raw database figures.

## Technical Process
1. **Data Cleaning:** I used MySQL to fix date formats and standardize loan status labels. 
2. **SQL Validation:** I pre-calculated all KPIs using SQL queries. I then used these results to verify the accuracy of the Tableau visualizations.
3. **Visualization:** I built an interactive dashboard in Tableau to show trends and risk factors.

## Core Metrics
I tracked five main KPIs to monitor the loan portfolio:
* **Total Applications:** The total number of loan requests.
* **Total Funded Amount:** The total cash disbursed to borrowers.
* **Total Amount Received:** The total cash recovered from borrowers.
* **Good Loan Rate:** The percentage of "Fully Paid" and "Current" loans.
* **Bad Loan Rate (NPL):** The percentage of "Charged Off" loans.

## Key Insights
### 1. High-Risk Loan Purposes
Borrowers who consolidate debt make up the largest group. This group also shows a high default rate. I recommend stricter credit checks for this category.

### 2. Impact of Loan Terms
Loans with 60-month terms carry more risk than 36-month loans. Long-term commitments lead to higher delinquency rates in this dataset.

### 3. Home Ownership and Risk
Applicants who rent their homes have a higher risk of default compared to mortgage holders. The bank can reduce risk by targeting homeowners for future loan offers.

---

**View the SQL Queries:** https://github.com/chucuudangiu-sys/Bank-Loan-Project-/blob/main/datascrpit.sql

**View the Dashboard:** https://public.tableau.com/app/profile/nam.pham5054/viz/BankLoanProject_17778869406110/Summary
