# **Load hoopR NBA schedules**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_nba_schedule(
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

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| id                        | integer   |
| uid                       | character |
| date                      | character |
| attendance                | integer   |
| time_valid                | logical   |
| neutral_site              | logical   |
| conference_competition    | logical   |
| recent                    | logical   |
| start_date                | character |
| notes_type                | character |
| notes_headline            | character |
| type_id                   | integer   |
| type_abbreviation         | character |
| venue_id                  | integer   |
| venue_full_name           | character |
| venue_address_city        | character |
| venue_capacity            | integer   |
| venue_indoor              | logical   |
| status_clock              | integer   |
| status_display_clock      | character |
| status_period             | integer   |
| status_type_id            | integer   |
| status_type_name          | character |
| status_type_state         | character |
| status_type_completed     | logical   |
| status_type_description   | character |
| status_type_detail        | character |
| status_type_short_detail  | character |
| format_regulation_periods | integer   |
| home_id                   | integer   |
| home_uid                  | character |
| home_location             | character |
| home_name                 | character |
| home_abbreviation         | character |
| home_display_name         | character |
| home_short_display_name   | character |
| home_color                | character |
| home_alternate_color      | character |
| home_is_active            | logical   |
| home_venue_id             | integer   |
| home_logo                 | character |
| home_score                | integer   |
| home_winner               | logical   |
| away_id                   | integer   |
| away_uid                  | character |
| away_location             | character |
| away_name                 | character |
| away_abbreviation         | character |
| away_display_name         | character |
| away_short_display_name   | character |
| away_color                | character |
| away_alternate_color      | character |
| away_is_active            | logical   |
| away_venue_id             | integer   |
| away_logo                 | character |
| away_score                | integer   |
| away_winner               | logical   |
| game_id                   | integer   |
| season                    | integer   |
| season_type               | integer   |
| venue_address_state       | character |
| status_type_alt_detail    | character |
| PBP                       | logical   |
| team_box                  | logical   |
| player_box                | logical   |
| game_date_time            | POSIXct   |
| game_date                 | Date      |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
  load_nba_schedule(seasons = most_recent_nba_season())
#> ── ESPN NBA Schedule from hoopR data repository ───────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-17 12:30:03 UTC
#> # A tibble: 1,236 × 77
#>         id uid   date  attendance time_valid neutral_site conference_competition
#>      <int> <chr> <chr>      <dbl> <lgl>      <lgl>        <lgl>                 
#>  1  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  2  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  3  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  4  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  5  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  6  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  7  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  8  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#>  9  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#> 10  4.02e8 s:40… 2026…          0 TRUE       FALSE        FALSE                 
#> # ℹ 1,226 more rows
#> # ℹ 70 more variables: play_by_play_available <lgl>, recent <lgl>,
#> #   start_date <chr>, broadcast <chr>, highlights <chr>, notes_type <chr>,
#> #   notes_headline <chr>, broadcast_market <chr>, broadcast_name <chr>,
#> #   type_id <int>, type_abbreviation <chr>, venue_id <int>,
#> #   venue_full_name <chr>, venue_address_city <chr>, venue_indoor <lgl>,
#> #   status_clock <dbl>, status_display_clock <chr>, status_period <dbl>, …
# }
```
