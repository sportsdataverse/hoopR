# **Load hoopR men's college basketball player box scores**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_mbb_player_box(
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

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | integer   |
| season                            | integer   |
| season_type                       | integer   |
| game_date                         | Date      |
| game_date_time                    | POSIXct   |
| athlete_id                        | integer   |
| athlete_display_name              | character |
| team_id                           | integer   |
| team_name                         | character |
| team_location                     | character |
| team_short_display_name           | character |
| minutes                           | numeric   |
| field_goals_made                  | integer   |
| field_goals_attempted             | integer   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| free_throws_made                  | integer   |
| free_throws_attempted             | integer   |
| offensive_rebounds                | integer   |
| defensive_rebounds                | integer   |
| rebounds                          | integer   |
| assists                           | integer   |
| steals                            | integer   |
| blocks                            | integer   |
| turnovers                         | integer   |
| fouls                             | integer   |
| points                            | integer   |
| starter                           | logical   |
| ejected                           | logical   |
| did_not_play                      | logical   |
| active                            | logical   |
| athlete_jersey                    | character |
| athlete_short_name                | character |
| athlete_headshot_href             | character |
| athlete_position_name             | character |
| athlete_position_abbreviation     | character |
| team_display_name                 | character |
| team_uid                          | character |
| team_slug                         | character |
| team_logo                         | character |
| team_abbreviation                 | character |
| team_color                        | character |
| team_alternate_color              | character |
| home_away                         | character |
| team_winner                       | logical   |
| team_score                        | integer   |
| opponent_team_id                  | integer   |
| opponent_team_name                | character |
| opponent_team_location            | character |
| opponent_team_display_name        | character |
| opponent_team_abbreviation        | character |
| opponent_team_logo                | character |
| opponent_team_color               | character |
| opponent_team_alternate_color     | character |
| opponent_team_score               | integer   |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_player_box(seasons = most_recent_mbb_season())
#> ── ESPN MBB Player Boxscores from hoopR data repository ───────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 11:40:45 UTC
#> # A tibble: 114,626 × 55
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5175078
#>  2 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5105588
#>  3 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5313054
#>  4 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5313053
#>  5 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5177358
#>  6 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5241593
#>  7 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5195304
#>  8 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5117606
#>  9 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5313055
#> 10 401829207   2026           2 2026-01-18 2026-01-18 19:00:00    5177139
#> # ℹ 114,616 more rows
#> # ℹ 49 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
```
