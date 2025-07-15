
# 📊 Guided Learning Hours Analysis in UK Colleges (SAS Studio)

## 📝 Summary

This report presents an in-depth analysis of Guided Learning Hours (GLH) in Sixth Form and Further Education colleges across various UK regions over three academic years. The analysis was conducted using **SAS Studio**, applying statistical methods such as General Linear Models (GLM), ANOVA, T-tests, and Univariate Analysis.

Key findings include:

- A significant difference in GLH between college types.
- Year-to-year variation in GLH per learner.
- The **region** of an institution significantly influences GLH.
- The **size** of the college (based on total GLH) showed **no significant impact** on GLH per learner.


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


## 📊 Statistical Modeling

Utilized:

- `PROC GLM` – assess effects of **region, size, and college type**.
- `PROC TTEST` – compare **means across college types**.
- `PROC ANOVA` – assess variation across **years, size, and region**.


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


## ✅ Conclusion

- **College Type** is the **most influential factor** on GLH per learner.
- **Region** also plays a significant role.
- **Size** and **Year** showed limited or no significant impact.
- Educational planning should consider **regional disparities and college type** to optimize learning hours.


## 📚 References

1. Rutherford, A. (2000). *Introducing ANOVA and ANCOVA.*
2. Kim, T.K. (2015). *T-test as a parametric statistic*. Korean Journal of Anesthesiology, 68(6), 540.
3. Wilson, A.E. & Ross, M. (2000). *The frequency of temporal-self and social comparisons*. Journal of Personality and Social Psychology, 78(5), 928.

Appendix
<img width="462" height="108" alt="SAS 1" src="https://github.com/user-attachments/assets/6ad5c2c8-803a-4c72-b309-871d5bfc7bf9" />
<img width="268" height="184" alt="SAS 3" src="https://github.com/user-attachments/assets/871a98f3-14c0-4798-b9a5-a9c386409d64" />
<img width="460" height="96" alt="SAS 2" src="https://github.com/user-attachments/assets/ecca407e-f7be-4bb2-a768-509dfe71172e" />

<img width="608" height="236" alt="SAS 10" src="https://github.com/user-attachments/assets/6db4ac72-2081-4cf7-bd56-6119bf11d708" />
<img width="244" height="318" alt="SAS 9" src="https://github.com/user-attachments/assets/95537de7-377f-4b1b-9011-14f0bea6f3e2" />
<img width="272" height="252" alt="SAS 8" src="https://github.com/user-attachments/assets/2cd4a4fa-e2ba-42b1-bffa-532bfc15f041" />
<img width="288" height="264" alt="SAS 7" src="https://github.com/user-attachments/assets/8d5051ac-bf2e-4713-8acc-c04d5de5798e" />
<img width="272" height="256" alt="SAS 6" src="https://github.com/user-attachments/assets/3f558dfe-457c-4e32-bb8f-915a7dbdc5d2" />
<img width="282" height="258" alt="SAS 5" src="https://github.com/user-attachments/assets/76fa63ef-0b06-4291-b1fa-c59e685ff653" />
<img width="264" height="184" alt="SAS 4" src="https://github.com/user-attachments/assets/559ae754-9192-4750-a754-e690c68b7c5e" />



