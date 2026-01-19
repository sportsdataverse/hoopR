# **Load hoopR men's college basketball play-by-play**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_mbb_pbp(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given men's college
  basketball seasons. (Min: 2006)

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

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| id                              | numeric   |
| sequence_number                 | character |
| type_id                         | character |
| type_text                       | character |
| text                            | character |
| away_score                      | integer   |
| home_score                      | integer   |
| period_number                   | integer   |
| period_display_value            | character |
| clock_display_value             | character |
| scoring_play                    | logical   |
| score_value                     | integer   |
| team_id                         | character |
| participants_0_athlete_id       | character |
| wallclock                       | character |
| shooting_play                   | logical   |
| participants_1_athlete_id       | character |
| season                          | integer   |
| season_type                     | integer   |
| away_team_id                    | integer   |
| away_team_name                  | character |
| away_team_mascot                | character |
| away_team_abbrev                | character |
| away_team_name_alt              | character |
| home_team_id                    | integer   |
| home_team_name                  | character |
| home_team_mascot                | character |
| home_team_abbrev                | character |
| home_team_name_alt              | character |
| home_team_spread                | numeric   |
| game_spread                     | numeric   |
| home_favorite                   | logical   |
| game_spread_available           | logical   |
| game_id                         | integer   |
| qtr                             | integer   |
| time                            | character |
| clock_minutes                   | character |
| clock_seconds                   | character |
| half                            | character |
| game_half                       | character |
| lag_qtr                         | numeric   |
| lead_qtr                        | numeric   |
| lag_game_half                   | character |
| lead_game_half                  | character |
| start_quarter_seconds_remaining | integer   |
| start_half_seconds_remaining    | integer   |
| start_game_seconds_remaining    | integer   |
| game_play_number                | integer   |
| end_quarter_seconds_remaining   | numeric   |
| end_half_seconds_remaining      | numeric   |
| end_game_seconds_remaining      | numeric   |
| period                          | integer   |
| coordinate_x                    | integer   |
| coordinate_y                    | integer   |
| media_id                        | character |

## See also

Other hoopR Loader Functions:
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_pbp(seasons = most_recent_mbb_season())
#> ── ESPN MBB Play-by-Play from hoopR data repository ───────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 11:28:05 UTC
#> # A tibble: 1,722,062 × 57
#>    game_play_number      id sequence_number type_id type_text   text  away_score
#>               <int>   <dbl>           <int>   <int> <chr>       <chr>      <int>
#>  1                1 4.02e17       117605635     615 Jumpball    "Sta…          0
#>  2                2 4.02e17       117605636     615 Jumpball    "Jum…          0
#>  3                3 4.02e17       117605637     615 Jumpball    "Jum…          0
#>  4                4 4.02e17       117605664     558 JumpShot    "Chr…          0
#>  5                5 4.02e17       117605670     598 Lost Ball … "Noa…          0
#>  6                6 4.02e17       117605672     607 Steal       "Mil…          0
#>  7                7 4.02e17       117605673     574 DunkShot    "Kin…          0
#>  8                8 4.02e17       117605677     558 JumpShot    "Mau…          0
#>  9                9 4.02e17       117605678     587 Defensive … "Kin…          0
#> 10               10 4.02e17       117605686     558 JumpShot    "Chr…          0
#> # ℹ 1,722,052 more rows
#> # ℹ 50 more variables: home_score <int>, period_number <int>,
#> #   period_display_value <chr>, clock_display_value <chr>, scoring_play <lgl>,
#> #   score_value <int>, wallclock <chr>, shooting_play <lgl>,
#> #   coordinate_x_raw <dbl>, coordinate_y_raw <dbl>, points_attempted <int>,
#> #   short_description <chr>, game_id <int>, season <int>, season_type <int>,
#> #   home_team_id <int>, home_team_name <chr>, home_team_mascot <chr>, …
# }
```
