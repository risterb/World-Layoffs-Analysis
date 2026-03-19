-- Total Layoffs by Company Insight--
CREATE VIEW layoffs_top_companies AS
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company;

SELECT *
FROM layoffs_top_companies;

-- 	Total Layoffs by Industry Insight--
CREATE VIEW layoffs_by_industry AS
SELECT industry, SUM(total_laid_off) AS total_industry_layoffs
FROM layoffs_staging2
GROUP BY industry;

SELECT *
FROM layoffs_by_industry;

-- Layoffs per Month Insight--
CREATE VIEW layoffs_monthly AS
SELECT DATE_FORMAT(`date`,'%Y-%m-01') AS month_date,SUM(total_laid_off) AS layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY month_date;

SELECT * FROM layoffs_monthly;

-- Layoffs by Country Insight--
CREATE VIEW layoffs_by_country AS
	SELECT country, YEAR(`date`) AS years, SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY country, years;

SELECT * FROM layoffs_by_country;

-- Cumulative Layoffs Insight--
CREATE VIEW cumulative_layoffs_MoM AS 
	SELECT month_date, total_layoffs, SUM(total_layoffs) OVER (ORDER BY month_date) AS cumulative_layoffs
    FROM (
		SELECT DATE_FORMAT(`date`,'%Y-%m-01') AS month_date,
        SUM(total_laid_off) as total_layoffs
        FROM layoffs_staging2
        WHERE `date` IS NOT NULL
        GROUP BY month_date) monthly_totals;
        
SELECT * FROM cumulative_layoffs_MoM;

-- Insight Industry per Year--
CREATE VIEW Layoffs_by_Industry_Year AS
SELECT YEAR(`date`) AS years, industry, company, SUM(total_laid_off) as total_layoffs
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY years, industry, company;

SELECT * FROM layoffs_by_industry_year;

-- Layoffs per Stage Insight--
CREATE VIEW layoffs_per_stage AS
	SELECT YEAR(`date`) AS years,
	CASE
		WHEN stage IN ('Seed','Series A','Series B') THEN 'Early Stage'
        WHEN stage IN ('Series C','Series D','Series E') THEN 'Growth Stage'
        WHEN stage IN ('Series F','Series G','Series H','Series I','Series J') THEN 'Late Stage'
        WHEN stage = 'Post-IPO' THEN 'Public Company'
        WHEN stage='Unknown' OR stage IS NULL THEN 'Unknown'
        ELSE 'Other'
    END AS stage_category,
	SUM(total_laid_off) AS layoffs
	FROM layoffs_staging2
	WHERE SUBSTRING(`date`,1,7) IS NOT NULL
	GROUP BY years, stage_category;
    
    SELECT * FROM layoffs_per_stage;

-- Layoff Severity Insight--
CREATE VIEW layoff_severity_percentage AS
	SELECT YEAR(`date`) AS years, industry,
            CASE
				WHEN percentage_laid_off = 1 THEN 'Company Shutdown'
                WHEN percentage_laid_off >= 0.5 THEN 'Mass Layoff (50%+)'
                WHEN percentage_laid_off >= 0.25 THEN 'Major Layoff (25-50%)'
                WHEN percentage_laid_off >= 0.10 THEN 'Moderate Layoff (10-25%)'
                ELSE 'Minor Layoff(<10%)'
			END AS layoff_severity,
            COUNT(*) AS layoff_events,
			SUM(total_laid_off) AS total_layoffs
	FROM layoffs_staging2
	WHERE percentage_laid_off IS NOT NULL
	GROUP BY industry,layoff_severity,years;

    SELECT * from layoff_severity_percentage;

