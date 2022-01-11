# ipl-data-analysis
Solutions for IPL Datset Analysis.

Companion for blog : [https://www.gauthamchettiar.com/p006-ipl-data-analysis](https://www.gauthamchettiar.com/p006-ipl-data-analysis)

## Browsing Repo
1. [prepare/create_tables.sql](/prepare/create_tables.sql) - code for creating tables.
2. [prepare/load_tables.sql](prepare/load_tables.sql) - code for loading data into tables.
3. [data/](/data/) - contains ipl-dataset from 2008 till 2020
4. [solutions/](/solutions) - contains solutions to all problems provided in blog.

## Create a new database
```bash
cd ipl-data-analysis/
# login with default database
psql postgres
# create a new database called ipl-data-analysis
CREATE DATABASE ipl-data-analysis;
# logout from psql shell
\q
```

## Creating Required Tables (using commandline)
```bash
# login with new instance of psql into newly created database
psql ipl-data-analysis
\i prepare/create_tables.sql
\dt
\q
```

## Loading data into created tables
Search for paths in ./prepare/load_tables.sql and provide full path of project.
```bash
# login with new instance of psql into newly created database
psql ipl-data-analysis
\i prepare/load_tables.sql
SELECT * FROM ipl_m;
SELECT * FROM ipl_byb;
\q
```