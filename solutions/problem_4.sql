-- Problem 4 : Get teams and maximum run margins for each team
-- this will return overall max runs
SELECT winner AS team, max(result_margin) 
FROM ipl_m 
GROUP BY winner 
ORDER BY runs_margin DESC;
-- now result_margin includes both matches won by wicket and runs
-- so as to filter just the matches won by runs, you must do as follows
SELECT winner AS team, max(result_margin) AS runs_margin 
FROM ipl_m 
WHERE result = 'runs' 
GROUP BY winner 
ORDER BY runs_margin DESC;

-- Bonus : Get teams and minimum wicket margins for matches
SELECT winner AS team, MIN(result_margin) AS wickets_margin 
FROM ipl_m 
WHERE result = 'wickets' 
GROUP BY winner 
HAVING MIN(result_margin) <= 3
ORDER BY wickets_margin ASC;