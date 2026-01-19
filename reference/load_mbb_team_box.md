# **Load hoopR men's college basketball team box scores**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_mbb_team_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given men's college
  basketball seasons. (Min: 2003)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by

- tablename:

  The name of the play by play data table within the database

## Value

Returns a tibble

|                                                                |           |
|----------------------------------------------------------------|-----------|
| col_name                                                       | types     |
| team_id                                                        | character |
| team_uid                                                       | character |
| team_slug                                                      | character |
| team_location                                                  | character |
| team_name                                                      | character |
| team_abbreviation                                              | character |
| team_display_name                                              | character |
| team_short_display_name                                        | character |
| team_color                                                     | character |
| team_alternate_color                                           | character |
| team_logo                                                      | character |
| field_goals_made_field_goals_attempted                         | character |
| field_goal_pct                                                 | character |
| three_point_field_goals_made_three_point_field_goals_attempted | character |
| three_point_field_goal_pct                                     | character |
| free_throws_made_free_throws_attempted                         | character |
| free_throw_pct                                                 | character |
| total_rebounds                                                 | character |
| offensive_rebounds                                             | character |
| defensive_rebounds                                             | character |
| assists                                                        | character |
| steals                                                         | character |
| blocks                                                         | character |
| turnovers                                                      | character |
| team_turnovers                                                 | character |
| total_turnovers                                                | character |
| technical_fouls                                                | character |
| total_technical_fouls                                          | character |
| flagrant_fouls                                                 | character |
| fouls                                                          | character |
| largest_lead                                                   | character |
| home_away                                                      | character |
| opponent_id                                                    | integer   |
| opponent_name                                                  | character |
| opponent_mascot                                                | character |
| opponent_abbrev                                                | character |
| game_id                                                        | integer   |
| season                                                         | integer   |
| season_type                                                    | integer   |
| game_date                                                      | Date      |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_team_box(seasons = most_recent_mbb_season())
#> ── ESPN MBB Team Boxscores from hoopR data repository ─────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 11:34:40 UTC
#> # A tibble: 7,294 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401829207   2026           2 2026-01-18 2026-01-18 19:00:00     265 s:40~l:4…
#>  2 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    2539 s:40~l:4…
#>  3 401827631   2026           2 2026-01-18 2026-01-18 18:30:00       9 s:40~l:4…
#>  4 401827631   2026           2 2026-01-18 2026-01-18 18:30:00     248 s:40~l:4…
#>  5 401828182   2026           2 2026-01-18 2026-01-18 18:00:00    2636 s:40~l:4…
#>  6 401828182   2026           2 2026-01-18 2026-01-18 18:00:00     235 s:40~l:4…
#>  7 401828183   2026           2 2026-01-18 2026-01-18 17:00:00     249 s:40~l:4…
#>  8 401828183   2026           2 2026-01-18 2026-01-18 17:00:00    2655 s:40~l:4…
#>  9 401843145   2026           2 2026-01-18 2026-01-18 15:00:00    2070 s:40~l:4…
#> 10 401843145   2026           2 2026-01-18 2026-01-18 15:00:00    2197 s:40~l:4…
#> # ℹ 7,284 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
```
