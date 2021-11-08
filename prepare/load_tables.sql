COPY ipl_byb(
    id,
    match_id, 
    inning, 
    over, 
    ball, 
    batsman,
    non_striker,
    bowler, 
    batsman_runs, 
    extra_runs,
    total_runs,
    non_boundary,
    is_wicket,
    dismissal_kind,
    player_dismissed,
    fielder,
    extras_type,
    batting_team,
    bowling_team
    )
FROM '/home/gautham/sql_projects/ipl/data/ipl_byb_2008-2020.csv'
DELIMITER ','
CSV HEADER;


COPY ipl_m(
    id,
    match_id, 
    city, 
    date, 
    player_of_match, 
    venue,
    neutral_venue,
    team1, 
    team2, 
    toss_winner,
    toss_decision,
    winner,
    result,
    result_margin,
    eliminator,
    method,
    umpire1,
    umpire2
    )
FROM '/home/gautham/sql_projects/ipl/data/ipl_m_2008-2020.csv'
DELIMITER ','
CSV HEADER;
