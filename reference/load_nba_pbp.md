# **Load hoopR NBA play-by-play**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_nba_pbp(
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

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| id                              | numeric   |
| sequence_number                 | character |
| type_id                         | integer   |
| type_text                       | character |
| text                            | character |
| away_score                      | integer   |
| home_score                      | integer   |
| period_number                   | integer   |
| period_display_value            | character |
| clock_display_value             | character |
| scoring_play                    | logical   |
| score_value                     | integer   |
| team_id                         | integer   |
| athlete_id_1                    | integer   |
| athlete_id_2                    | integer   |
| athlete_id_3                    | integer   |
| wallclock                       | character |
| shooting_play                   | logical   |
| coordinate_x_raw                | numeric   |
| coordinate_y_raw                | numeric   |
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
| clock_minutes                   | integer   |
| clock_seconds                   | numeric   |
| half                            | character |
| game_half                       | character |
| lead_qtr                        | integer   |
| lead_game_half                  | character |
| start_quarter_seconds_remaining | integer   |
| start_half_seconds_remaining    | integer   |
| start_game_seconds_remaining    | integer   |
| game_play_number                | integer   |
| end_quarter_seconds_remaining   | integer   |
| end_half_seconds_remaining      | integer   |
| end_game_seconds_remaining      | integer   |
| period                          | integer   |
| lag_qtr                         | integer   |
| lag_game_half                   | character |
| coordinate_x                    | numeric   |
| coordinate_y                    | numeric   |
| game_date                       | Date      |
| game_date_time                  | POSIXct   |
| type_abbreviation               | character |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_nba_pbp(seasons = most_recent_nba_season())
#> ── ESPN NBA Play-by-Play from hoopR data repository ───────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-25 11:43:11 UTC
#> # A tibble: 525,988 × 64
#>    game_play_number        id sequence_number type_id type_text text  away_score
#>               <int>     <dbl>           <int>   <int> <chr>     <chr>      <int>
#>  1                1   4.02e 9               4     615 Jumpball  Maxi…          0
#>  2                2   4.02e 9               7     130 Floating… Maxi…          2
#>  3                3   4.02e 9               9      95 Layup Sh… Mous…          2
#>  4                4   4.02e10              11     126 Layup Dr… Maxi…          4
#>  5                5   4.02e10              13     118 Alley Oo… Mous…          4
#>  6                6   4.02e10              15      44 Shooting… Bran…          4
#>  7                7   4.02e10              17      98 Free Thr… Maxi…          5
#>  8                8   4.02e10              18      99 Free Thr… Maxi…          6
#>  9                9   4.02e10              21     137 Turnarou… Mile…          6
#> 10               10   4.02e10              22     156 Offensiv… Mous…          6
#> # ℹ 525,978 more rows
#> # ℹ 57 more variables: home_score <int>, period_number <int>,
#> #   period_display_value <chr>, clock_display_value <chr>, scoring_play <lgl>,
#> #   score_value <int>, team_id <int>, athlete_id_1 <int>, athlete_id_2 <int>,
#> #   athlete_id_3 <int>, wallclock <chr>, shooting_play <lgl>,
#> #   coordinate_x_raw <dbl>, coordinate_y_raw <dbl>, points_attempted <int>,
#> #   short_description <chr>, game_id <int>, season <int>, season_type <int>, …
# }
```
