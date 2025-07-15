# Leicestershire Road Safety Analysis (2010 - 2020)

## Introduction and Methodology

### Source and License of Data

The road safety data used in this analysis is sourced from the **UK Department for Transport**, and it is made publicly available under the **Open Government License**. The datasets consist of personal injury accidents on public roads, reported to the police within 30 days of the incident. The data, collected using the **STATS19 accident reporting form**, includes details on casualties, accident severity, involved vehicles, location, and environmental conditions.

### Data Format

The datasets are available in **CSV (Comma-Separated Values)** format. Individual files containing accident and casualty data from **1979 to 2020** were downloaded from the [Road Safety Data Portal](https://data.gov.uk/dataset/road-accidents-safety-data). This extended time range was necessary due to unavailability of more targeted data on the portal.

### Work Environment and Data Loading

* Files were uploaded to the **Jupyter File Browser** and transferred to **HDFS (Hadoop Distributed File System)** via a web console.
* A **Python 3 environment** was used within **Jupyter Notebook**.
* Required libraries included **Spark Core**, **Spark Context**, **Spark SQL**, and other relevant functions.
* Data was loaded as **RDDs (Resilient Distributed Datasets)** using `sc.textFile()`.

**Dataset Summary:**

* **Casualties Dataset:** 11,449,313 rows, 18 columns
* **Accidents Dataset:** 8,602,825 rows, 36 columns

### Data Cleaning and Processing

* Lines were split and **essential columns** were selected using `map()` and `lambda`:

  * **6 columns** from the Casualties dataset
  * **18 columns** from the Accidents dataset

* RDDs were then converted into **DataFrames** for optimized processing.

* Headers were removed and **custom schemas** were defined to specify data types and handle null values.

### Filtering and Joining Datasets

* Data filtered for **years 2010–2020** and **Leicestershire** local authority district codes.
* Row counts after filtering:

  * **Casualties DataFrame:** 30,061 rows
  * **Accidents DataFrame:** 22,523 rows
* Datasets were **joined** to form a unified DataFrame (27 columns) with enriched spatial and road condition data.

### Label Transformation

* Many columns used **numeric codes** representing categories (e.g., road type, light conditions).
* Labels were transformed to human-readable text using `withColumn()` and `regexp_replace()`.
* Interpretations were sourced from official value label sheets (XLSX format).

### Data Type Conversion

* Data types were initially strings. Columns were cast to appropriate types:

  * **Latitude, Longitude** → Double
  * **Year, Age** → Integer
  * **Date** → Date format using `to_date()` and `date_format()`

### Feature Engineering

New features were created to aid analysis:

* **Age Band** from the Age column
* **Month** and **Quarter** from the Date column using UDFs and `withColumn()`

### Null Value Check

* A custom counter was defined to check for null values across all columns in both datasets.


## Data Analysis

### Accidents and Casualties by Year

* A **steady decline** in casualties and accidents from 2010 to 2020.
* **2014** marked a slight increase in both, standing out from the overall downward trend.
* Significant reduction from **2017 to 2020**, possibly due to improved safety measures and **COVID-19 lockdowns**.

### Quarterly Trends

* **Quarter 4** records the **highest number** of accidents and casualties consistently.
* **Quarter 1** has the **lowest counts**.
* **Quarter 2 of 2020** shows a sharp drop due to pandemic restrictions.
* **2014 Q1** also shows unusually high accident figures.

### Monthly Trends

* **October and November** have the **highest accident counts**.
* **April, February, and December** are the **safest months** based on accident records.

### Day of Week Trends

* **Friday** consistently sees the **highest accident and casualty rates**.
* **Wednesday** and **Tuesday** also have high frequencies.
* **Sunday** has the **lowest accident rate**, followed by **Monday**.
* Year-on-year trends show:

  * **Sunday** always has the fewest accidents.
  * **Friday** dominates in most years (except 2014, 2015, 2019).
  * **Wednesday/Tuesday** alternate in high/low positions.


## Analysis by Local Authority Districts

* **Leicester** has the **highest concentration** of accidents and casualties (39%).
* Followed by:

  * **Charnwood** (13%)
  * **Blaby** (10%)
  * **North West Leicestershire** (10%)
* Least affected:

  * **Rutland** (3%)
  * **Oadby and Wigston** (4%)

### Spatial Cluster Analysis

* Major clusters of accidents:

  * **Leicester City**
  * **Loughborough (Charnwood)**
  * **Hinckley (Hinckley and Bosworth)**
  * **Melton Mowbray (Melton)**
  * **Market Harborough & Lutterworth (Harborough)**

## Further Analysis of Casualties

### Casualty Types and Class

* **Car Occupants** make up **\~50%** of casualties.
* Followed by:

  * **Pedestrians**
  * **Cyclists**
  * **Motorcyclists**, **Van** and **Coach** occupants
* **Drivers/Riders** make up the majority of casualties by class.

### Age Bands

* Over **50%** of casualties fall in the **16–45** age range.
* Highest percentage:

  * **26–35** age group: **19%**
  * Followed by 36–45 (15%), 21–25 (14%), 16–20 (13%), and 46–55 (13%)
* Correlates with NHS population data showing a younger demographic in Leicestershire.

## Environmental and Road Factors

### Road Type

* **Single carriageways** account for **73%** of accidents.
* Other types:

  * **Dual carriageways** (18%)
  * **Roundabouts** (6%)

### Road Surface Conditions

* Majority of accidents occur on **dry surfaces**.
* Wet and frosty conditions contribute a smaller proportion.
* Most accidents on dry surfaces are of **slight severity**.

### Light Conditions

* Most accidents occur in **daylight** conditions.
* Among dark conditions, majority occur when **street lighting is present**.

### Weather Conditions

* **Fine weather** is associated with the majority of accidents.
* **Rainy** and **other adverse conditions** make up the remainder.
* Most accidents in fine weather are also of **slight severity**.

## Conclusion

This analysis provides insight into road accident trends and casualty patterns across Leicestershire from 2010 to 2020. While there is a visible decline in accidents and casualties, key contributing factors such as **day of week, road type, weather**, and **vehicle type** remain consistent influencers. Understanding these patterns helps inform **policy, planning, and road safety interventions**.

For detailed code implementations and visualizations, refer to the **Appendix** or accompanying **Jupyter Notebooks**.


**Data Source:** [UK Road Safety Data](https://data.gov.uk/dataset/road-accidents-safety-data)
**License:** [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/)

