# **Load hoopR NBA play-by-play**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons of ESPN NBA standings from the
sportsdataverse-data release repo (tidy long format: one row per
team-per-stat), either into memory or into a database via forwarded
arguments in the dots.

helper that loads multiple seasons of ESPN NBA per-game rosters from the
sportsdataverse-data release repo, either into memory or into a database
via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN NBA per-game officials from
the sportsdataverse-data release repo, either into memory or into a
database via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN NBA draft results (overall
pick, round, drafted player, and team) from the sportsdataverse-data
release repo, either into memory or into a database via forwarded
arguments in the dots.

helper that loads multiple seasons of ESPN NBA per-player season stats
(averages / totals / miscellaneous categories, long format) from the
sportsdataverse-data release repo, either into memory or into a database
via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN NBA per-team season stats
(general / offensive / defensive categories, long format) from the
sportsdataverse-data release repo, either into memory or into a database
via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN NBA team rosters (one row per
athlete) from the sportsdataverse-data release repo, either into memory
or into a database via forwarded arguments in the dots. NOTE: ESPN's
roster endpoint returns the current roster, so season files are
snapshots as-of-scrape rather than true historical rosters.

helper that loads multiple seasons of ESPN NBA athlete core records –
identity and biographical fields, one row per athlete who appeared in
the season – from the sportsdataverse-data release repo, either into
memory or into a database via forwarded arguments in the dots.

This is the only source of athlete bio in the pipeline: the player
season stats payload carries no identity at all – not even the athlete
id.

Two properties of the source are worth knowing before joining:

- `current_team_id` is the athlete's CURRENT team, not their team in the
  requested season. Season team lives in `load_nba_player_box()` /
  `load_nba_player_stats()`.

- Bio (height / weight / jersey) is a current snapshot that ESPN
  overwrites in place; it is not era-correct for a historical season.
  The season dimension here is participation, not the bio's vintage.

Field coverage is era-dependent by nature – headshots exist only for
modern players, while college and date of birth thin out the other way.

Loads shot events parsed from ESPN NBA play-by-play feeds. One row per
shot attempt (made or missed), with court coordinates and shot metadata.
Backed by the `hoopR-nba-data` pipeline, publishing parquet/rds
artifacts to the `espn_nba_shots` release tag.

## Usage

``` r
load_nba_pbp(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_team_box(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_player_box(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_schedule(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_standings(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_game_rosters(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_officials(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_draft(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_player_stats(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_team_stats(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_rosters(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_player_core(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_shots(
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
| id | numeric | Id. |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score at the time of the play. |
| home_score | integer | Home team score at the time of the play. |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| period_display_value | character | Period display label (e.g. '1st Quarter', 'OT'). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the play (2 / 3 / 1). |
| team_id | integer | Unique team identifier. |
| athlete_id_1 | integer | Primary athlete identifier (e.g. shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| athlete_id_3 | integer | Athlete id 3. |
| wallclock | character | Wallclock. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_mascot | character | Away team mascot. |
| away_team_abbrev | character | Away team three-letter abbreviation. |
| away_team_name_alt | character | Alternate away team name. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_mascot | character | Home team mascot. |
| home_team_abbrev | character | Home team three-letter abbreviation. |
| home_team_name_alt | character | Alternate home team name. |
| home_team_spread | numeric | Home team's point spread. |
| game_spread | numeric | Game spread (signed; positive = home favored). |
| home_favorite | logical | TRUE if the home team is the betting favorite. |
| game_spread_available | logical | TRUE if a point spread was available. |
| game_id | integer | Unique game identifier. |
| qtr | integer | Quarter (1-4) or OT period (5+). |
| time | character | Time / clock value. |
| clock_minutes | integer | Clock minutes split out for convenience. |
| clock_seconds | numeric | Clock seconds split out for convenience. |
| half | character | Half of the game (1 or 2). |
| game_half | character | Half of the game (1 or 2). |
| lead_qtr | integer | Quarter lead (the next-play's quarter). |
| lead_game_half | character | Half lead (the next-play's half). |
| start_quarter_seconds_remaining | integer | Seconds remaining in the period at the start of the play. |
| start_half_seconds_remaining | integer | Seconds remaining in the half at the start of the play. |
| start_game_seconds_remaining | integer | Seconds remaining in the game at the start of the play. |
| game_play_number | integer | Sequential play number within the game. |
| end_quarter_seconds_remaining | integer | Seconds remaining in the period at the end of the play. |
| end_half_seconds_remaining | integer | Seconds remaining in the half at the end of the play. |
| end_game_seconds_remaining | integer | Seconds remaining in the game at the end of the play. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| lag_qtr | integer | Quarter lag (the previous-play's quarter). |
| lag_game_half | character | Half lag (the previous-play's half). |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| type_abbreviation | character | Type abbreviation. |

Returns a tibble

Columns as documented in the shared
[espn_nba_game_all_team_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_team_schema.md)
table.

Returns a tibble

Columns as documented in the shared
[espn_nba_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all_player_schema.md)
table.

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

Returns a tibble of per-season NBA standings.

Returns a tibble of per-game NBA rosters.

Returns a tibble of per-game NBA officials.

Returns a tibble of NBA draft picks.

Returns a tibble of NBA player season stats (long format).

Returns a tibble of NBA team season stats (long format).

Returns a tibble of NBA team rosters.

Returns a tibble of NBA athlete core records (one row per
athlete-season).

Returns a tibble with one row per shot attempt.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year). |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| team_id | integer | Unique team identifier. |
| athlete_id_1 | integer | Primary athlete identifier (the shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the shot/play type. |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the shot (2 / 3 / 1). |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| athlete_name_1 | character | Display name of the primary athlete (the shooter). |
| athlete_name_2 | character | Display name of the secondary athlete, when present. |
| team_name | character | Full team display name. |
| team_mascot | character | Team mascot / nickname. |
| team_abbrev | character | Short team abbreviation. |

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md)

## Examples

``` r
# \donttest{
load_nba_pbp(seasons = most_recent_nba_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_pbp/play_by_play_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_pbp/play_by_play_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_nba_team_box(seasons = most_recent_nba_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_boxscores/team_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_team_boxscores/team_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_nba_player_box(seasons = most_recent_nba_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_boxscores/player_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_player_boxscores/player_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_nba_schedule(seasons = most_recent_nba_season())
#> ── ESPN NBA schedules from hoopR data repository ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-07 11:47:22 UTC
#> # A tibble: 1,206 × 78
#>         id uid   date  attendance time_valid neutral_site conference_competition
#>      <int> <chr> <chr>      <dbl> <lgl>      <lgl>        <lgl>                 
#>  1  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  2  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  3  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  4  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  5  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  6  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  7  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  8  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#>  9  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#> 10  4.02e8 s:40… 2027…          0 TRUE       FALSE        FALSE                 
#> # ℹ 1,196 more rows
#> # ℹ 71 more variables: play_by_play_available <lgl>, recent <lgl>,
#> #   start_date <chr>, broadcast <chr>, highlights <chr>, notes_type <chr>,
#> #   notes_headline <chr>, broadcast_market <chr>, broadcast_name <chr>,
#> #   type_id <int>, type_abbreviation <chr>, venue_id <int>,
#> #   venue_full_name <chr>, venue_address_city <chr>, venue_address_state <chr>,
#> #   venue_indoor <lgl>, status_clock <dbl>, status_display_clock <chr>, …
# }
# \donttest{
load_nba_shots(seasons = most_recent_nba_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_shots/shots_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_nba_shots/shots_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
```
