-- Problem 9 : Get total matches played, matches won and win percentage per season
WITH cte AS (
	SELECT team1 as team, winner, season
	FROM v_ipl_m_with_season
	UNION ALL
	SELECT team2 as team, winner, season
	FROM v_ipl_m_with_season
),
cte2 AS (
	SELECT team, season, COUNT(*) as matches_played,
	SUM(CASE WHEN team = winner THEN 1 ELSE 0 END) AS matches_won
	FROM cte
	GROUP BY team, season
	ORDER BY team, season
)
SELECT *, ROUND(CAST(win_count AS DECIMAL)/played_count * 100, 5) AS win_percentage
FROM cte2;

-- Bonus : Display just win_count for each team over seasons.
SELECT winner as team, 
    COUNT(CASE WHEN (season = '2008') THEN winner END) AS "2008",
    COUNT(CASE WHEN (season = '2009') THEN winner END) AS "2009",
    COUNT(CASE WHEN (season = '2010') THEN winner END) AS "2010",
    COUNT(CASE WHEN (season = '2011') THEN winner END) AS "2011",
    COUNT(CASE WHEN (season = '2012') THEN winner END) AS "2012",
    COUNT(CASE WHEN (season = '2013') THEN winner END) AS "2013",
    COUNT(CASE WHEN (season = '2014') THEN winner END) AS "2014",
    COUNT(CASE WHEN (season = '2015') THEN winner END) AS "2015",
    COUNT(CASE WHEN (season = '2016') THEN winner END) AS "2016",
    COUNT(CASE WHEN (season = '2017') THEN winner END) AS "2017",
    COUNT(CASE WHEN (season = '2018') THEN winner END) AS "2018",
    COUNT(CASE WHEN (season = '2019') THEN winner END) AS "2019",
    COUNT(CASE WHEN (season = '2020') THEN winner END) AS "2020"
FROM v_ipl_m_with_season
GROUP BY winner
ORDER BY winner;

-- Preparation : Create a VIEW v_aggregated_ipl_m
CREATE VIEW v_aggregated_ipl_m AS
WITH cte AS (
	SELECT team1 AS team, season, match_type, winner
	FROM v_ipl_m_with_match_type
	UNION ALL 
	SELECT team2 AS team, season, match_type, winner
	FROM v_ipl_m_with_match_type)
SELECT team, season,
COUNT(*) AS matches_played,
SUM(CASE WHEN team = winner THEN 1 ELSE 0 END) AS matches_won,
SUM(CASE WHEN match_type = 'Playoffs' THEN 1 ELSE 0 END) AS playoffs_played,
SUM(CASE WHEN match_type = 'Finals' THEN 1 ELSE 0 END) AS finals_played,
SUM(CASE WHEN match_type = 'Finals' AND team = winner THEN 1 ELSE 0 END) AS finals_won
from cte
GROUP BY team, season
ORDER BY team, season;