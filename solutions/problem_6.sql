-- Problem 6 : Get total matches played by each team
-- CTE solution
WITH cte AS (
	SELECT team1 AS team 
	FROM ipl_m
	UNION ALL 
	SELECT team2 AS team 
	FROM ipl_m)
SELECT team, COUNT(team) AS matches_played from cte
GROUP BY team
ORDER BY matches_played DESC;

-- Subquery Solution
SELECT team, COUNT(team) AS matches_played from (
    SELECT team1 AS team 
	FROM ipl_m
	UNION ALL 
	SELECT team2 AS team 
	FROM ipl_m
) AS subq
GROUP BY team
ORDER BY matches_played DESC;

-- Bonus : 
WITH cte1 AS (
	SELECT * 
	FROM ipl_m 
	WHERE (result = 'runs' AND result_margin < 4) OR (result = 'wickets' AND result_margin < 3)
),
cte2 AS (
	SELECT team1 AS team 
	FROM cte1
	UNION ALL 
	SELECT team2 AS team 
	FROM cte1)
SELECT team, COUNT(team) AS matches_played from cte2
GROUP BY team
ORDER BY matches_played DESC;