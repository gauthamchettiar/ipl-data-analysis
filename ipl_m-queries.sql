-- team, played, won and win_percentage (OVERALL)
DROP VIEW IF EXISTS v_win_percentage_overall CASCADE;
CREATE VIEW v_win_percentage_overall AS
    SELECT t1.team1 AS team, c_t1 + c_t2 AS played, c_w AS won, CAST(c_w AS FLOAT) / (c_t1 + c_t2) * 100 AS win_percentage
    FROM 
        (SELECT team1, count(team1) AS c_t1 FROM ipl_m GROUP BY team1) AS t1 
    JOIN 
        (SELECT team2, count(team2) AS c_t2 FROM ipl_m GROUP BY team2) AS t2 
    ON t1.team1 = t2.team2
    JOIN
        (SELECT winner, count(winner) AS c_w FROM ipl_m GROUP BY winner) AS w
    ON t1.team1 = w.winner OR t2.team2 = w.winner
    ORDER BY win_percentage DESC;

-- add season to table
DROP VIEW IF EXISTS v_ipl_m_with_season CASCADE;
CREATE VIEW v_ipl_m_with_season AS 
    SELECT *, EXTRACT(YEAR from date) AS season FROM ipl_m;

-- team, played, won, win_percentage (BY SEASON)
DROP VIEW IF EXISTS v_win_percentage_by_season CASCADE;
CREATE VIEW v_win_percentage_by_season AS
    SELECT t1.season, t1.team1 AS team, c_t1 + c_t2 AS played, c_w AS won, CAST(c_w AS FLOAT) / (c_t1 + c_t2) * 100 AS win_percentage
    FROM 
        (SELECT team1, season, count(team1) AS c_t1 FROM v_ipl_m_with_season GROUP BY team1, season) AS t1 
    JOIN 
        (SELECT team2, season, count(team2) AS c_t2 FROM v_ipl_m_with_season GROUP BY team2, season) AS t2 
    ON t1.team1 = t2.team2 AND t1.season = t2.season 
    JOIN
        (SELECT winner, season,  count(winner) AS c_w FROM v_ipl_m_with_season GROUP BY winner, season) AS w
    ON (t1.team1 = w.winner OR t2.team2 = w.winner) AND t1.season = w.season 
    ORDER BY season, win_percentage DESC;

-- FINALS (Last match) of each Season
DROP VIEW IF EXISTS v_all_finals CASCADE;
CREATE VIEW v_all_finals AS 
    SELECT distinct on (season) *
    FROM v_ipl_m_with_season
    ORDER BY season, date DESC;

-- Number of times won final
DROP VIEW IF EXISTS v_number_of_season_wins CASCADE;
CREATE VIEW v_number_of_season_wins AS
    SELECT coalesce(t1.team1, t2.team2) AS team, coalesce(c_t1, 0) + coalesce(c_t2, 0) AS qualified_for_final, c_w as won
    FROM 
        (SELECT team1, count(team1) AS c_t1 FROM v_all_finals GROUP BY team1) AS t1 
    FULL OUTER JOIN 
        (SELECT team2, count(team2) AS c_t2 FROM v_all_finals GROUP BY team2) AS t2 
    ON t1.team1 = t2.team2
    JOIN
        (SELECT winner, count(winner) AS c_w FROM v_all_finals GROUP BY winner) AS w
    ON t1.team1 = w.winner OR t2.team2 = w.winner
    ORDER BY won DESC;

-- Best Season for each team (season with max win percentage)
DROP VIEW IF EXISTS v_best_seasons_for_teams CASCADE;
CREATE VIEW v_best_seasons_for_teams AS
    SELECT mwp.team, season, played, won, mwp.win_percentage
    FROM v_win_percentage_by_season AS wp
    INNER JOIN (SELECT team, max(win_percentage) as win_percentage from v_win_percentage_by_season GROUP BY team) AS mwp
    ON wp.team = mwp.team and wp.win_percentage = mwp.win_percentage
    ORDER BY mwp.team;


-- Best Season for Each Team, with indicator whether that team won that season
-- SELECT bst.*, bst.team = af.winner as have_won
-- FROM v_best_seasons_for_teams AS bst
-- INNER JOIN v_all_finals AS af
-- ON bst.season = af.season
-- ORDER BY bst.team;

-- toss won, match won percentage (does winning a toss give obvious advantage?)
DROP VIEW IF EXISTS v_ipl_m_with_matchtype CASCADE;
CREATE VIEW v_ipl_m_with_matchtype AS
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
        WHEN ((season >= 2010 AND rn >= 5) OR (season < 2010 AND rn >= 4)) THEN 'League'
    END AS match_type
    FROM temp_cte
    ORDER BY date;