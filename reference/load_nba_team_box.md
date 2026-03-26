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
#> ── ESPN NBA Team Boxscores from hoopR data repository ─────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-26 11:45:26 UTC
#> # A tibble: 2,192 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401810906   2026           2 2026-03-25 2026-03-25 19:00:00       1 s:40~l:4…
#>  2 401810906   2026           2 2026-03-25 2026-03-25 19:00:00       8 s:40~l:4…
#>  3 401810907   2026           2 2026-03-25 2026-03-25 19:00:00      13 s:40~l:4…
#>  4 401810907   2026           2 2026-03-25 2026-03-25 19:00:00      11 s:40~l:4…
#>  5 401810908   2026           2 2026-03-25 2026-03-25 19:00:00       4 s:40~l:4…
#>  6 401810908   2026           2 2026-03-25 2026-03-25 19:00:00      20 s:40~l:4…
#>  7 401810909   2026           2 2026-03-25 2026-03-25 19:30:00      25 s:40~l:4…
#>  8 401810909   2026           2 2026-03-25 2026-03-25 19:30:00       2 s:40~l:4…
#>  9 401810910   2026           2 2026-03-25 2026-03-25 19:30:00      14 s:40~l:4…
#> 10 401810910   2026           2 2026-03-25 2026-03-25 19:30:00       5 s:40~l:4…
#> # ℹ 2,182 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
```
