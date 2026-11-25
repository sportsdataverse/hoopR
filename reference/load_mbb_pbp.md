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

## Source

The `espn_mens_college_basketball_pbp` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_pbp>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_team_boxscores` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_team_boxscores>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_player_boxscores` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_player_boxscores>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_schedules` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_schedules>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_rosters>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_player_season_stats` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_player_season_stats>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_team_season_stats` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_team_season_stats>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_standings` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_standings>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_game_rosters` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_game_rosters>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_officials` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_officials>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_player_core` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_player_core>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

The `espn_mens_college_basketball_shots` release:
<https://github.com/sportsdataverse/sportsdataverse-data/releases/tag/espn_mens_college_basketball_shots>,
published by <https://github.com/sportsdataverse/hoopR-mbb-data>.

## Arguments

- seasons:

  A vector of 4-digit years associated with given men's college
  basketball seasons, or `TRUE` for every published season. Each loader
  accepts only the seasons its release tag publishes (any other season
  is an error):

  - `load_mbb_pbp()`, `load_mbb_shots()`: 2003 and 2006 onward
    (2004-2005 were never published).

  - `load_mbb_team_box()`, `load_mbb_player_box()`,
    `load_mbb_team_stats()`, `load_mbb_standings()`,
    `load_mbb_player_core()`: 2003 onward.

  - `load_mbb_schedule()`: 2002 onward.

  - `load_mbb_game_rosters()`: 2002 onward.

  - `load_mbb_officials()`: 2003 onward, except 2010.

  - `load_mbb_player_stats()`: 2003 onward (ESPN's single-season player
    rows are sparse before about 2010).

  - `load_mbb_rosters()`: 2025 onward.

  Every season in those ranges is published as `.rds` (checked
  2026-11-13). The upper bound is
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).
  When `seasons` is left at its default and that season's file is not
  published yet, the loader reads the newest published season instead,
  with a message. An explicit request for that not-yet-published season
  is kept as asked: the read warns and returns an empty frame. A season
  outside the published range, or in a known gap, is an error.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database (used by
  [`update_mbb_db()`](https://hoopR.sportsdataverse.org/reference/update_mbb_db.md)).

- dbConnection:

  A `DBIConnection` object, as returned by

- tablename:

  The name of the play by play data table within the database

## Value

A `hoopR_data` tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_play_number | integer | Sequential play number within the game. |
| id | character | ESPN play id, exact (see Details). |
| sequence_number | integer | Sequence number representing a shot-possession (V3 PBP). |
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
| wallclock | character | Wallclock. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| points_attempted | integer | Point value at stake on the shot attempt (3 for threes, 2 for other field goals, 1 for free throws), from the ESPN play type. |
| short_description | character | Shortened version of ESPN's play description text, without score context. |
| team_id | integer | Unique team identifier. |
| athlete_id_1 | integer | Primary athlete identifier (e.g. shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_mascot | character | Home team mascot. |
| home_team_abbrev | character | Home team three-letter abbreviation. |
| home_team_name_alt | character | Alternate home team name. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_mascot | character | Away team mascot. |
| away_team_abbrev | character | Away team three-letter abbreviation. |
| away_team_name_alt | character | Alternate away team name. |
| game_spread | numeric | Game spread (signed; positive = home favored). |
| home_favorite | logical | TRUE if the home team is the betting favorite. |
| game_spread_available | logical | TRUE if a point spread was available. |
| home_team_spread | numeric | Home team's point spread. |
| half | integer | Half of the game: 1 or 2 in regulation; overtime periods continue the count (3, 4, ...). |
| time | character | Time / clock value. |
| clock_minutes | integer | Clock minutes split out for convenience. |
| clock_seconds | integer | Clock seconds split out for convenience. |
| home_timeout_called | logical | TRUE when the home team called a timeout on the play. |
| away_timeout_called | logical | TRUE when the away team called a timeout on the play. |
| lag_period | integer | Period number of the previous play in the same game (period_number shifted forward one row within game_id), and NA on each game's first play. |
| lead_period | integer | Period number of the next play in the same game (period_number shifted back one row within game_id), and NA on each game's final play. |
| lag_half | integer | Half of the previous play in the same game, NA on each game's first play. |
| lead_half | integer | Half of the next play in the same game, NA on each game's final play. |
| start_period_seconds_remaining | integer | Seconds left in the current period when the play started, computed as 60 times the game clock minutes plus the seconds, so 1200 at the tip of each 20-minute half and 300 at the start of an overtime. |
| start_game_seconds_remaining | integer | Seconds remaining in the game at the start of the play. |
| end_period_seconds_remaining | integer | Seconds left in the period when the play ended. |
| end_game_seconds_remaining | integer | Seconds remaining in the game at the end of the play. |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| score_source | character | Where this game's home_score/away_score come from: 'rebuilt' (summed from the scoring plays and equal to the official final on the last play) or 'espn' (ESPN's per-play values, kept when the rebuild misses the final or the game has no final). Absent from seasons published before the repair. |
| athlete_name_1 | character | Display name of the primary athlete (e.g. the shooter). |
| athlete_name_2 | character | Display name of the secondary athlete, when present. |
| athlete_name_3 | character | Display name of the third athlete in the ESPN play participants, when present. |
| pregame_home_prob | numeric | Model's pre-game win probability for the home team (0-1), constant within a game. Present only on the seasons published with the win-probability model; absent on the others. |
| home_win_prob | numeric | Model's in-game win probability for the home team (0-1) after the play. |

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
| team_home_away | character | Whether the team is the home or the away side ('home' or 'away'). |
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
| opponent_team_uid | character | ESPN universal identifier of the opponent team. |
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
| lead_changes | character | Times the lead changed hands during the game, as ESPN's team box score reports it (the same on both team rows). |
| lead_percentage | character | Share of game time the team held the lead, as reported in ESPN's team boxscore. |

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
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
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
| active | logical | TRUE if the row represents an active record (player / team / season). |

A `hoopR_data` tibble with one row per game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | integer | Id. |
| uid | character | ESPN UID string (universal identifier). |
| date | character | Date in YYYY-MM-DD format. |
| attendance | numeric | Reported attendance. |
| time_valid | logical | Time valid. |
| neutral_site | logical | Neutral site. |
| conference_competition | logical | Conference competition. |
| play_by_play_available | logical | Whether ESPN lists play-by-play for the game. |
| recent | logical | Recent. |
| start_date | character | Start date (YYYY-MM-DD). |
| broadcast | character | Broadcast networks ESPN lists for the game, as one string. |
| highlights | character | ESPN highlight clips for the game, serialized as a single string; NA when none was published. |
| notes_type | character | Notes type. |
| notes_headline | character | Notes headline. |
| broadcast_market | character | Market of the first listed broadcast: 'national', 'home' or 'away'. |
| broadcast_name | character | Network name of the first listed broadcast (e.g. 'ESPN'). |
| type_id | integer | Type identifier (numeric). |
| type_abbreviation | character | Type abbreviation. |
| venue_id | integer | Unique venue identifier. |
| venue_full_name | character | Venue full name. |
| venue_address_city | character | Venue address city. |
| venue_address_state | character | Venue address state / region. |
| venue_indoor | logical | TRUE if the venue is indoors. |
| status_clock | numeric | Status clock. |
| status_display_clock | character | Status display clock. |
| status_period | numeric | Status period. |
| status_type_id | integer | Unique identifier for status type. |
| status_type_name | character | Status type name. |
| status_type_state | character | Status type state. |
| status_type_completed | logical | Status type completed. |
| status_type_description | character | Status type description. |
| status_type_detail | character | Status type detail. |
| status_type_short_detail | character | Status type short detail. |
| format_regulation_periods | numeric | Format regulation periods. |
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
| home_conference_id | integer | Unique identifier for home conference. |
| home_score | integer | Home team score at the time of the play. |
| home_winner | logical | Home team's winner. |
| home_current_rank | numeric | Poll ranking ESPN listed for the home team at game time; unranked teams carry 99. |
| home_linescores | character | Period-by-period scores for the home team as a delimited string from ESPN's schedule feed. |
| home_records | character | Record strings (overall and split records) for the home team from ESPN's schedule feed. |
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
| away_conference_id | integer | Unique identifier for away conference. |
| away_score | integer | Away team score at the time of the play. |
| away_winner | logical | Away team's winner. |
| away_current_rank | numeric | Poll ranking ESPN listed for the away team at game time; unranked teams carry 99. |
| away_linescores | character | Period-by-period scores for the away team as a delimited string from ESPN's schedule feed. |
| away_records | character | Record strings (overall and split records) for the away team from ESPN's schedule feed. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| status_type_alt_detail | character | Status type alt detail. |
| tournament_id | integer | Unique identifier for tournament. |
| groups_id | integer | Unique identifier for groups. |
| groups_name | character | Groups name. |
| groups_short_name | character | Groups short name. |
| groups_is_conference | logical | Groups is conference. |
| game_json | logical | Whether the data repository holds a processed game JSON for this game. |
| game_json_url | character | URL of the processed game JSON in the raw data repository. |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| game_date | Date | Game date (YYYY-MM-DD). |
| PBP | logical | Whether the game's play-by-play is in the published play-by-play release. |
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

A `hoopR_data` tibble with one row per shot attempt.

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

## Details

The play `id` is returned as character. ESPN's men's college play ids
have 18 digits, more than a double can hold exactly, and the `.rds`
release asset stores them as doubles (about 41% of the 2025 ids collide
there). `load_mbb_pbp()` therefore reads the `.parquet` asset, which
keeps the exact 64-bit ids, when the arrow package is installed, and
warns when it has to fall back to the `.rds`.

ESPN join ids are integer in every loader, as they are in the box scores
and schedules: `load_mbb_game_rosters()` casts `game_id`, and
`load_mbb_rosters()` casts `athlete_id`, both of which the release
publishes as character.

## See also

Other hoopR Loader Functions:
[`load_nba_depthcharts()`](https://hoopR.sportsdataverse.org/reference/load_nba_depthcharts.md),
[`load_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/load_nba_pbp.md)

