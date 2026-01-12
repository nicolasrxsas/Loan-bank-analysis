# Credit Risk Analysis Dashboard | SQL Server & Power BI

## 📌 Project Overview
This project presents an end-to-end **credit risk analysis** using a real-world style loan dataset.  
The objective is to assess **portfolio exposure**, **default risk**, and **borrower financial profiles**, delivering actionable insights through a professional **Power BI dashboard**.

The project simulates a typical workflow used in banking and financial analytics roles, combining **SQL-based data preparation** with **DAX-driven analytical modeling**.

---

## 🧠 Business Questions Addressed
- What is the overall size and exposure of the loan portfolio?
- What percentage of loans are non-performing (NPL Rate)?
- How does credit risk vary across different credit score bands?
- Are non-performing loans associated with higher loan amounts?
- How do income and debt levels differ between paid and defaulted loans?

---

## 🗂️ Dataset
- Source: Loan & Banking dataset (cleaned and standardized)
- Records: > 100,000 loans
- Key features:
  - Loan status
  - Loan amount
  - Credit score
  - Annual income
  - Monthly debt
  - Credit history variables

A cleaned version of the dataset is available in:

- data/credit_dataset_clean.csv

---

## 🧹 Data Preparation (SQL Server)
All data preparation was performed in **SQL Server**, including:
- Data cleaning and type normalization
- Credit score normalization
- Creation of analytical views
- Removal of invalid and missing values

Key SQL artifacts:
- sql/data_cleaning.sql
- sql/views_creation.sql

---

## 📐 Data Modeling & Measures (Power BI)
- Explicit DAX measures (implicit measures disabled)
- Median-based metrics for skewed distributions
- Risk-focused KPIs aligned with banking standards

Key KPIs:
- Total Loans
- Median Loan Amount
- Non-Performing Loan (NPL) Rate
- Exposure at Risk (Amount & %)
- Average Credit Score

---

## 📊 Dashboard Overview
The Power BI dashboard is structured into four analytical sections:

### 1️⃣ Portfolio Overview
- Total Loans
- Median Loan Amount
- Exposure at Risk
- NPL Rate

### 2️⃣ Credit Risk Analysis
- NPL Rate by Credit Band
- Loan outcomes by credit quality (100% stacked bar)

### 3️⃣ Financial Profile Analysis
- Average annual income vs. monthly debt by loan status
- Comparison of repayment capacity

### 4️⃣ Loan Amount Analysis
- Median loan amount by loan status
- Identification of higher-risk exposure segments

📁 Power BI file:
- powerbi/credit_risk_dashboard.pbix

---

## 🔍 Key Insights
- Lower credit score bands exhibit significantly higher default rates.
- Non-performing loans have higher median loan amounts than fully paid loans.
- Exposure at risk represents a substantial portion of the total portfolio.
- Borrowers with charged-off loans show weaker income-to-debt profiles.

---

## 🛠️ Tools & Technologies
- **SQL Server** – Data cleaning and transformations
- **Power BI** – Data modeling, DAX measures, and dashboard design
- **DAX** – Explicit measures for financial and risk KPIs

---

## 🚀 How to Use This Project
1. Review the cleaned dataset in `/data`
2. Explore SQL scripts in `/sql`
3. Open the Power BI dashboard using Power BI Desktop
4. Interact with slicers to explore credit risk across segments

---

## 📌 Author
**Nicolas**  
Aspiring Data Analyst | Business Intelligence & Financial Analytics  

This project is part of my professional portfolio and reflects real-world analytical practices used in credit risk analysis.

---

## 📄 License
This project is for educational and portfolio purposes only.

