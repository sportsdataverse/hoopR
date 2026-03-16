# **Load hoopR men's college basketball schedule**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

## Usage

``` r
load_mbb_schedule(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years associated with given men's college
  basketball seasons. (Min: 2002)

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
| type_id                   | character |
| type_abbreviation         | character |
| venue_id                  | character |
| venue_full_name           | character |
| venue_address_city        | character |
| venue_address_state       | character |
| venue_capacity            | integer   |
| venue_indoor              | logical   |
| status_clock              | numeric   |
| status_display_clock      | character |
| status_period             | integer   |
| status_type_id            | character |
| status_type_name          | character |
| status_type_state         | character |
| status_type_completed     | logical   |
| status_type_description   | character |
| status_type_detail        | character |
| status_type_short_detail  | character |
| format_regulation_periods | integer   |
| home_id                   | character |
| home_uid                  | character |
| home_location             | character |
| home_name                 | character |
| home_abbreviation         | character |
| home_display_name         | character |
| home_short_display_name   | character |
| home_color                | character |
| home_alternate_color      | character |
| home_is_active            | logical   |
| home_venue_id             | character |
| home_logo                 | character |
| home_conference_id        | character |
| home_score                | character |
| home_winner               | logical   |
| away_id                   | character |
| away_uid                  | character |
| away_location             | character |
| away_name                 | character |
| away_abbreviation         | character |
| away_display_name         | character |
| away_short_display_name   | character |
| away_color                | character |
| away_alternate_color      | character |
| away_is_active            | logical   |
| away_venue_id             | character |
| away_logo                 | character |
| away_conference_id        | character |
| away_score                | character |
| away_winner               | logical   |
| game_id                   | integer   |
| season                    | integer   |
| season_type               | integer   |
| status_type_alt_detail    | character |
| groups_id                 | character |
| groups_name               | character |
| groups_short_name         | character |
| groups_is_conference      | logical   |
| tournament_id             | numeric   |
| game_date_time            | POSIXct   |
| game_date                 | Date      |
| PBP                       | logical   |
| team_box                  | logical   |
| player_box                | logical   |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_schedule()`](https://hoopR.sportsdataverse.org/reference/load_nba_schedule.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_mbb_schedule(seasons = most_recent_mbb_season())
#> ── ESPN MBB Schedule from hoopR data repository ───────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-07 12:43:15 UTC
#> # A tibble: 6,333 × 86
#>         id uid   date  attendance time_valid neutral_site conference_competition
#>      <int> <chr> <chr>      <dbl> <lgl>      <lgl>        <lgl>                 
#>  1  4.02e8 s:40… 2026…          0 FALSE      TRUE         FALSE                 
#>  2  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#>  3  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#>  4  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#>  5  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#>  6  4.02e8 s:40… 2026…          0 FALSE      TRUE         FALSE                 
#>  7  4.02e8 s:40… 2026…          0 FALSE      TRUE         FALSE                 
#>  8  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#>  9  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#> 10  4.02e8 s:40… 2026…          0 TRUE       TRUE         FALSE                 
#> # ℹ 6,323 more rows
#> # ℹ 79 more variables: play_by_play_available <lgl>, recent <lgl>,
#> #   start_date <chr>, broadcast <chr>, highlights <chr>, notes_type <chr>,
#> #   notes_headline <chr>, broadcast_market <chr>, broadcast_name <chr>,
#> #   type_id <int>, type_abbreviation <chr>, venue_id <int>,
#> #   venue_full_name <chr>, venue_address_city <chr>, venue_address_state <chr>,
#> #   venue_indoor <lgl>, status_clock <dbl>, status_display_clock <chr>, …
# }
```
