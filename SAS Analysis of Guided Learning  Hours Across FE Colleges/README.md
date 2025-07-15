
# 📊 Guided Learning Hours Analysis in UK Colleges (SAS Studio)

## 📝 Summary

This report presents an in-depth analysis of Guided Learning Hours (GLH) in Sixth Form and Further Education colleges across various UK regions over three academic years. The analysis was conducted using **SAS Studio**, applying statistical methods such as General Linear Models (GLM), ANOVA, T-tests, and Univariate Analysis.

Key findings include:

- A significant difference in GLH between college types.
- Year-to-year variation in GLH per learner.
- The **region** of an institution significantly influences GLH.
- The **size** of the college (based on total GLH) showed **no significant impact** on GLH per learner.

---

## 🔧 Methods

### 📥 Data Importation & Cleaning

- Data was imported as CSV files (Sixth Form and FE Colleges).
- SAS macros using `PROC IMPORT` and `PROC CONTENTS` were used to inspect structure.
- Cleaned using `INFILE`, `INPUT`, `IF-ELSE`, and `CALCULATED` functions.
- Created:
  - A merged dataset using `SET`.
  - Derived variables like `GLH per learner`.
  - Size classification based on total GLH.
- Removed:
  - Missing values.
  - Aggregate region rows (to prevent duplication bias).

Final cleaned dataset: **337 observations**

### 🔍 Identifying Anomalies

- **PROC FREQ** to identify duplicated/categorical distributions.
- **PROC UNIVARIATE** for detecting outliers.
- Found:
  - FE Colleges had **lower extremes**.
  - Sixth Form Colleges had **higher extremes**.
  - Outliers retained for analytical validity.

### 📈 Exploratory Data Analysis

#### Normality Testing

- Used **Histograms** and **Q-Q plots**.
- Found highly **positively skewed** distributions.
- **Shapiro-Wilk p-values < 0.01** → non-normal.

#### Data Transformation

- Applied **Box-Cox transformations** via `PROC FCMP`.
- Best result: **Reciprocal Square Root (rcpsqrt)**.
- Final skewness: **< ±0.1** (Acceptable)
- Dropped original variables and retained transformed ones for modeling.

---

## 📊 Statistical Modeling

Utilized:

- `PROC GLM` – assess effects of **region, size, and college type**.
- `PROC TTEST` – compare **means across college types**.
- `PROC ANOVA` – assess variation across **years, size, and region**.

---

## 📌 Analysis & Discussion

### 🎓 College Type Effect

- College type had **significant impact** on GLH per learner.
- Sixth Form Colleges consistently offered **higher GLH per learner**.
- T-test p-values: **< 0.01** across all years.

### 📅 Year Effect

- GLH did not differ significantly year-to-year.
- Year 1 had slightly higher **standard deviation**, indicating variation.

### 🌍 Region Effect

- Major differences in GLH per learner across regions.
- Significant pairs: South West vs. Greater London, East Midlands vs. North West, etc.
- P-values: **< 0.05**

### 🏫 Size Effect

- No statistically significant effect on GLH per learner.
- ANOVA p-value: **0.22**

### 🧮 Two-Way Interaction Effects

#### Size and Year:

- Smaller colleges showed **more efficient GLH per learner**.
- Larger colleges had higher **total GLH** but lower **per learner**.
- Normality checks passed (Skewness & Kurtosis < 1).
- GLM showed:
  - **Size-by-Year interaction was not significant** (p = 0.5795).
  - **Main effects (Size, Region)** were significant.

#### College Type and Year:

- Clear significant differences between college types in all years.
- Year 2 showed **non-significant variance** in GLH per learner (p = 0.1690).

#### Region and College Type:

- Interaction significant in Year 1 and 2 (p < 0.05).
- Year 3 interaction: **not significant** (p = 0.0803).
- Greater London, East of England, and North West consistently exhibited higher GLH.

---

## ✅ Conclusion

- **College Type** is the **most influential factor** on GLH per learner.
- **Region** also plays a significant role.
- **Size** and **Year** showed limited or no significant impact.
- Educational planning should consider **regional disparities and college type** to optimize learning hours.

---

## 📚 References

1. Rutherford, A. (2000). *Introducing ANOVA and ANCOVA.*
2. Kim, T.K. (2015). *T-test as a parametric statistic*. Korean Journal of Anesthesiology, 68(6), 540.
3. Wilson, A.E. & Ross, M. (2000). *The frequency of temporal-self and social comparisons*. Journal of Personality and Social Psychology, 78(5), 928.

---

## 🗂️ Appendix

### 📈 T-test Showing Effect of College Type on GLH per Learner (All Years)

![T-test Analysis](SAS%206.png)

### 📊 Colleges with Lowest Amount of GLH per Learner

![Lowest GLH Table](SAS%2010.png)
