# COVID-19 Data Analysis
## Context and Goals
Our project will collect, process and analyze data from open sources COVID-19 cases and deaths to determine vaccine distribution priorities. The result of the project will be the creation of an informational guide with detailed recommendations for the US government on the distribution of vaccines by region (districts, cities, states), gender, race and age. The generated guide will be presented as report into a PDF file.
## Technical solution overview
### Action Plan
1. Search and load a dataset from public data sources [See Data Source List](DataSourceList.md).
2. Process data using MS Excel to filter and remove dublicate records.
3. Process data using SSIS to filter and merge the data.
4. Load data into data warehouse.
5. Generate an OLAP structure using SSAS to organize the data.
6. Prepare and generate report using SSRS.
7. Save information report as PDF file in dedicated directory on user's machine.
### Tech stack
* Microsoft Excel
* Microsoft Server 2016
* Microsoft SQL Server Management Studio
* Microsoft Visual Studio 2017
* SQL Server Integrations Services
* SQL Server Analysis Services
* SQL Server Reporting Services
* Git (GitHub)
## Project work breakdown
[See TODO List](TODO.md)
## Team
- Dmitrii Lutcenko      - Team Leader
- Anuradhat Edirisuriya
- Min Wei        
- Ruslan Khasanov
