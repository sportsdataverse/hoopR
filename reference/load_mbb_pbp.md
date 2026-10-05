# **Load hoopR men's college basketball play-by-play**

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons from the data repo either into memory
or writes it into a db using some forwarded arguments in the dots

helper that loads multiple seasons of ESPN men's college basketball team
rosters from the sportsdataverse-data release repo, either into memory
or into a database via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN men's college basketball
player season stats (long format) from the sportsdataverse-data release
repo, either into memory or into a database via forwarded arguments in
the dots.

helper that loads multiple seasons of ESPN men's college basketball team
season stats (long format) from the sportsdataverse-data release repo,
either into memory or into a database via forwarded arguments in the
dots.

helper that loads multiple seasons of ESPN men's college basketball
standings from the sportsdataverse-data release repo, either into memory
or into a database via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN men's college basketball
per-game rosters from the sportsdataverse-data release repo, either into
memory or into a database via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN men's college basketball
per-game officials from the sportsdataverse-data release repo, either
into memory or into a database via forwarded arguments in the dots.

helper that loads multiple seasons of ESPN MBB athlete core records –
identity and biographical fields, one row per athlete who appeared in
the season – from the sportsdataverse-data release repo, either into
memory or into a database via forwarded arguments in the dots.

This is the only source of athlete bio in the pipeline: the player
season stats payload carries no identity at all – not even the athlete
id.

Two properties of the source are worth knowing before joining:

- `current_team_id` is the athlete's CURRENT team, not their team in the
  requested season. Season team lives in `load_mbb_player_box()` /
  `load_mbb_player_stats()`.

- Bio (height / weight / jersey) is a current snapshot that ESPN
  overwrites in place; it is not era-correct for a historical season.
  The season dimension here is participation, not the bio's vintage.

Field coverage is era-dependent by nature – headshots exist only for
modern players, while college and date of birth thin out the other way.

Loads shot events parsed from ESPN men's college basketball play-by-play
feeds. One row per shot attempt (made or missed), with court coordinates
and shot metadata. Backed by the `hoopR-mbb-data` pipeline, publishing
parquet/rds artifacts to the `espn_mens_college_basketball_shots`
release tag. Published coverage runs 2003 and 2006 through the most
recent season – 2004 and 2005 are a documented gap (no shot-coordinate
assets were published for those two seasons).

## Usage

