# COVID-19 Data Analysis
## Context and Goals
Our project will collect, process and analyze data from open sources COVID-19 cases and deaths to determine vaccine distribution priorities. The result of the project will be the creation of an informational guide with detailed recommendations for the US government on the distribution of vaccines by region (districts, cities, states), gender, race and occupation (doctors, police, etc). The generated guide will be presented as a PDF file.
## Technical solution overview
### Automation
1. Filter/download state daily case count data on [CDC website](https://data.cdc.gov/Case-Surveillance/United-States-COVID-19-Cases-and-Deaths-by-State-o/9mfq-cb36/data)
2. Search and data scrape of official covid guidance from [CDC website](https://www.cdc.gov/coronavirus/2019-ncov/hcp/duration-isolation.html)
2. Search and data scrape covid testing sites centers based on zip code on [HRSA website](https://findahealthcenter.hrsa.gov/)
3. Search and data scrape covid and rapid testing sites with appointment booking information on [Solv website](https://www.solvhealth.com/)
4. Search and download hospital/ICU capacity based on county on [ESRI website](https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds/)
5. Data processing: 
   * Read in data from CSV files
   * Remove null records 
   * Transform data and map columns to a centralized database
6. Generate graphs with MS Excel
7. Save information guide as PDF file in dedicated directory on user's machine
### Tech stack
- T-SQL
- SSIS
- SSAS
- SSRS
### Tools
- Microsoft SQL Server 2016
- Microsoft SQL Managment Studio 18 
- Microsoft Visual Studio 2017
- GitHub
## Project work breakdown
[TODO](TODO.md)
## Data source
[CSV files](Sources.md)
## Team
- Dmitrii Lutcenko 
- Anuradhat Edirisuriya
- Min Wei        
- Ruslan Khasanov
