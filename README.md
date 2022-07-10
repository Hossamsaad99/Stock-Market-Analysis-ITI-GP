# Architect, Populate and Explore a Data Warehouse for Stock Market Analysis Project.
## ITI - Data Analytics and Visualization Track - Graduation Project.
## Table of contents
* [General info](#general-info)
* [Introduction](#Introduction)
* [Business Requirememts](#Business-Requirememts)
* [Data Sources](#Data-Sources)
* [Data Warehouse/Data Model](#Data-Model)
* [Business Queries](#Business-Queries)
* [Dashboards](#Dashboard)
* [Conclusion](#Conclusion)

## General Info
This project aims to apply the theories, methodologies and strategies tackled in the training to successfully implement a data warehouse to support business intelligence queries

## Introduction
About Project Info
* S&P 500 index tracks the stock performance of 500 large companies listed on exchanges in the United States
* 36.7 trillion USD
* free-float weighted
* The index is one of the factors in the computation of the Conference Board Leading Economic Index, used to forecast the direction of the economy

## Business Requirememts
* Reporting stock market daily statistics.
* Reporting top and lowest performers.
* Tracking stock market changes.

## Data Sources
* [Wikipedia List of S&P 500 companies](https://en.wikipedia.org/wiki/List_of_S%26P_500_companies) <br />
> * <ins>Date of creation</ins>: 4 April 2022 <br />
> * <ins>Descriptions</ins>: <br />
The S&P 500 stock market index is maintained by S&P Dow Jones Indices. It comprises 503 common stocks which are issued by 500 large-cap companies traded on American stock exchanges (including the 30 companies that compose the Dow Jones Industrial Average). The index includes about 80 percent of the American equity market by capitalization. It is weighted by free-float market capitalization, so more valuable companies account for relatively more weight in the index. The index constituents and the constituent weights are updated regularly using rules published by S&P Dow Jones Indices.<br />
> * <ins>ETL</ins>: <br />
web scraping using beautiful soup and request library with python, file type (CSV) <br />

* [Yahoo finance](https://finance.yahoo.com/quote/AAPL/?p=AAPL)
> * <ins>Date of creation</ins>: 1 July 2018 <br />
> * <ins>Descriptions</ins>: <br />
Yahoo Finance used to have their own official API, but this was decommissioned on May 15th 2017, following wide-spread misuse of data.
These days a range of unofficial APIs and libraries exist to access the same data, including of course yfinance.
Note you might know of yfinance under it’s old name- fix-yahoo-finance, since it was re-named on May 26th 2019 at the same time that it went over a large overhaul to fix some usability issues.<br />
> * <ins>ETL</ins>: <br />
Extract data using web scraping then imported, integrated and transferred it using SSMS, then create the model. 

* [Kaggle](https://www.kaggle.com/camnugent/sandp500)
> * <ins>Date of creation</ins>: 1 June 2018 <br />
> * <ins>Descriptions</ins>: <br />
The folder individual stocks 5yr contains files of data for individual stocks, labelled by their stock ticker name. The allstocks5yr.csv contains the same data, presented in a merged .csv file. Depending on the intended use (graphing, modelling, etc.) the user may prefer one of these given formats..<br />
> * <ins>ETL</ins>: <br />
Extract data using web scraping then imported, integrated and transferred it using SSMS, then create the model.<br />

## Data Warehouse/Data Model
> * <ins>Why did we choose “galaxy schema”?</ins> <br />
We used **galaxy schema** in our model due to its advantages which allowing Dimension Tables to be linked to other Dimension tables, including the Dimension Tables in the first level. This Multidimensional nature makes it easy to implement on complex Relational Database systems, thus resulting in effective Analysis & Reporting processes. <br />
> * <ins>Dimensional Model</ins> <br />
Here's our Dimensional Model Screenshot from SSMS.
![Galaxy Schema](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/MS%20Server%20Modeling.JPG "Galaxy Schema")

## Business Queries 
> * Retrieve Stock performance over7 and 30 days and what are previous and current changes.
Here's Snapshoot of our Sql Query from SSMS.
![First Business query](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/Business%20Queries/1.JPG)

> * Retrieve top 10 days and worst 10 days’ changes.
Here's Snapshoot of our Sql Query from SSMS.
![Second Business query](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/Business%20Queries/2.JPG)

> * Retrieve Stock performance over 7 and 30 days And previous and current changes for the symbol.
Here's Snapshoot of our Sql Query from SSMS.
![Third Business query](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/Business%20Queries/3.JPG)

> * Retrieve volatility KPIS per(years/week) for sectors.
Here's Snapshoot of our Sql Query from SSMS.
![Fourth Business query](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/Business%20Queries/4.JPG)

> * Calculate weight of each company in the stock market.
Here's Snapshoot of our Sql Query from SSMS.
![Fifth Business query](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Modeling/Business%20Queries/5.JPG)

 
 ## Dashboards
> * S&P 500 <br />
Average Volume  - 10 Days top & Worst Close Change  - Performance  - volatility KPIs per secotr <br />
Here's Snapshoot of our first dashboard from PowerBI.
![First dashboard](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Dashboard/D1.JPG)

> * Company Monitoring 
Average Volume  - Historic Data  - Performance  - General Info - Filtration Page <br />
Here's Snapshoot of our first dashboard from PowerBI.
![Second dashboard](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Dashboard/D2.JPG)

> * Comparison <br />
Average price per month  - Top 10 loss / gain close change per company  - Company Close price per date <br />
Here's Snapshoot of our first dashboard from PowerBI.
![Third dashboard](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Dashboard/D3.JPG)

> * Tesla Report <br />
Close price and volume per date  - Stock Performance KPIs  - Tesla Stock Surges - Tesla After Twitter <br />
Here's Snapshoot of our first dashboard from PowerBI. <br />
![Tesla dashboard](https://github.com/Hossamsaad99/Stock-Market-Analysis/blob/main/Dashboard/Tesla.JPG)

## Conclusion
> * Successfully visualized records from 5 years.
> * Enable Individual Company monitoring.
> * Enable Comparison of companies with ease of filtering.
> * Tesla example: Report Created.
