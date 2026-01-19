# **Load hoopR NBA team box scores**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_nba_team_box(
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

- tablename:

  The name of the play by play data table within the database

## Value

Returns a tibble

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | integer   |
| season                            | integer   |
| season_type                       | integer   |
| game_date                         | Date      |
| game_date_time                    | POSIXct   |
| team_id                           | integer   |
| team_uid                          | character |
| team_slug                         | character |
| team_location                     | character |
| team_name                         | character |
| team_abbreviation                 | character |
| team_display_name                 | character |
| team_short_display_name           | character |
| team_color                        | character |
| team_alternate_color              | character |
| team_logo                         | character |
| team_home_away                    | character |
| team_score                        | integer   |
| team_winner                       | logical   |
| assists                           | integer   |
| blocks                            | integer   |
| defensive_rebounds                | integer   |
| fast_break_points                 | character |
| field_goal_pct                    | numeric   |
| field_goals_made                  | integer   |
| field_goals_attempted             | integer   |
| flagrant_fouls                    | integer   |
| fouls                             | integer   |
| free_throw_pct                    | numeric   |
| free_throws_made                  | integer   |
| free_throws_attempted             | integer   |
| largest_lead                      | character |
| offensive_rebounds                | integer   |
| points_in_paint                   | character |
| steals                            | integer   |
| team_turnovers                    | integer   |
| technical_fouls                   | integer   |
| three_point_field_goal_pct        | numeric   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| total_rebounds                    | integer   |
| total_technical_fouls             | integer   |
| total_turnovers                   | integer   |
| turnover_points                   | character |
| turnovers                         | integer   |
| opponent_team_id                  | integer   |
| opponent_team_uid                 | character |
| opponent_team_slug                | character |
| opponent_team_location            | character |
| opponent_team_name                | character |
| opponent_team_abbreviation        | character |
| opponent_team_display_name        | character |
| opponent_team_short_display_name  | character |
| opponent_team_color               | character |
| opponent_team_alternate_color     | character |
| opponent_team_logo                | character |
| opponent_team_score               | integer   |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md)

## Examples

``` r
# \donttest{
  load_nba_team_box(seasons = most_recent_nba_season())
#> ── ESPN NBA Team Boxscores from hoopR data repository ─────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-17 12:28:51 UTC
#> # A tibble: 1,236 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401810447   2026           2 2026-01-16 2026-01-16 22:00:00      27 s:40~l:4…
#>  2 401810447   2026           2 2026-01-16 2026-01-16 22:00:00      23 s:40~l:4…
#>  3 401810446   2026           2 2026-01-16 2026-01-16 21:30:00      16 s:40~l:4…
#>  4 401810446   2026           2 2026-01-16 2026-01-16 21:30:00      10 s:40~l:4…
#>  5 401810442   2026           2 2026-01-16 2026-01-16 19:30:00       4 s:40~l:4…
#>  6 401810442   2026           2 2026-01-16 2026-01-16 19:30:00      17 s:40~l:4…
#>  7 401810445   2026           2 2026-01-16 2026-01-16 19:30:00      12 s:40~l:4…
#>  8 401810445   2026           2 2026-01-16 2026-01-16 19:30:00      28 s:40~l:4…
#>  9 401810443   2026           2 2026-01-16 2026-01-16 19:00:00       3 s:40~l:4…
#> 10 401810443   2026           2 2026-01-16 2026-01-16 19:00:00      11 s:40~l:4…
#> # ℹ 1,226 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
```
