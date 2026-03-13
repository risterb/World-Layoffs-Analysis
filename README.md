<h1 align="center">World Layoffs Overview</h1>

## Summary
This project analyzes global layoffs across companies and industries from 2020 to 2023. The main objective is analyzing the data through the lens of world events that affected global job markets and identifying patterns accross sectors. 
The project focuses on understaning:
- Which industries, countries and companies experienced the most layoffs
- When layoffs peaked across the board
- The evolution of the layoffs as years went by
- Which countries led layoffs each year

## Dashboard Preview
<p align="center">
<img width="773" height="516" alt="image" src="https://github.com/user-attachments/assets/7d44ebed-eafb-448a-b35f-55afd7bd790c" />
</p>

### Top Skills
- SQL (MySQL)
- Data Cleaning
- Window Functions
- Exploratory Data Analysis
- Data Visualization
- Power BI Dashboard Development

## World Layofs Analysis

### 1. Technology sector heavily impacted
Technology companies account for the largest share of layoffs accross the world. This sector had an important expansion during the pandemic, followed by a significant correction in the market as the status of the emergency evolved. 

<p align="center">
<img width="700" height="406" alt="layoffs_by_company" src="https://github.com/user-attachments/assets/31d41f2c-7897-4d98-a762-652a1457dfc1" />
</p>

### 2. Different industries saw the impact at different stages
The data shows that different industries peaked at different stages in the 2020-2023 timeframe. The transportation and finance markets had the most layoffs directly after the pandemic shutdowns in 2020. By 2023, the growth experience in the technology sector (here classified as 'Other') saw a rapid decline as the world returned to normalcy. 

<p align="center">
<img width="700" height="406" alt="layoffs_by_industry" src="https://github.com/user-attachments/assets/2f378af4-ec66-4818-ada8-2b1cbc68f668" />
</p>

### 3. Layoffs accelerated in 2022-2023
Monthly records show a sharp spike in 2022 into 2023, suggesting macroeconomic pressures following relative stability since the 2020 layoffs due to post-pandemic restructuring and correction.

<p align="center">
<img width="1000" height="319" alt="layoffs_per_month" src="https://github.com/user-attachments/assets/221efdd4-fd14-41ee-a8d1-e43c7b5651e0" />
</p>

### 4. The United States dominated layoff events

<p align="center">
<img width="1000" height="319" alt="layoffs_by_country" src="https://github.com/user-attachments/assets/a6fabc0d-70f2-4c6b-9246-f253dd4ff1b3" />
</p>

## Dataset & Tools
- Source: layoffs.csv
- Tools: GitHub, MySQL, PowerBI
- Key variables in data source

| Column | Description |
|--------|-------------|
| company | Company conducting layoffs |
| industry | Industry classification |
| country | Country where layoffs occurred |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Share of workforce laid off |
| funds_raised_millions | Funding raised prior to layoffs |
| date | Date of the layoff event |


