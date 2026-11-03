# **Build/update hoopR NBA Stats database**

`update_nba_stats_db()` writes one or more NBA Stats API datasets into a
database. Mirrors the NBA / MBB `update_*_db()` shape but points at the
`load_nba_stats_*` family. Each dataset is written to its own table,
named `nba_stats_<dataset>`.

## Usage

``` r
update_nba_stats_db(
  dbdir = tools::R_user_dir("hoopR", "data"),
  dbname = "hoopR_db",
  datasets = NULL,
  seasons = TRUE,
  db_connection = NULL
)
```

## Arguments

- dbdir:

  Directory in which the database is or shall be located. Defaults to
  the per-user data directory `tools::R_user_dir("hoopR", "data")`, so
  nothing is written to the working directory unless you ask for it
  (`dbdir = "."`).

- dbname:

  File name of an existing or desired SQLite database within `dbdir`.

- datasets:

  Character vector of dataset shortnames (see Details).

- seasons:

  Optional integer vector of seasons to load. Defaults to all available
  seasons (`seasons = TRUE`).

- db_connection:

  A `DBIConnection` object. When supplied, `dbdir` and `dbname` are
  ignored.

## Value

Invisibly returns `TRUE` on success.

## Details

Unlike
[`update_nba_db()`](https://hoopR.sportsdataverse.org/reference/update_nba_db.md),
there is no historical "play-by-play table" default to preserve, so
`datasets` is required.

Valid `datasets` values: `"coaches"`, `"draft"`, `"game_lineups"`,
`"game_rosters"`, `"lineups"`, `"officials"`, `"pbp"`,
`"player_boxscores"`, `"player_game_logs"`, `"player_season_stats"`,
`"possessions"`, `"rosters"`, `"schedule"`, `"shots"`, `"standings"`,
`"team_boxscores"`, `"team_season_stats"`.
