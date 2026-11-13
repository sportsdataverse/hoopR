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

## Source

The `espn_nba_pbp` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_pbp>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_team_boxscores` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_team_boxscores>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_player_boxscores` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_boxscores>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_schedules` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_schedules>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_standings` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_standings>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_game_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_game_rosters>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_officials` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_officials>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_draft` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_draft>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_player_season_stats` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_season_stats>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_team_season_stats` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_team_season_stats>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_rosters>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_player_core` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_player_core>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

The `espn_nba_shots` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_nba_shots>,
published by <https://github.com/sportsdataverse/hoopR-nba-data>.

## Arguments

- seasons:

  A vector of 4-digit years associated with given NBA seasons, or `TRUE`
  for every published season. Each loader accepts only the seasons its
  release tag publishes (any other season is an error):

  - `load_nba_team_box()`, `load_nba_player_box()`,
    `load_nba_schedule()`, `load_nba_player_stats()`,
    `load_nba_player_core()`, `load_nba_game_rosters()`,
    `load_nba_officials()`, `load_nba_team_stats()`: 1994 onward.

  - `load_nba_pbp()`, `load_nba_shots()`, `load_nba_standings()`: 2002
    onward.

  - `load_nba_draft()`: 2003 onward.

  - `load_nba_rosters()`: 2025 onward.

  The upper bound is
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).
  When `seasons` is left at its default and that season's file is not
  published yet, the loader reads the newest published season instead,
  with a message. An explicit request for that not-yet-published season
  is kept as asked: the read warns and returns an empty frame. A season
  outside the published range, or in a known gap, is an error.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_nba_db()`](https://hoopR.sportsdataverse.org/reference/update_nba_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by

- tablename:

  The name of the play by play data table within the database

## Value

A `hoopR_data` tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN play id (see Details). |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score after the play. Rebuilt from the scoring plays in feed order when that reaches the official final (score_source 'rebuilt'), otherwise ESPN's per-play value (score_source 'espn'). |
| home_score | integer | Home team score after the play. Rebuilt from the scoring plays in feed order when that reaches the official final (score_source 'rebuilt'), otherwise ESPN's per-play value (score_source 'espn'). |
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
| score_source | character | Where this game's home_score/away_score come from: 'rebuilt' (summed from the scoring plays and equal to the official final on the last play) or 'espn' (ESPN's per-play values, kept when the rebuild misses the final or the game has no final). Absent from seasons published before the repair. |

A `hoopR_data` tibble with one row per team-game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
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
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| fast_break_points | character | Fast-break points scored. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| points_in_paint | character | Points scored in the paint. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnover_points | character | Turnover points. |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

A `hoopR_data` tibble with one row per player-game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| plus_minus | character | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| reason | character | Reason. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

A `hoopR_data` tibble with one row per game.

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

A `hoopR_data` tibble with one row per shot attempt.

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

## Details

The play `id` is returned as character, matching
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md).
`load_nba_pbp()` reads the `.parquet` release asset (exact 64-bit ids)
when the arrow package is installed and the `.rds` asset otherwise.

ESPN join ids are integer in every loader, as they are in the box scores
and schedules: `load_nba_game_rosters()` casts `game_id`, and
`load_nba_rosters()` casts `athlete_id`, both of which the release
publishes as character.

## See also

