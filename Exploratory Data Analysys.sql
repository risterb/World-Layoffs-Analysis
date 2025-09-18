-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2;

-- 1. Finding Max Values and Peak Data Points
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- 2. Identify Date range

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- 3. Looking at data per time period

SELECT YEAR(`date`), industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR (`date`),industry
ORDER BY 3 DESC;

-- 4. Rolling data for months

SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;


WITH rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS Total_Off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, Total_Off ,SUM(Total_off) OVER(ORDER BY `MONTH`) AS roll_total
FROM rolling_total;

-- 5. Ranking Data 

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
;

WITH company_year (company, years, laid_off_total) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY laid_off_total DESC) AS year_rank
FROM company_year
WHERE years IS NOT NULL
ORDER BY year_rank ASC
;

WITH company_year (company, years, laid_off_total) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_year_Rank AS 
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY laid_off_total DESC) AS year_rank
FROM company_year
WHERE years IS NOT NULL
)

SELECT *
FROM Company_year_Rank
WHERE year_rank <= 5
;

