1. Get Number of Seasons
```sql
-- to get the count of seasons
SELECT COUNT(DISTINCT EXTRACT(YEAR FROM date)) FROM ipl_m;
-- you may ofcourse drop count function for listing them
SELECT DISTINCT EXTRACT(YEAR FROM date) FROM ipl_m
```
2. Get all Teams Participated For a Given Season
```sql
-- set the preferred season
\set season 2008
-- get a list of teams from that season
SELECT DISTINCT team1 FROM ipl_m WHERE EXTRACT(YEAR FROM date) = :'season';
```
We have already used `EXTRACT(YEAR FROM date)` twice now, I have a feeling it will be useful.
```sql
-- let's create a view out of it!
CREATE VIEW v_ipl_m_with_season AS SELECT *, EXTRACT(YEAR from date) AS season FROM ipl_m;
```
3. Get the team who won the Most number of times
```sql
-- below query works just fine, but...
SELECT winner, COUNT(winner) FROM ipl_m GROUP BY winner ORDER BY COUNT(winner) DESC;
-- it does not count null values (matches which were a draw)
-- if you want to eliminate counting of nulls, you may filter it out
SELECT winner, COUNT(winner) FROM ipl_m GROUP BY winner WHERE winner IS NOT NULL ORDER BY COUNT(winner) DESC;
-- or you may do the below query instead, that would return 
SELECT winner, COUNT(*) FROM ipl_m GROUP BY winner ORDER BY COUNT(*) DESC;
```
4. Get the biggest margin of a win by runs for each teams
```sql
SELECT winner, max(result_margin) FROM ipl_m GROUP BY winner ORDER BY MAX(result_margin) DESC;
-- now result_margin includes both matches won by wicket and runs
-- so as to filter just the matches won by runs, you may
SELECT winner, max(result_margin) FROM ipl_m WHERE result = 'runs' GROUP BY winner ORDER BY MAX(result_margin) DESC;
```
5. Get the luckiest team who won the most number of tosses
```sql
SELECT toss_winner, COUNT(*) FROM ipl_m GROUP BY toss_winner ORDER BY COUNT(*) DESC;
```
6. Get the count of bat/field toss_decision for every venue
```sql
SELECT venue, toss_decision, COUNT(toss_decision) FROM ipl_m GROUP BY venue, toss_decision ORDER BY venue, toss_decision;
```
7. Get all thriller matches, matches won less than 3 wickets or less than 4 runs
```sql
SELECT * FROM ipl_m WHERE (result = 'runs' AND result_margin < 4) OR (result = 'wickets' AND result_margin < 3);
```
8. Get the Final Match of a Given Season
```sql
SELECT * FROM v_ipl_m_with_season WHERE season = :'season' ORDER BY date DESC LIMIT 1;
```
9.  Get the final matches of each season, (use v_ipl_m_with_season since it already has season populated)
```sql
-- postgres way of doing it
SELECT DISTINCT ON (season) * FROM v_ipl_m_with_season ORDER BY season, date DESC;
-- generic way, using cte and window functions
WITH temp_cte AS 
(
    SELECT *, 
    row_number() OVER (
        PARTITION BY season 
        ORDER BY date DESC
        ) AS rn
    FROM v_ipl_m_with_season
)
SELECT id, match_id, city, date, player_of_match, venue, neutral_venue, team1, team2, toss_winner, toss_decision, winner, result, result_margin, eliminator, method, umpire1, umpire2, season
FROM temp_cte
WHERE rn = 1
ORDER BY date;

```
10. Get League and PlayOffs (Semi-Finals and Finals) for a Given Season 
```sql
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
```







```sql
SELECT t.team AS team, COUNT(*) AS played, SUM(t.result) AS won
FROM (
    SELECT winner AS team,1 as result
    FROM ipl_m
    UNION ALL
    SELECT
        CASE
            WHEN team1 = winner THEN team2
            ELSE team1
        END AS team, 
        0 as result
    FROM ipl_m
    ) AS t
GROUP BY t.team
ORDER BY  SUM(t.result);
```