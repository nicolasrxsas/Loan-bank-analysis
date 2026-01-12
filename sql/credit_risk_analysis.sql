/* ============================================================
   CREDIT RISK ANALYSIS PROJECT
   Author: Nicolas
   Database: SQL Server
   Description:
   - Data cleaning
   - Analytical views creation
   - Exploratory data analysis (EDA)
   ============================================================ */


/* ============================================================
   1. DATA CLEANING
   ============================================================ */

-- Base table assumed:
-- dbo.credit_dataset

/* 1.1 Remove records with missing critical fields */
DELETE
FROM dbo.credit_dataset
WHERE Loan_Status IS NULL
   OR Current_Loan_Amount IS NULL
   OR Credit_Score IS NULL;


/* 1.2 Normalize Credit Score
   Original dataset stores credit score multiplied by 10
   Example: 7090 → 709
*/
ALTER TABLE dbo.credit_dataset
ADD Credit_Score_Normalized INT;

UPDATE dbo.credit_dataset
SET Credit_Score_Normalized = Credit_Score / 10;


/* 1.3 Handle invalid numeric values */
UPDATE dbo.credit_dataset
SET Annual_Income = NULL
WHERE Annual_Income <= 0;

UPDATE dbo.credit_dataset
SET Monthly_Debt = NULL
WHERE Monthly_Debt < 0;


/* ============================================================
   2. ANALYTICAL VIEWS
   ============================================================ */

/* 2.1 Base analytical view */
CREATE OR ALTER VIEW dbo.vw_loans_base AS
SELECT
    Loan_ID,
    Customer_ID,
    Loan_Status,
    Current_Loan_Amount,
    Term,
    Credit_Score_Normalized,
    Annual_Income,
    Monthly_Debt,
    Home_Ownership,
    Purpose,
    Years_of_Credit_History,
    Number_of_Open_Accounts,
    Number_of_Credit_Problems,
    Current_Credit_Balance,
    Maximum_Open_Credit,
    Bankruptcies,
    Tax_Liens
FROM dbo.credit_dataset;
GO


/* 2.2 Credit Risk View */
CREATE OR ALTER VIEW dbo.vw_credit_risk AS
SELECT
    CASE
        WHEN Credit_Score_Normalized < 580 THEN 'Poor'
        WHEN Credit_Score_Normalized < 670 THEN 'Fair'
        WHEN Credit_Score_Normalized < 740 THEN 'Good'
        WHEN Credit_Score_Normalized < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS Credit_Band,
    Loan_Status,
    COUNT(*) AS Total_Loans,
    SUM(Current_Loan_Amount) AS Total_Loan_Amount
FROM dbo.vw_loans_base
GROUP BY
    CASE
        WHEN Credit_Score_Normalized < 580 THEN 'Poor'
        WHEN Credit_Score_Normalized < 670 THEN 'Fair'
        WHEN Credit_Score_Normalized < 740 THEN 'Good'
        WHEN Credit_Score_Normalized < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END,
    Loan_Status;
GO


/* 2.3 Financial Profile View */
CREATE OR ALTER VIEW dbo.vw_financial_profile AS
SELECT
    Loan_Status,
    AVG(Annual_Income) AS Avg_Annual_Income,
    AVG(Monthly_Debt) AS Avg_Monthly_Debt
FROM dbo.vw_loans_base
GROUP BY Loan_Status;
GO


/* 2.4 Loan KPIs View */
CREATE OR ALTER VIEW dbo.vw_loan_kpis AS
SELECT
    COUNT(*) AS Total_Loans,
    SUM(Current_Loan_Amount) AS Total_Loan_Amount,
    AVG(Current_Loan_Amount) AS Avg_Loan_Amount
FROM dbo.vw_loans_base;
GO


/* ============================================================
   3. EXPLORATORY DATA ANALYSIS (EDA)
   ============================================================ */

/* 3.1 Loan Status Distribution */
SELECT
    Loan_Status,
    COUNT(*) AS Total_Loans
FROM dbo.vw_loans_base
GROUP BY Loan_Status
ORDER BY Total_Loans DESC;


/* 3.2 Loan Amount Statistics */
SELECT
    MIN(Current_Loan_Amount) AS Min_Loan,
    MAX(Current_Loan_Amount) AS Max_Loan,
    AVG(Current_Loan_Amount) AS Avg_Loan
FROM dbo.vw_loans_base;


/* 3.3 Median Loan Amount */
SELECT
    PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY Current_Loan_Amount)
    OVER () AS Median_Loan_Amount
FROM dbo.vw_loans_base;


/* 3.4 Non-Performing Loan (NPL) Rate */
SELECT
    100.0 * SUM(
        CASE
            WHEN Loan_Status IN ('Charged Off', 'Default', 'Late') THEN 1
            ELSE 0
        END
    ) / COUNT(*) AS NPL_Rate_Percentage
FROM dbo.vw_loans_base;


/* 3.5 Exposure at Risk */
SELECT
    SUM(Current_Loan_Amount) AS Exposure_At_Risk
FROM dbo.vw_loans_base
WHERE Loan_Status IN ('Charged Off', 'Default', 'Late');


/* 3.6 NPL Rate by Credit Band */
SELECT
    Credit_Band,
    100.0 * SUM(
        CASE
            WHEN Loan_Status IN ('Charged Off', 'Default', 'Late') THEN 1
            ELSE 0
        END
    ) / COUNT(*) AS NPL_Rate
FROM (
    SELECT
        CASE
            WHEN Credit_Score_Normalized < 580 THEN 'Poor'
            WHEN Credit_Score_Normalized < 670 THEN 'Fair'
            WHEN Credit_Score_Normalized < 740 THEN 'Good'
            WHEN Credit_Score_Normalized < 800 THEN 'Very Good'
            ELSE 'Excellent'
        END AS Credit_Band,
        Loan_Status
    FROM dbo.vw_loans_base
) t
GROUP BY Credit_Band
ORDER BY NPL_Rate DESC;


/* 3.7 Income vs Debt by Loan Status */
SELECT
    Loan_Status,
    AVG(Annual_Income) AS Avg_Annual_Income,
    AVG(Monthly_Debt) AS Avg_Monthly_Debt
FROM dbo.vw_loans_base
GROUP BY Loan_Status;


/* ============================================================
   END OF FILE
   ============================================================ */
