# COVID-19 Data Analysis
## Context and Goals
Our project will implement collect, process and analyze data from open sources on morbidity and mortality from COVID-19 to determine vaccine distribution priorities. The result of the project will be the creation of an informational guide with detailed recommendations for the US government on the distribution of vaccines by region (districts, cities, states), gender, race and social groups (doctors, police, etc.). The generated guide will be presented as a pdf file.
## Technical solution overview
### Automation
1. Filter/download state daily case count data on CDC website
2. Search and data scrape covid testing sites/telehealth centers based on zip code on HRSA website
3. Search and data scrape covid and rapid testing sites with appointment booking information on Solv website
4. Search and download hospital/ICU capacity based on county on ESRI website
5. Data processing: 
   * Find relationships between .CSV files
   * Remove null rows and exception handling to log it to a table
   * Transform data and map columns to a centralized database
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
- Anuradhat Edirisuriya
- Dmitrii Lutcenko  
- Min Wei        
- Ruslan Kashanov