Other hoopR Loader Functions:
[`load_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/load_mbb_pbp.md)

## Examples

``` r
# \donttest{
load_nba_pbp(seasons = most_recent_nba_season())
#> ── ESPN NBA pbp from hoopR data repository ────────────────────── hoopR 3.2.0 ──
#> # A tibble: 87,341 × 68
#>    game_play_number id        sequence_number type_id type_text text  away_score
#>               <int> <chr>               <int>   <int> <chr>     <chr>      <int>
#>  1                1 40190997…               4     615 Jumpball  Jako…          0
#>  2                2 40190997…               7     132 Step Bac… Jayl…          0
#>  3                3 40190997…               8     155 Defensiv… Imma…          0
#>  4                4 40190997…               9     142 Cutting … Jako…          0
#>  5                5 40190997…              10     155 Defensiv… VJ E…          0
#>  6                6 40190997…              11     113 Running … Dean…          0
#>  7                7 40190997…              12     155 Defensiv… Imma…          0
#>  8                8 40190997…              13     142 Cutting … Jako…          2
#>  9                9 40190997…              15      44 Shooting… Coll…          2
#> 10               10 40190997…              17      98 Free Thr… Jayl…          2
#> # ℹ 87,331 more rows
#> # ℹ 61 more variables: home_score <int>, period_number <int>,
#> #   period_display_value <chr>, clock_display_value <chr>, scoring_play <lgl>,
#> #   score_value <int>, team_id <int>, athlete_id_1 <int>, athlete_id_2 <int>,
#> #   athlete_id_3 <int>, wallclock <chr>, shooting_play <lgl>,
#> #   coordinate_x_raw <dbl>, coordinate_y_raw <dbl>, points_attempted <int>,
#> #   short_description <chr>, game_id <int>, season <int>, season_type <int>, …
# }
# \donttest{
load_nba_team_box(seasons = most_recent_nba_season())
#> ── ESPN NBA team_box from hoopR data repository ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:32:24 UTC
#> # A tibble: 348 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401909976   2027           2 2026-11-12 2026-11-12 19:00:00      28 s:40~l:4…
#>  2 401909976   2027           2 2026-11-12 2026-11-12 19:00:00      20 s:40~l:4…
#>  3 401909977   2027           2 2026-11-12 2026-11-12 19:00:00       8 s:40~l:4…
#>  4 401909977   2027           2 2026-11-12 2026-11-12 19:00:00      27 s:40~l:4…
#>  5 401909978   2027           2 2026-11-12 2026-11-12 20:00:00       6 s:40~l:4…
#>  6 401909978   2027           2 2026-11-12 2026-11-12 20:00:00      16 s:40~l:4…
#>  7 401909979   2027           2 2026-11-12 2026-11-12 21:00:00      30 s:40~l:4…
#>  8 401909979   2027           2 2026-11-12 2026-11-12 21:00:00      21 s:40~l:4…
#>  9 401909966   2027           2 2026-11-11 2026-11-11 19:00:00      27 s:40~l:4…
#> 10 401909966   2027           2 2026-11-11 2026-11-11 19:00:00      11 s:40~l:4…
#> # ℹ 338 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
# \donttest{
load_nba_player_box(seasons = most_recent_nba_season())
#> ── ESPN NBA player_box from hoopR data repository ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:32:42 UTC
#> # A tibble: 4,670 × 57
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4395625
#>  2 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    5093267
#>  3 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    3134908
#>  4 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4395724
#>  5 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4684272
#>  6 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    2993874
#>  7 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4431893
#>  8 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    5149115
#>  9 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4397784
#> 10 401909976   2027           2 2026-11-12 2026-11-12 19:00:00    4432241
#> # ℹ 4,660 more rows
#> # ℹ 51 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
# \donttest{
load_nba_schedule(seasons = most_recent_nba_season())
#> ── ESPN NBA schedules from hoopR data repository ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:33:20 UTC
#> # A tibble: 1,206 × 79
#>         id uid   date  attendance time_valid neutral_site play_by_play_available
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
#> # ℹ 72 more variables: recent <lgl>, start_date <chr>, broadcast <chr>,
#> #   notes_type <chr>, notes_headline <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, type_id <int>, type_abbreviation <chr>,
#> #   venue_id <int>, venue_full_name <chr>, venue_address_city <chr>,
#> #   venue_address_state <chr>, venue_indoor <lgl>, status_clock <dbl>,
#> #   status_display_clock <chr>, status_period <dbl>, status_type_id <int>, …
# }
# \donttest{
load_nba_shots(seasons = most_recent_nba_season())
#> ── ESPN NBA shots from hoopR data repository ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:33:58 UTC
#> # A tibble: 39,428 × 20
#>      game_id season period_number clock_display_value team_id athlete_id_1
#>        <int>  <int>         <int> <chr>                 <int>        <int>
#>  1 401909976   2027             1 11:44                    20      3917376
#>  2 401909976   2027             1 11:31                    28      3134908
#>  3 401909976   2027             1 11:25                    20      3912848
#>  4 401909976   2027             1 11:07                    28      3134908
#>  5 401909976   2027             1 10:48                    20      3917376
#>  6 401909976   2027             1 10:48                    20      3917376
#>  7 401909976   2027             1 10:36                    28      4684272
#>  8 401909976   2027             1 10:19                    20      5124612
#>  9 401909976   2027             1 10:04                    28      4395724
#> 10 401909976   2027             1 9:48                     20      3059318
#> # ℹ 39,418 more rows
#> # ℹ 14 more variables: athlete_id_2 <int>, type_id <int>, type_text <chr>,
#> #   scoring_play <lgl>, score_value <int>, coordinate_x <dbl>,
#> #   coordinate_y <dbl>, coordinate_x_raw <dbl>, coordinate_y_raw <dbl>,
#> #   athlete_name_1 <chr>, athlete_name_2 <chr>, team_name <chr>,
#> #   team_mascot <chr>, team_abbrev <chr>
# }
```