## Examples

``` r
# \donttest{
# One season is a ~80 MB download.
load_mbb_pbp(seasons = most_recent_mbb_season())
#> ── ESPN MBB pbp from hoopR data repository ────────────────────── hoopR 3.2.0 ──
#> # A tibble: 622,846 × 63
#>    game_play_number id        sequence_number type_id type_text text  away_score
#>               <int> <chr>               <int>   <int> <chr>     <chr>      <int>
#>  1                1 40190227…       120473789     615 Jumpball  "Sta…          0
#>  2                2 40190227…       120473793     615 Jumpball  "Jum…          0
#>  3                3 40190227…       120473795     615 Jumpball  "Jum…          0
#>  4                4 40190227…       120474005     558 JumpShot  "Sha…          0
#>  5                5 40190227…       120474009     618 Block Sh… "Dra…          0
#>  6                6 40190227…       120474012     587 Defensiv… "Edu…          0
#>  7                7 40190227…       120474014     558 JumpShot  "Edu…          0
#>  8                8 40190227…       120474195     587 Defensiv… "Jas…          0
#>  9                9 40190227…       120474436     598 Lost Bal… "Coo…          0
#> 10               10 40190227…       120474439     607 Steal     "Jal…          0
#> # ℹ 622,836 more rows
#> # ℹ 56 more variables: home_score <int>, period_number <int>,
#> #   period_display_value <chr>, clock_display_value <chr>, scoring_play <lgl>,
#> #   score_value <int>, wallclock <chr>, shooting_play <lgl>,
#> #   coordinate_x_raw <dbl>, coordinate_y_raw <dbl>, points_attempted <int>,
#> #   short_description <chr>, team_id <int>, athlete_id_1 <int>,
#> #   athlete_id_2 <int>, game_id <int>, season <int>, season_type <int>, …
# }
# \donttest{
load_mbb_team_box(seasons = most_recent_mbb_season())
#> ── ESPN MBB team_box from hoopR data repository ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 12:13:39 UTC
#> # A tibble: 2,542 × 59
#>      game_id season season_type game_date  game_date_time      team_id team_uid 
#>        <int>  <int>       <int> <date>     <dttm>                <int> <chr>    
#>  1 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    2737 s:40~l:4…
#>  2 401913530   2027           2 2026-11-23 2026-11-23 20:00:00     356 s:40~l:4…
#>  3 401909743   2027           2 2026-11-23 2026-11-23 23:55:00      36 s:40~l:4…
#>  4 401909743   2027           2 2026-11-23 2026-11-23 23:55:00      12 s:40~l:4…
#>  5 401909788   2027           2 2026-11-23 2026-11-23 20:00:00    2172 s:40~l:4…
#>  6 401909788   2027           2 2026-11-23 2026-11-23 20:00:00    2305 s:40~l:4…
#>  7 401921708   2027           2 2026-11-23 2026-11-23 17:00:00     264 s:40~l:4…
#>  8 401921708   2027           2 2026-11-23 2026-11-23 17:00:00     252 s:40~l:4…
#>  9 401927397   2027           2 2026-11-23 2026-11-23 11:00:00     179 s:40~l:4…
#> 10 401927397   2027           2 2026-11-23 2026-11-23 11:00:00    2026 s:40~l:4…
#> # ℹ 2,532 more rows
#> # ℹ 52 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>, …
# }
# \donttest{
# One season is a ~7 MB download.
load_mbb_player_box(seasons = most_recent_mbb_season())
#> ── ESPN MBB player_box from hoopR data repository ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 12:14:27 UTC
#> # A tibble: 40,019 × 55
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5459919
#>  2 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5314757
#>  3 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5313454
#>  4 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5313182
#>  5 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5239628
#>  6 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5459920
#>  7 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5459917
#>  8 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5176753
#>  9 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5459921
#> 10 401913530   2027           2 2026-11-23 2026-11-23 20:00:00    5459918
#> # ℹ 40,009 more rows
#> # ℹ 49 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
# \donttest{
load_mbb_schedule(seasons = most_recent_mbb_season())
#> ── ESPN MBB schedules from hoopR data repository ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 12:26:28 UTC
#> # A tibble: 6,076 × 88
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
#> # ℹ 6,066 more rows
#> # ℹ 81 more variables: recent <lgl>, start_date <chr>, broadcast <chr>,
#> #   notes_type <chr>, notes_headline <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, type_id <int>, type_abbreviation <chr>,
#> #   venue_id <int>, venue_full_name <chr>, venue_address_city <chr>,
#> #   venue_address_state <chr>, venue_indoor <lgl>, status_clock <dbl>,
#> #   status_display_clock <chr>, status_period <dbl>, status_type_id <int>, …
# }
# \donttest{
# One season is a ~14 MB download.
load_mbb_shots(seasons = most_recent_mbb_season())
#> ── ESPN MBB shots from hoopR data repository ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 12:26:48 UTC
#> # A tibble: 205,802 × 20
#>      game_id season period_number clock_display_value team_id athlete_id_1
#>        <int>  <int>         <int> <chr>                 <int>        <int>
#>  1 401913530   2027             1 19:44                   356      5214642
#>  2 401913530   2027             1 19:26                  2737      5313454
#>  3 401913530   2027             1 19:17                   356      5307569
#>  4 401913530   2027             1 19:07                   356      5214642
#>  5 401913530   2027             1 19:02                   356      5307569
#>  6 401913530   2027             1 18:33                   356      5325990
#>  7 401913530   2027             1 18:24                  2737      5239628
#>  8 401913530   2027             1 18:12                   356      5308441
#>  9 401913530   2027             1 17:27                  2737      5314757
#> 10 401913530   2027             1 17:15                   356      5175007
#> # ℹ 205,792 more rows
#> # ℹ 14 more variables: athlete_id_2 <int>, type_id <int>, type_text <chr>,
#> #   scoring_play <lgl>, score_value <int>, coordinate_x <dbl>,
#> #   coordinate_y <dbl>, coordinate_x_raw <dbl>, coordinate_y_raw <dbl>,
#> #   athlete_name_1 <chr>, athlete_name_2 <chr>, team_name <chr>,
#> #   team_mascot <chr>, team_abbrev <chr>
# }
```
