-- Problem 10 : Get a wide column view of win_percentage of teams over season
WITH cte AS (
    SELECT *, ROUND(CAST(matches_won AS DECIMAL)/matches_played * 100, 2) AS win_percentage
	FROM v_aggregated_ipl_m
)
SELECT team,
    SUM(CASE WHEN (season = '2008') THEN win_percentage ELSE 0 END) AS "2008",
    SUM(CASE WHEN (season = '2009') THEN win_percentage ELSE 0 END) AS "2009",
    SUM(CASE WHEN (season = '2010') THEN win_percentage ELSE 0 END) AS "2010",
    SUM(CASE WHEN (season = '2011') THEN win_percentage ELSE 0 END) AS "2011",
    SUM(CASE WHEN (season = '2012') THEN win_percentage ELSE 0 END) AS "2012",
    SUM(CASE WHEN (season = '2013') THEN win_percentage ELSE 0 END) AS "2013",
    SUM(CASE WHEN (season = '2014') THEN win_percentage ELSE 0 END) AS "2014",
    SUM(CASE WHEN (season = '2015') THEN win_percentage ELSE 0 END) AS "2015",
    SUM(CASE WHEN (season = '2016') THEN win_percentage ELSE 0 END) AS "2016",
    SUM(CASE WHEN (season = '2017') THEN win_percentage ELSE 0 END) AS "2017",
    SUM(CASE WHEN (season = '2018') THEN win_percentage ELSE 0 END) AS "2018",
    SUM(CASE WHEN (season = '2019') THEN win_percentage ELSE 0 END) AS "2019",
    SUM(CASE WHEN (season = '2020') THEN win_percentage ELSE 0 END) AS "2020"
FROM cte
GROUP BY team
ORDER BY team;

-- Bonus : Get Performance improvement/detorioration over last season
WITH cte AS (
	SELECT *, ROUND(CAST(matches_won AS DECIMAL)/matches_played * 100, 2) AS win_percentage
	FROM v_aggregated_ipl_m
),
cte2 AS (
    SELECT team, season, win_percentage,
        LAG(win_percentage, 1) OVER (PARTITION BY team ORDER BY team, season) as last_season_win_percentage
    FROM cte),
cte3 AS (
	SELECT team, season, win_percentage - last_season_win_percentage AS performance_measure
	FROM cte2
)
SELECT team,
    SUM(CASE WHEN (season = '2008') THEN performance_measure ELSE 0 END) AS "2008",
    SUM(CASE WHEN (season = '2009') THEN performance_measure ELSE 0 END) AS "2009",
    SUM(CASE WHEN (season = '2010') THEN performance_measure ELSE 0 END) AS "2010",
    SUM(CASE WHEN (season = '2011') THEN performance_measure ELSE 0 END) AS "2011",
    SUM(CASE WHEN (season = '2012') THEN performance_measure ELSE 0 END) AS "2012",
    SUM(CASE WHEN (season = '2013') THEN performance_measure ELSE 0 END) AS "2013",
    SUM(CASE WHEN (season = '2014') THEN performance_measure ELSE 0 END) AS "2014",
    SUM(CASE WHEN (season = '2015') THEN performance_measure ELSE 0 END) AS "2015",
    SUM(CASE WHEN (season = '2016') THEN performance_measure ELSE 0 END) AS "2016",
    SUM(CASE WHEN (season = '2017') THEN performance_measure ELSE 0 END) AS "2017",
    SUM(CASE WHEN (season = '2018') THEN performance_measure ELSE 0 END) AS "2018",
    SUM(CASE WHEN (season = '2019') THEN performance_measure ELSE 0 END) AS "2019",
    SUM(CASE WHEN (season = '2020') THEN performance_measure ELSE 0 END) AS "2020"
FROM cte3
GROUP BY team
ORDER BY team;

-- Bonus : Get Performance improvement/detorioration over each team's AVG performance
WITH cte AS (
	SELECT *, ROUND(CAST(matches_won AS DECIMAL)/matches_played * 100, 2) AS win_percentage
	FROM v_aggregated_ipl_m
),
cte2 AS (
    SELECT team, season, win_percentage,
        AVG(win_percentage) OVER (PARTITION BY team) as average_win_percentage
    FROM cte
),
cte3 AS (
	SELECT team, season, win_percentage - average_win_percentage AS performance_measure
	FROM cte2
)
SELECT team,
    SUM(CASE WHEN (season = '2008') THEN performance_measure ELSE 0 END) AS "2008",
    SUM(CASE WHEN (season = '2009') THEN performance_measure ELSE 0 END) AS "2009",
    SUM(CASE WHEN (season = '2010') THEN performance_measure ELSE 0 END) AS "2010",
    SUM(CASE WHEN (season = '2011') THEN performance_measure ELSE 0 END) AS "2011",
    SUM(CASE WHEN (season = '2012') THEN performance_measure ELSE 0 END) AS "2012",
    SUM(CASE WHEN (season = '2013') THEN performance_measure ELSE 0 END) AS "2013",
    SUM(CASE WHEN (season = '2014') THEN performance_measure ELSE 0 END) AS "2014",
    SUM(CASE WHEN (season = '2015') THEN performance_measure ELSE 0 END) AS "2015",
    SUM(CASE WHEN (season = '2016') THEN performance_measure ELSE 0 END) AS "2016",
    SUM(CASE WHEN (season = '2017') THEN performance_measure ELSE 0 END) AS "2017",
    SUM(CASE WHEN (season = '2018') THEN performance_measure ELSE 0 END) AS "2018",
    SUM(CASE WHEN (season = '2019') THEN performance_measure ELSE 0 END) AS "2019",
    SUM(CASE WHEN (season = '2020') THEN performance_measure ELSE 0 END) AS "2020"
FROM cte3
GROUP BY team
ORDER BY team;