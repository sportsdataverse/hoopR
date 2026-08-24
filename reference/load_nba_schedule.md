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

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | integer | Id. |
| uid | character | ESPN UID string (universal identifier). |
| date | character | Date in YYYY-MM-DD format. |
| attendance | integer | Reported attendance. |
| time_valid | logical | Time valid. |
| neutral_site | logical | Neutral site. |
| conference_competition | logical | Conference competition. |
| recent | logical | Recent. |
| start_date | character | Start date (YYYY-MM-DD). |
| notes_type | character | Notes type. |
| notes_headline | character | Notes headline. |
| type_id | integer | Type identifier (numeric). |
| type_abbreviation | character | Type abbreviation. |
| venue_id | integer | Unique venue identifier. |
| venue_full_name | character | Venue full name. |
| venue_address_city | character | Venue address city. |
| venue_capacity | integer | Venue seating capacity. |
| venue_indoor | logical | TRUE if the venue is indoors. |
| status_clock | integer | Status clock. |
| status_display_clock | character | Status display clock. |
| status_period | integer | Status period. |
| status_type_id | integer | Unique identifier for status type. |
| status_type_name | character | Status type name. |
| status_type_state | character | Status type state. |
| status_type_completed | logical | Status type completed. |
| status_type_description | character | Status type description. |
| status_type_detail | character | Status type detail. |
| status_type_short_detail | character | Status type short detail. |
| format_regulation_periods | integer | Format regulation periods. |
| home_id | integer | Unique identifier for home. |
| home_uid | character | Home team's uid. |
| home_location | character | Home team's location. |
| home_name | character | Home name. |
| home_abbreviation | character | Home team's abbreviation. |
| home_display_name | character | Home display name. |
| home_short_display_name | character | Home short display name. |
| home_color | character | Color code (hex) for home. |
| home_alternate_color | character | Color code (hex) for home alternate. |
| home_is_active | logical | Home team's is active. |
| home_venue_id | integer | Unique identifier for home venue. |
| home_logo | character | Home team logo URL. |
| home_score | integer | Home team score at the time of the play. |
| home_winner | logical | Home team's winner. |
| away_id | integer | Unique identifier for away. |
| away_uid | character | Away team's uid. |
| away_location | character | Away team's location. |
| away_name | character | Away name. |
| away_abbreviation | character | Away team's abbreviation. |
| away_display_name | character | Away display name. |
| away_short_display_name | character | Away short display name. |
| away_color | character | Color code (hex) for away. |
| away_alternate_color | character | Color code (hex) for away alternate. |
| away_is_active | logical | Away team's is active. |
| away_venue_id | integer | Unique identifier for away venue. |
| away_logo | character | Away team logo URL. |
| away_score | integer | Away team score at the time of the play. |
| away_winner | logical | Away team's winner. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| venue_address_state | character | Venue address state / region. |
| status_type_alt_detail | character | Status type alt detail. |
| PBP | logical |  |
| team_box | logical | Team box. |
| player_box | logical | Player box. |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| game_date | Date | Game date (YYYY-MM-DD). |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md),
[`load_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_box.md),
[`load_mbb_schedule()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule.md),
[`load_mbb_shots()`](https://hoopR.sportsdataverse.org/reference/load_mbb_shots.md),
[`load_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_box.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md),
[`load_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_player_box.md),
[`load_nba_shots()`](https://hoopR.sportsdataverse.org/reference/load_nba_shots.md),
[`load_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_box.md)

## Examples

``` r
# \donttest{
load_nba_schedule(seasons = most_recent_nba_season())
#> ── ESPN NBA schedules from hoopR data repository ──────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-12 06:00:11 UTC
#> # A tibble: 1,330 × 77
#>         id uid   date  attendance time_valid neutral_site conference_competition
#>      <int> <chr> <chr>      <dbl> <lgl>      <lgl>        <lgl>                 
#>  1  4.02e8 s:40… 2026…      18984 TRUE       FALSE        FALSE                 
#>  2  4.02e8 s:40… 2026…      19812 TRUE       FALSE        FALSE                 
#>  3  4.02e8 s:40… 2026…      19812 TRUE       FALSE        FALSE                 
#>  4  4.02e8 s:40… 2026…      19014 TRUE       FALSE        FALSE                 
#>  5  4.02e8 s:40… 2026…      18835 TRUE       FALSE        FALSE                 
#>  6  4.02e8 s:40… 2026…      18203 TRUE       FALSE        FALSE                 
#>  7  4.02e8 s:40… 2026…      19066 TRUE       FALSE        FALSE                 
#>  8  4.02e8 s:40… 2026…      18203 TRUE       FALSE        FALSE                 
#>  9  4.02e8 s:40… 2026…      19432 TRUE       FALSE        FALSE                 
#> 10  4.02e8 s:40… 2026…      19405 TRUE       FALSE        FALSE                 
#> # ℹ 1,320 more rows
#> # ℹ 70 more variables: play_by_play_available <lgl>, recent <lgl>,
#> #   start_date <chr>, broadcast <chr>, highlights <chr>, notes_type <chr>,
#> #   notes_headline <chr>, broadcast_market <chr>, broadcast_name <chr>,
#> #   type_id <int>, type_abbreviation <chr>, venue_id <int>,
#> #   venue_full_name <chr>, venue_address_city <chr>, venue_indoor <lgl>,
#> #   status_clock <dbl>, status_display_clock <chr>, status_period <dbl>, …
# }
```
