-- Problem 1 : Get the number of seasons
SELECT DISTINCT EXTRACT(YEAR FROM date) AS season 
FROM ipl_m;

-- Bonus : Get the count number of seasons
SELECT COUNT(DISTINCT EXTRACT(YEAR FROM date)) 
FROM ipl_m;

-- Extra : Create view - v_ipl_m_with_season.
CREATE VIEW AS v_ipl_m_with_season
SELECT DISTINCT EXTRACT(YEAR FROM date) AS season 
FROM ipl_m;