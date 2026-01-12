# DAX Measures & Calculated Columns

This document summarizes the **main DAX measures and calculated columns** used in the Credit Risk Analysis Dashboard.  
All measures were created explicitly (implicit measures disabled) to ensure clarity, control, and consistency.

---

## 📌 Calculated Columns

### Credit Band
Categorizes borrowers based on normalized credit score ranges.

```DAX
Credit Band =
SWITCH(
    TRUE(),
    vw_loans_base[Credit_Score_Normalized] < 580, "Poor",
    vw_loans_base[Credit_Score_Normalized] < 670, "Fair",
    vw_loans_base[Credit_Score_Normalized] < 740, "Good",
    vw_loans_base[Credit_Score_Normalized] < 800, "Very Good",
    "Excellent"
)
```
### Credit Band Order
Defines a logical order for credit bands to avoid alphabetical sorting in visuals.
```Credit Band Order =
SWITCH(
    TRUE(),
    vw_loans_base[Credit_Score_Normalized] < 580, 1,
    vw_loans_base[Credit_Score_Normalized] < 670, 2,
    vw_loans_base[Credit_Score_Normalized] < 740, 3,
    vw_loans_base[Credit_Score_Normalized] < 800, 4,
    5
)
```
This column is used to sort Credit Band correctly:
``` nginx
Poor → Fair → Good → Very Good → Excellent
```
## 📊 Core DAX Measures

### Total Loans
Total number of loans in the portfolio.

```DAX
Total Loans =
COUNTROWS(vw_loans_base)
```
### Total Loan Amount
Total outstanding loan amount.

```DAX
Total Loan Amount =
SUM(vw_loans_base[Current_Loan_Amount])

```
### Median Loan Amount
Median loan amount, used instead of average due to skewed distributions.

```DAX
Median Loan Amount =
MEDIAN(vw_loans_base[Current_Loan_Amount])

```
### NPL Rate
Percentage of non-performing loans.

```DAX
NPL Rate =
DIVIDE(
    CALCULATE(
        COUNTROWS(vw_loans_base),
        vw_loans_base[Is NPL] = 1
    ),
    [Total Loans]
)

```
### Exposure at Risk
Total loan amount associated with non-performing loans.

```DAX
Exposure at Risk =
CALCULATE(
    SUM(vw_loans_base[Current_Loan_Amount]),
    vw_loans_base[Is NPL] = 1
)

```
### Exposure at Risk %
Share of total loan exposure represented by non-performing loans.

```DAX
Exposure at Risk % =
DIVIDE(
    [Exposure at Risk],
    [Total Loan Amount]
)

```
### Average Credit Score
Average normalized credit score across the portfolio.

```DAX
Average Credit Score =
AVERAGE(vw_loans_base[Credit_Score_Normalized])

```
### Average Annual Income
Average borrower annual income by context.

```DAX
Avg Annual Income =
AVERAGE(vw_loans_base[Annual_Income])

```
### Average Monthly Debt
Average borrower monthly debt by context.

```DAX
Avg Monthly Debt =
AVERAGE(vw_loans_base[Monthly_Debt])

```
# Notes

- Median-based metrics were preferred over averages for skewed financial distributions.

- Explicit measures improve transparency and interview explainability.

- Calculated columns were used only when required for categorization or sorting.