``` r
load_mbb_pbp(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_team_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_player_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_schedule(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_player_stats(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_team_stats(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_standings(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_game_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_officials(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_player_core(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_mbb_shots(
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

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | numeric | Id. |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| type_id | character | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score at the time of the play. |
| home_score | integer | Home team score at the time of the play. |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| period_display_value | character | Period display label (e.g. '1st Quarter', 'OT'). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the play (2 / 3 / 1). |
| team_id | character | Unique team identifier. |
| participants_0_athlete_id | character | V2 PBP participant 0 (primary) athlete ID. |
| wallclock | character | Wallclock. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| participants_1_athlete_id | character | V2 PBP participant 1 (secondary) athlete ID. |
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
| clock_minutes | character | Clock minutes split out for convenience. |
| clock_seconds | character | Clock seconds split out for convenience. |
| half | character | Half of the game (1 or 2). |
| game_half | character | Half of the game (1 or 2). |
| lag_qtr | numeric | Quarter lag (the previous-play's quarter). |
| lead_qtr | numeric | Quarter lead (the next-play's quarter). |
| lag_game_half | character | Half lag (the previous-play's half). |
| lead_game_half | character | Half lead (the next-play's half). |
| start_quarter_seconds_remaining | integer | Seconds remaining in the period at the start of the play. |
| start_half_seconds_remaining | integer | Seconds remaining in the half at the start of the play. |
| start_game_seconds_remaining | integer | Seconds remaining in the game at the start of the play. |
| game_play_number | integer | Sequential play number within the game. |
| end_quarter_seconds_remaining | numeric | Seconds remaining in the period at the end of the play. |
| end_half_seconds_remaining | numeric | Seconds remaining in the half at the end of the play. |
| end_game_seconds_remaining | numeric | Seconds remaining in the game at the end of the play. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| coordinate_x | integer | X coordinate on the court (half-court layout). |
| coordinate_y | integer | Y coordinate on the court (half-court layout). |
| media_id | character | Media identifier (video / image). |

Returns a tibble

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| field_goals_made_field_goals_attempted | character | Field Goals Made-Attempted. |
| field_goal_pct | character | Field goal percentage (0-1). |
| three_point_field_goals_made_three_point_field_goals_attempted | character | 3-Point Field Goals Made-Attempted. |
| three_point_field_goal_pct | character | Three-point field goal percentage (0-1). |
| free_throws_made_free_throws_attempted | character | Free Throws Made-Attempted. |
| free_throw_pct | character | Free throw percentage (0-1). |
| total_rebounds | character | Total rebounds. |
| offensive_rebounds | character | Offensive rebounds. |
| defensive_rebounds | character | Defensive rebounds. |
| assists | character | Total assists. |
| steals | character | Total steals. |
| blocks | character | Total blocks. |
| turnovers | character | Total turnovers. |
| team_turnovers | character | Team turnovers (turnovers credited to the team rather than a player). |
| total_turnovers | character | Total turnovers (player + team). |
| technical_fouls | character | Total technical fouls. |
| total_technical_fouls | character | Total technical fouls (player + team). |
| flagrant_fouls | character | Total flagrant fouls. |
| fouls | character | Personal fouls. |
| largest_lead | character | Largest lead during the game. |
| home_away | character | Game venue label ('home' or 'away'). |
| opponent_id | integer | Unique identifier for opponent. |
| opponent_name | character | Opponent name. |
| opponent_mascot | character | Opponent mascot. |
| opponent_abbrev | character | Abbreviation for opponent. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |

Returns a tibble

Columns as documented in the shared
[espn_mbb_game_all_player_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_player_schema.md)
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
| type_id | character | Type identifier (numeric). |
| type_abbreviation | character | Type abbreviation. |
| venue_id | character | Unique venue identifier. |
| venue_full_name | character | Venue full name. |
| venue_address_city | character | Venue address city. |
| venue_address_state | character | Venue address state / region. |
| venue_capacity | integer | Venue seating capacity. |
| venue_indoor | logical | TRUE if the venue is indoors. |
| status_clock | numeric | Status clock. |
| status_display_clock | character | Status display clock. |
| status_period | integer | Status period. |
| status_type_id | character | Unique identifier for status type. |
| status_type_name | character | Status type name. |
| status_type_state | character | Status type state. |
| status_type_completed | logical | Status type completed. |
| status_type_description | character | Status type description. |
| status_type_detail | character | Status type detail. |
| status_type_short_detail | character | Status type short detail. |
| format_regulation_periods | integer | Format regulation periods. |
| home_id | character | Unique identifier for home. |
| home_uid | character | Home team's uid. |
| home_location | character | Home team's location. |
| home_name | character | Home name. |
| home_abbreviation | character | Home team's abbreviation. |
| home_display_name | character | Home display name. |
| home_short_display_name | character | Home short display name. |
| home_color | character | Color code (hex) for home. |
| home_alternate_color | character | Color code (hex) for home alternate. |
| home_is_active | logical | Home team's is active. |
| home_venue_id | character | Unique identifier for home venue. |
| home_logo | character | Home team logo URL. |
| home_conference_id | character | Unique identifier for home conference. |
| home_score | character | Home team score at the time of the play. |
| home_winner | logical | Home team's winner. |
| away_id | character | Unique identifier for away. |
| away_uid | character | Away team's uid. |
| away_location | character | Away team's location. |
| away_name | character | Away name. |
| away_abbreviation | character | Away team's abbreviation. |
| away_display_name | character | Away display name. |
| away_short_display_name | character | Away short display name. |
| away_color | character | Color code (hex) for away. |
| away_alternate_color | character | Color code (hex) for away alternate. |
| away_is_active | logical | Away team's is active. |
| away_venue_id | character | Unique identifier for away venue. |
| away_logo | character | Away team logo URL. |
| away_conference_id | character | Unique identifier for away conference. |
| away_score | character | Away team score at the time of the play. |
| away_winner | logical | Away team's winner. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| status_type_alt_detail | character | Status type alt detail. |
| groups_id | character | Unique identifier for groups. |
| groups_name | character | Groups name. |
| groups_short_name | character | Groups short name. |
| groups_is_conference | logical | Groups is conference. |
| tournament_id | numeric | Unique identifier for tournament. |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| game_date | Date | Game date (YYYY-MM-DD). |
| PBP | logical |  |
| team_box | logical | Team box. |
| player_box | logical | Player box. |

Returns a tibble of MBB team rosters.

Returns a tibble of MBB player season stats (long format).

Returns a tibble of MBB team season stats (long format).

Returns a tibble of MBB standings.

Returns a tibble of MBB per-game rosters.

Returns a tibble of MBB per-game officials.

Returns a tibble of MBB athlete core records (one row per
athlete-season).

Returns a tibble with one row per shot attempt.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year). |
| period_number | integer | Numeric period (1-2 halves). |
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
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)

## Examples

``` r
# \donttest{
load_mbb_pbp(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_pbp/play_by_play_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_pbp/play_by_play_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_mbb_team_box(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_team_boxscores/team_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_team_boxscores/team_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_mbb_player_box(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_player_boxscores/player_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_player_boxscores/player_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
load_mbb_schedule(seasons = most_recent_mbb_season())
#> ── ESPN MBB schedules from hoopR data repository ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-15 08:21:19 UTC
#> # A tibble: 1,629 × 83
#>         id uid   date  attendance time_valid neutral_site conference_competition
#>      <int> <chr> <chr>      <dbl> <lgl>      <lgl>        <lgl>                 
#>  1  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  2  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  3  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  4  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  5  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  6  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  7  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  8  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#>  9  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#> 10  4.02e8 s:40… 2027…          0 FALSE      FALSE        TRUE                  
#> # ℹ 1,619 more rows
#> # ℹ 76 more variables: play_by_play_available <lgl>, recent <lgl>,
#> #   start_date <chr>, broadcast <chr>, highlights <chr>, notes_type <chr>,
#> #   notes_headline <chr>, broadcast_market <chr>, broadcast_name <chr>,
#> #   type_id <int>, type_abbreviation <chr>, venue_id <int>,
#> #   venue_full_name <chr>, venue_address_city <chr>, venue_address_state <chr>,
#> #   venue_indoor <lgl>, status_clock <dbl>, status_display_clock <chr>, …
# }
# \donttest{
load_mbb_shots(seasons = most_recent_mbb_season())
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_shots/shots_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/espn_mens_college_basketball_shots/shots_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
```
