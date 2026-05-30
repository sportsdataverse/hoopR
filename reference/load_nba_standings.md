# **Load hoopR NBA standings**

helper that loads multiple seasons of ESPN NBA standings from the
sportsdataverse-data release repo (tidy long format: one row per
team-per-stat), either into memory or into a database via forwarded
arguments in the dots.

## Usage

``` r
load_nba_standings(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons. (Min:
  2002)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_nba_db()`](https://hoopR.sportsdataverse.org/reference/update_nba_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html).

- tablename:

  The name of the standings data table within the database.

## Value

Returns a tibble of per-season NBA standings.
