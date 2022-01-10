-- Problem 7 : Get the final match for a given season
SELECT team1, team2 
FROM v_ipl_m_with_season 
WHERE season = '2018' 
ORDER BY date DESC 
LIMIT 1;

-- Bonus : Get final matches for all seasons
-- postgres only solution
SELECT DISTINCT ON (season) team1, team2 
FROM v_ipl_m_with_season 
ORDER BY season, date DESC;

-- generic solution
WITH temp_cte AS 
(
    SELECT *,
    row_number() OVER (
        PARTITION BY season 
        ORDER BY date DESC
        ) AS rn
    FROM v_ipl_m_with_season
)
SELECT team1, team2
FROM temp_cte
WHERE rn = 1
ORDER BY date;
