-- Problem 8 : Get league and playoffs (semi-finals and finals) for a given season
CREATE VIEW v_ipl_m_with_match_type AS
    WITH temp_cte AS 
    (
        SELECT *, 
        row_number() OVER (
            PARTITION BY season 
            ORDER BY date DESC
            ) AS rn
        FROM v_ipl_m_with_season
    )
    SELECT id, match_id, city, date, player_of_match, venue, neutral_venue, team1, team2, toss_winner, toss_decision, winner, result, result_margin, eliminator, method, umpire1, umpire2, season,
    CASE 
        WHEN (rn = 1) THEN 'Finals'
        WHEN ((season >= 2010 AND rn < 5) OR (season < 2010 AND rn < 4)) THEN 'Playoffs'
        ELSE 'League'
    END AS match_type
    FROM temp_cte
    ORDER BY date;

-- Bonus : Get number of times each team has reached playoffs, finals and actually gone ahead and won finals
WITH cte AS (
	SELECT team1 AS team, match_type, winner
	FROM v_ipl_m_with_match_type
	UNION ALL 
	SELECT team2 AS team, match_type, winner
	FROM v_ipl_m_with_match_type)
SELECT team, 
SUM(CASE WHEN match_type = 'Playoffs' THEN 1 ELSE 0 END) AS playoffs_reached,
SUM(CASE WHEN match_type = 'Finals' THEN 1 ELSE 0 END) AS finals_reached,
SUM(CASE WHEN match_type = 'Finals' AND team = winner THEN 1 ELSE 0 END) AS finals_won
from cte
GROUP BY team
ORDER BY playoffs_reached DESC, finals_reached DESC;