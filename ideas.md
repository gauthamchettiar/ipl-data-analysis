
# Schemas
# Table of all matches from 2008-2020 - `ipl_m`
|     Column      |         Type          | Collation | Nullable | Default 
|-----------------|-----------------------|-----------|----------|---------|
 id              | integer               |           | not null | 
 match_id        | integer               |           | not null | 
 city            | character varying(20) |           | not null | 
 date            | date                  |           | not null | 
 player_of_match | character varying(50) |           |          | 
 venue           | character varying(75) |           | not null | 
 neutral_venue   | boolean               |           | not null | 
 team1           | character varying(50) |           | not null | 
 team2           | character varying(50) |           | not null | 
 toss_winner     | character varying(50) |           | not null | 
 toss_decision   | character varying(5)  |           | not null | 
 winner          | character varying(50) |           |          | 
 result          | character varying(10) |           |          | 
 result_margin   | double precision      |           |          | 
 eliminator      | character(1)          |           | not null | 
 method          | character varying(3)  |           |          | 
 umpire1         | character varying(50) |           |          | 
 umpire2         | character varying(50) |           |          | 


# Ideas
## Clean missing/Dirty data

## Ideas using only `ipl_m` table:
### Level 1 
1. Get Number of Seasons
2. Get all Teams Participated For a Given Season
3. Get the team who won the Most number of times
4. Get the biggest margin of a win by runs for each teams
5. Get the luckiest team who won the most number of tosses
6. Get the count of bat/field toss_decision for every venue
7. Get all thriller matches, matches won with less than 2 wickets or less than 4 runs
8. Get the Final match of a Given Season
9. Get the final matches of each Season
10. Get League and PlayOffs (Semi-Finals and Finals) for a Given Season 
11. 

### Level 2 
1. Get the team and total matches played by each teams
2. Get the team, total matches played and total matches won by each teams (overall league)
3. Get the team, total matches played and total matches won by each teams (each season)
4. Get the number of times each team qualified and has won finals
5. Get the best season for each team (season with maxium win percentage)
6. Get the best season for each team (above table + did that team win that season?)
7. Get the % of wins on homeground, away and neutral venues.
8. Get the team who has reached top 4 most each season
9.  Get Points table at the end of Stage matches for any given season
10. Create a Visitor vs Home Team table for a given season