-- below SQL can be run on psql shell (spawned within this directory) directly by using 
--      \i prepare/create_tables.sql
-- same can also be run using pgAdmin UI by copy pasting below code over there.

DROP TABLE  IF EXISTS ipl_m CASCADE;

CREATE TABLE ipl_m (
    id integer PRIMARY KEY,
    match_id integer UNIQUE NOT NULL,
    city VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    player_of_match VARCHAR(50),
    venue VARCHAR(75) NOT NULL,
    neutral_venue BOOLEAN NOT NULL,
    team1 VARCHAR(50) NOT NULL,
    team2 VARCHAR(50) NOT NULL,
    toss_winner VARCHAR(50) NOT NULL,
    toss_decision VARCHAR(5) NOT NULL,
    winner VARCHAR(50),
    result VARCHAR(10),
    result_margin float,
    eliminator CHAR(1) NOT NULL,
    method VARCHAR(3),
    umpire1 VARCHAR(50),
    umpire2 VARCHAR(50)
);

DROP TABLE  IF EXISTS ipl_byb CASCADE;

CREATE TABLE ipl_byb (
    id integer PRIMARY KEY,
    match_id integer NOT NULL REFERENCES ipl_m (match_id),
    inning SMALLINT NOT NULL,
    over SMALLINT NOT NULL,
    ball SMALLINT  NOT NULL,
    batsman VARCHAR(50) NOT NULL,
    non_striker VARCHAR(50) NOT NULL,
    bowler VARCHAR(50) NOT NULL,
    batsman_runs SMALLINT NOT NULL,
    extra_runs SMALLINT NOT NULL,
    total_runs SMALLINT NOT NULL,
    non_boundary BOOLEAN NOT NULL,
    is_wicket BOOLEAN NOT NULL,
    dismissal_kind VARCHAR(30),
    player_dismissed VARCHAR(50),
    fielder VARCHAR(50),
    extras_type VARCHAR(10),
    batting_team VARCHAR(50) NOT NULL,
    bowling_team VARCHAR(50) NOT NULL
);