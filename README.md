# Project 3 – Loan & Banking Data Analysis

## 📊 Project Overview
This project analyzes banking loan data with the objective of identifying credit risk patterns, repayment behavior, and key financial characteristics of customers.

The dataset used is a real-world dataset obtained from Kaggle and serves as a replacement for **Dataset C (Loans & Banking)** from the Google Data Analytics Capstone Project.

---

## 🗂 Dataset Information
- **File name:** `credit_dataset_clean.csv`
- **Number of records:** ~100,514
- **Number of features:** 19
- **Original source:** Kaggle – *Bank Loan Status Dataset*

The dataset contains demographic, financial, and credit history information, along with the current status of each loan.

---

## ⚙️ Data Preparation Process

### 1️⃣ Data Loading
The original file (`credit_train.csv`) was loaded using **Python and Pandas**, validating:
- Dataset structure
- Data types
- Overall consistency of variables

---

### 2️⃣ Exploratory Data Analysis (EDA)
During the initial exploration, the following issues were identified:
- Missing values in key variables such as **Credit Score** and **Annual Income**
- Extreme and unrealistic values
- Highly skewed distributions in monetary variables

---

### 3️⃣ Data Cleaning
The following cleaning rules were applied to improve data quality:

- Explicit conversion of numeric columns
- Replacement of impossible or extreme values with null values (`NA`):
  - `Current Loan Amount` > 5,000,000
  - `Credit Score` > 850
  - `Annual Income` > 10,000,000
  - `Monthly Debt` > 50,000
  - `Maximum Open Credit` > 10,000,000

These decisions help prevent analytical bias and ensure more reliable insights.

---

## 📐 Key Variables
Some of the most relevant variables in the final dataset include:
- **Loan Status**
- **Current Loan Amount**
- **Credit Score**
- **Annual Income**
- **Monthly Debt**
- **Years of Credit History**
- **Number of Credit Problems**
- **Bankruptcies**
- **Home Ownership**
- **Purpose**

---

## 🎯 Analysis Objectives
- Identify factors associated with loan default
- Analyze customer profiles with higher credit risk
- Evaluate relationships between income, debt, and repayment behavior
- Serve as a foundation for dashboards and predictive models

---

## 🚀 Next Steps
- Missing value imputation
- Feature engineering (financial ratios and customer segmentation)
- Advanced descriptive analysis
- Data visualization using Power BI
- Development of predictive credit risk models

---

## 🛠 Tools Used
- **Python (Pandas)**
- **Power BI**
- **GitHub**

---

📌 *This project is part of a Data Analytics training process and is designed to demonstrate practical, real-world analytical skills in a financial context.*
