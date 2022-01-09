-- Problem 3 : Get the team who won the most number of times
-- below query works just fine, but...
SELECT winner as team, COUNT(winner) as win_count 
FROM ipl_m 
GROUP BY winner 
ORDER BY COUNT(winner) DESC;
-- it does not count null values (matches which were a draw)
-- you may do the below query instead, which will also count null values
SELECT winner AS team, COUNT(*) AS win_count 
FROM ipl_m 
GROUP BY winner 
ORDER BY COUNT(*) DESC;

-- Bonus : retrieve win_count by team per season
SELECT winner AS team, season, COUNT(*) AS win_count 
FROM v_ipl_m_with_season 
GROUP BY winner, season;