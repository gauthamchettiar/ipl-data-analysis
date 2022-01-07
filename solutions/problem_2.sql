-- Problem 2 : Get all teams who participated for a given season
-- set the preferred season
\set season 2008

-- get a list of teams from that season
SELECT DISTINCT team1 
FROM v_ipl_m_with_season 
WHERE season = :'season';

-- Bonus : get team count in each season
SELECT season, COUNT(DISTINCT team1) AS team_count 
FROM v_ipl_m_with_season
GROUP BY season;