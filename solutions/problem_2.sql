-- Problem 2 : Get all teams who participated for a given season
-- set the preferred season
\set season 2008

-- get a list of teams from that season
SELECT DISTINCT team1 
FROM ipl_m 
WHERE EXTRACT(YEAR FROM date) = :'season';

-- Bonus : 