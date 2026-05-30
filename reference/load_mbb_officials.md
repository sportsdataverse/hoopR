# **Load cleaned MBB per-game officials from the data repo**

helper that loads multiple seasons of ESPN men's college basketball
per-game officials from the sportsdataverse-data release repo, either
into memory or into a database via forwarded arguments in the dots.

## Usage

``` r
load_mbb_officials(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given MBB seasons. (Min:
  2002)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html).

- tablename:

  The name of the data table within the database.

## Value

Returns a tibble of MBB per-game officials.
