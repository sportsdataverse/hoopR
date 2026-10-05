# **Load cleaned NCAA men's college basketball play-by-play from the data repo**

Loads season-level NCAA men's college basketball play-by-play. One row
per event, with reconstructed 5-man lineups, possession numbering, shot
context (transition/paint/second-chance), and an ESPN game-id crosswalk.
Produced by the sdv-py `ncaa_mbb` engine (stats.ncaa.org play-by-play
parsed, cleaned, and enriched); backed by the `ncaa-mbb-hoops-data`
pipeline, published to the `ncaa_mbb_pbp` release tag as
csv.gz/parquet/rds.

Loads shot-chart events for NCAA men's college basketball – one row per
field goal attempt, with court coordinates, distance, shot zone, and
made/missed result. Coordinates are only available from the 2019 season
onward (stats.ncaa.org did not publish shot-location data before then),
so `seasons` has a 2019 floor even though most sibling NCAA MBB datasets
start at 2010. Produced by the sdv-py `ncaa_mbb` engine; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_shots`
release tag as csv.gz/parquet/rds.

Loads reconstructed 5-man lineup stints for NCAA men's college
basketball – one row per contiguous stretch a specific 5-player lineup
was on court for a team, with on/off scoring, shooting, and rebounding
splits plus the matching opponent (`opp_*`) splits. Produced by the
sdv-py `ncaa_mbb` engine's lineup reconstructor; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_lineups`
release tag as csv.gz/parquet/rds.

Loads reconstructed 10-man matchup stints (the home 5-man lineup crossed
with the away 5-man lineup) for NCAA men's college basketball – one row
per contiguous stretch both lineups were on court together, with the
score at stint start/end and both team's lineup rosters. Produced by the
sdv-py `ncaa_mbb` engine's lineup reconstructor; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_matchup_stints` release tag as csv.gz/parquet/rds.

Loads possession-level data for NCAA men's college basketball – one row
per offensive possession, with the on-court 5-man lineups for both
teams, points scored, assist/transition/garbage-time flags, and the
possession's first and last event types. Produced by the sdv-py
`ncaa_mbb` engine's possession detector; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_possessions`
release tag as csv.gz/parquet/rds.

Loads within-team regularized adjusted plus-minus (RAPM) ratings for
NCAA men's college basketball – one row per player-team-season, fit
against teammate lineup variation within that team's own possessions
(not a cross-team national RAPM). Produced by the sdv-py `ncaa_mbb`
engine's RAPM model on top of the reconstructed lineup/possession data;
backed by the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_rapm_within_team` release tag as csv.gz/parquet/rds.

Loads league-wide regularized adjusted plus-minus (RAPM) ratings for
NCAA men's college basketball – one row per player-season, fit against
lineup variation across all Division I stints for that season (not a
within-team RAPM). Produced by the sdv-py `ncaa_mbb` engine's
league-wide stint-ridge RAPM solver (Torvik-gated to Division I teams)
on top of the reconstructed lineup/possession data; backed by the
`ncaa-mbb-hoops-data` pipeline, published to the `ncaa_mbb_rapm` release
tag as csv.gz/parquet/rds.

Loads advanced per-player, per-game box scores for NCAA men's college
basketball – one row per player-game, with shooting splits by zone
(rim/mid/3), transition and half-court splits, assisted-vs-unassisted
splits, and shot-zone efficiency rates. A superset of the traditional
box score (points/rebounds/assists/steals/blocks/turnovers/fouls are
included alongside the advanced splits). Produced by the sdv-py
`ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_player_box` release tag as
csv.gz/parquet/rds.

Loads advanced per-team, per-game box scores for NCAA men's college
basketball – one row per team-game, with offensive/defensive ratings,
shot-zone rates and efficiency (rim/mid/3), rebounding/assist/turnover
rates, and the matching opponent (`d_*`) splits. Produced by the sdv-py
`ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_team_box` release tag as csv.gz/parquet/rds.

Loads a lightweight season roster for NCAA men's college basketball –
one row per player-team-season with a games-played count. For the fuller
roster (jersey, class, position, height, hometown, high school), use
`load_ncaa_mbb_team_rosters()`. Produced by the sdv-py `ncaa_mbb`
engine; backed by the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_rosters` release tag as csv.gz/parquet/rds.

Loads the full season roster for NCAA men's college basketball – one row
per player-team-season with jersey number, class year, position, height,
hometown, high school, and games played/started. Produced by the sdv-py
`ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_team_rosters` release tag as
csv.gz/parquet/rds.

Loads season schedules/results for NCAA men's college basketball – one
row per game with home/away teams and final scores. Produced by the
sdv-py `ncaa_mbb` engine; backed by the `ncaa-mbb-hoops-data` pipeline,
published to the `ncaa_mbb_schedule` release tag as csv.gz/parquet/rds.

Loads the season-level stats.ncaa.org team-id / conference crosswalk for
NCAA men's college basketball – one row per team-season. Useful for
joining `ncaa_team_id` columns on the other `ncaa_mbb_*` datasets back
to a team name and conference. Produced by the sdv-py `ncaa_mbb` engine;
backed by the `ncaa-mbb-hoops-data` pipeline, published to the
`ncaa_mbb_team_ids` release tag as csv.gz/parquet/rds.

## Usage

``` r
load_ncaa_mbb_pbp(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_shots(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_lineups(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_matchup_stints(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_possessions(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rapm_within_team(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rapm(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_player_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_box(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_rosters(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_schedule(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_ncaa_mbb_team_ids(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit season-ending years for NCAA men's college
  basketball (e.g. `2024` for the 2023-24 season). Published coverage
  runs 2010 through the most recent season, with no gaps. Pass
  `seasons = TRUE` for every published season. (Min: 2010)

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

Returns a `hoopR_data` tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | character | Date the game was played (MM/DD/YYYY). |
| home | character | Home team name. |
| away | character | Away team name. |
| period | integer | Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). |
| clock | character | Game clock remaining in the period (MM:SS). |
| game_time | character | Elapsed game time (MM:SS). |
| game_seconds | integer | Elapsed game time in seconds from tip-off. |
| home_score | integer | Home team score after the event. |
| away_score | integer | Away team score after the event. |
| event_team | character | Team name credited with the play event. |
| event_description | character | Raw play-by-play text description. |
| player_1 | character | Primary player name involved in the event (raw, upper-cased). |
| player_2 | character | Secondary player name involved in the event (raw, upper-cased). |
| event_type | character | Play event type label (e.g. 'made Layup', 'won Jumpball'). |
| event_result | character | Event result ('made', 'missed', or NA for non-shot events). |
| shot_value | integer | Point value of a shot event (2 or 3). |
| event_length | integer | Duration of the event in seconds. |
| poss_num | integer | Sequential possession number within the game. |
| poss_team | character | Team name on offense for the possession. |
| poss_length | integer | Duration of the possession in seconds. |
| is_transition | logical | Whether the play occurred in transition. |
| home_1 | character | Home lineup slot 1 player name (raw). |
| home_2 | character | Home lineup slot 2 player name (raw). |
| home_3 | character | Home lineup slot 3 player name (raw). |
| home_4 | character | Home lineup slot 4 player name (raw). |
| home_5 | character | Home lineup slot 5 player name (raw). |
| away_1 | character | Away lineup slot 1 player name (raw). |
| away_2 | character | Away lineup slot 2 player name (raw). |
| away_3 | character | Away lineup slot 3 player name (raw). |
| away_4 | character | Away lineup slot 4 player name (raw). |
| away_5 | character | Away lineup slot 5 player name (raw). |
| status | character | Row QA status flag ('CLEAN' or a data-quality note). |
| is_garbage_time | logical | Whether the event occurred in garbage time. |
| sub_deviate | integer | Substitution-inference deviation counter used by the lineup reconstructor. |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| home_ncaa_team_id | character | stats.ncaa.org team identifier for the home team. |
| home_espn_team_id | character | ESPN team identifier for the home team. |
| away_ncaa_team_id | character | stats.ncaa.org team identifier for the away team. |
| away_espn_team_id | character | ESPN team identifier for the away team. |
| event_team_ncaa_team_id | character | stats.ncaa.org team identifier for the event team. |
| event_team_espn_team_id | character | ESPN team identifier for the event team. |
| poss_team_ncaa_team_id | character | stats.ncaa.org team identifier for the possession team. |
| poss_team_espn_team_id | character | ESPN team identifier for the possession team. |
| player_1_id | character | stats.ncaa.org player identifier for player_1. |
| player_1_clean_name | character | Cleaned/title-cased display name for player_1. |
| player_2_id | character | stats.ncaa.org player identifier for player_2. |
| player_2_clean_name | character | Cleaned/title-cased display name for player_2. |
| home_1_player_id | character | stats.ncaa.org player identifier for home lineup slot 1. |
| home_1_clean_name | character | Cleaned display name for home lineup slot 1. |
| home_2_player_id | character | stats.ncaa.org player identifier for home lineup slot 2. |
| home_2_clean_name | character | Cleaned display name for home lineup slot 2. |
| home_3_player_id | character | stats.ncaa.org player identifier for home lineup slot 3. |
| home_3_clean_name | character | Cleaned display name for home lineup slot 3. |
| home_4_player_id | character | stats.ncaa.org player identifier for home lineup slot 4. |
| home_4_clean_name | character | Cleaned display name for home lineup slot 4. |
| home_5_player_id | character | stats.ncaa.org player identifier for home lineup slot 5. |
| home_5_clean_name | character | Cleaned display name for home lineup slot 5. |
| away_1_player_id | character | stats.ncaa.org player identifier for away lineup slot 1. |
| away_1_clean_name | character | Cleaned display name for away lineup slot 1. |
| away_2_player_id | character | stats.ncaa.org player identifier for away lineup slot 2. |
| away_2_clean_name | character | Cleaned display name for away lineup slot 2. |
| away_3_player_id | character | stats.ncaa.org player identifier for away lineup slot 3. |
| away_3_clean_name | character | Cleaned display name for away lineup slot 3. |
| away_4_player_id | character | stats.ncaa.org player identifier for away lineup slot 4. |
| away_4_clean_name | character | Cleaned display name for away lineup slot 4. |
| away_5_player_id | character | stats.ncaa.org player identifier for away lineup slot 5. |
| away_5_clean_name | character | Cleaned display name for away lineup slot 5. |
| espn_game_id | character | ESPN game identifier crosswalked to this contest. |
| is_fastbreak | logical | Whether the play was a fastbreak possession. |
| is_from_turnover | logical | Whether the possession began off a turnover. |
| is_paint | logical | Whether the shot was taken in the paint. |
| is_second_chance | logical | Whether the possession followed an offensive rebound. |
| assist_player | character | Cleaned display name of the player credited with the assist. |
| ft_number | integer | Free throw number within the trip to the line (1st, 2nd, ...). |
| ft_attempts | integer | Total free throws awarded on the trip to the line. |
| foul_class | character | Foul classification ('personal', 'technical', etc.). |
| is_shooting_foul | logical | Whether the foul was a shooting foul. |
| is_looseball_foul | logical | Whether the foul was a loose-ball foul. |
| is_one_and_one | logical | Whether the free throw trip was a one-and-one bonus. |
| is_flagrant | logical | Whether the foul was flagrant. |
| foul_tech_class | character | Technical foul sub-classification (e.g. 'administrative'). |
| ft_awarded | integer | Total free throws awarded for the foul. |
| turnover_type | character | Turnover sub-type (e.g. 'shotclock', 'travel'). |
| is_team_turnover | logical | Whether the turnover is a team turnover (no individual credited). |
| timeout_type | character | Timeout sub-type (e.g. 'short', 'full'). |
| challenge_outcome | character | Replay-challenge outcome, when the event was a review. |
| season | integer | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per shot attempt.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit season-ending year). |
| team_id | character | Team name of the shooting team (raw scrape field; despite the column name it holds the team name string, not a numeric id – see ncaa_team_id / espn_team_id for the crosswalked ids). |
| shooter_id | character | Raw scrape key for the shooter (see shooter_player_id for the stats.ncaa.org id). |
| shot_x | numeric | Shot chart X coordinate. |
| shot_y | numeric | Shot chart Y coordinate. |
| dist_ft | numeric | Shot distance from the basket, in feet. |
| shot_zone | character | Shot zone label (e.g. 'abovebreak3', 'rim'). |
| shot_type | character | Shot type label from the source play description. |
| made | logical | Whether the shot was made. |
| point_value | integer | Point value of the shot (2 or 3). |
| period | logical | Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). |
| sec_left | logical | Seconds remaining in the period at the time of the shot. |
| source | character | Source system for the shot record (e.g. 'ncaa'). |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| ncaa_team_id | character | stats.ncaa.org team identifier for the shooting team. |
| espn_team_id | character | ESPN team identifier for the shooting team. |
| shooter_player_id | character | stats.ncaa.org player identifier for the shooter. |
| shooter_clean_name | character | Cleaned display name for the shooter. |
| espn_game_id | character | ESPN game identifier crosswalked to this contest. |

Returns a `hoopR_data` tibble with one row per lineup stint.

|  |  |  |
|----|----|----|
| col_name | types | description |
| lineup_key | character | Hash key uniquely identifying the 5-player lineup. |
| date | character | Game date/time (ISO 8601). |
| location_type | character | Home/away designation for `team` in this stint ('Home' or 'Away'). |
| team | character | Team name. |
| team_year | integer | Season-start calendar year for the stint. |
| opponent | character | Opponent team name. |
| lineup_id | character | Human-readable lineup identifier built from the five player codes. |
| start_min | numeric | Game-clock minute the lineup entered. |
| end_min | numeric | Game-clock minute the lineup exited. |
| duration_mins | numeric | Minutes the lineup was on court together. |
| player_1 | character | Lineup slot 1 player display name ('Last, First'). |
| player_2 | character | Lineup slot 2 player display name ('Last, First'). |
| player_3 | character | Lineup slot 3 player display name ('Last, First'). |
| player_4 | character | Lineup slot 4 player display name ('Last, First'). |
| player_5 | character | Lineup slot 5 player display name ('Last, First'). |
| players_in | character | Player(s) substituted into the lineup at the start of the stint. |
| players_out | character | Player(s) substituted out of the lineup at the start of the stint. |
| start_scored | integer | Team's points scored at the moment the lineup entered. |
| start_allowed | integer | Points allowed at the moment the lineup entered. |
| end_scored | integer | Team's points scored at the moment the lineup exited. |
| end_allowed | integer | Points allowed at the moment the lineup exited. |
| start_diff | integer | Score differential at the moment the lineup entered. |
| end_diff | integer | Score differential at the moment the lineup exited. |
| player_count_error | logical | Flag set when fewer/more than 5 players were reconstructed for the stint. |
| poss | integer | Possessions played by the lineup. |
| pts | integer | Points scored. |
| plus_minus | integer | Point differential while the lineup was on court. |
| fga | integer | Field goal attempts by the lineup. |
| fgm | integer | Field goals made by the lineup. |
| rima | integer | Rim-area shot attempts. |
| rimm | integer | Rim-area shots made. |
| rim_ast | integer | Rim-area makes that came off an assist. |
| mida | integer | Mid-range shot attempts. |
| midm | integer | Mid-range shots made. |
| mid_ast | integer | Mid-range makes that came off an assist. |
| fg2a | integer | 2-point field goal attempts by the lineup. |
| fg2m | integer | 2-point field goals made by the lineup. |
| tpa | integer | 3-point field goal attempts. |
| tpm | integer | 3-point field goals made. |
| tp_ast | integer | 3-pointers made that came off an assist. |
| fta | integer | Free throw attempts by the lineup. |
| ftm | integer | Free throws made by the lineup. |
| orb | integer | Offensive rebounds. |
| drb | integer | Defensive rebounds. |
| to | integer | Turnovers by the lineup. |
| stl | integer | Steals. |
| blk | integer | Blocks. |
| ast | integer | Assists. |
| foul | integer | Personal fouls. |
| opp_poss | integer | Opponent possessions while this lineup was on court. |
| opp_pts | integer | Opponent points scored while this lineup was on court. |
| opp_plus_minus | integer | Opponent point differential while this lineup was on court (negative of `plus_minus`). |
| opp_fga | integer | Opponent field goal attempts. |
| opp_fgm | integer | Opponent field goals made. |
| opp_rima | integer | Opponent rim-area shot attempts. |
| opp_rimm | integer | Opponent rim-area shots made. |
| opp_rim_ast | integer | Opponent rim-area makes that came off an assist. |
| opp_mida | integer | Opponent mid-range shot attempts. |
| opp_midm | integer | Opponent mid-range shots made. |
| opp_mid_ast | integer | Opponent mid-range makes that came off an assist. |
| opp_fg2a | integer | Opponent 2-point field goal attempts. |
| opp_fg2m | integer | Opponent 2-point field goals made. |
| opp_tpa | integer | Opponent 3-point field goal attempts. |
| opp_tpm | integer | Opponent 3-point field goals made. |
| opp_tp_ast | integer | Opponent 3-pointers made that came off an assist. |
| opp_fta | integer | Opponent free throw attempts. |
| opp_ftm | integer | Opponent free throws made. |
| opp_orb | integer | Opponent offensive rebounds. |
| opp_drb | integer | Opponent defensive rebounds. |
| opp_to | integer | Opponent turnovers. |
| opp_stl | integer | Opponent steals. |
| opp_blk | integer | Opponent blocks. |
| opp_ast | integer | Opponent assists. |
| opp_foul | integer | Opponent personal fouls. |
| stint_num | integer | Sequential stint number for this lineup within the game. |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| season | integer | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per matchup stint.

|  |  |  |
|----|----|----|
| col_name | types | description |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| season | integer | Season identifier (4-digit season-ending year). |
| game_date | character | Date the game was played (MM/DD/YYYY). |
| home | character | Home team name. |
| away | character | Away team name. |
| game_stint_num | integer | Sequential stint number within the game (all 10-man matchups). |
| period | integer | Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). |
| start_seconds | integer | Elapsed game seconds at the start of the stint. |
| end_seconds | integer | Elapsed game seconds at the end of the stint. |
| duration_seconds | integer | Duration of the stint in seconds. |
| matchup_key | character | Hash key uniquely identifying the home-lineup/away-lineup matchup. |
| home_lineup_key | character | Hash key for the home team's 5-player lineup. |
| away_lineup_key | character | Hash key for the away team's 5-player lineup. |
| home_lineup | character | Pipe-delimited list of the 5 home players on court. |
| away_lineup | character | Pipe-delimited list of the 5 away players on court. |
| end_home_score | integer | Home team score at the end of the stint. |
| end_away_score | integer | Away team score at the end of the stint. |
| n_events | integer | Number of play-by-play events within the stint. |
| n_possessions | integer | Number of possessions within the stint. |
| start_home_score | integer | Home team score at the start of the stint. |
| start_away_score | integer | Away team score at the start of the stint. |
| home_pts | integer | Points scored by the home team during the stint. |
| away_pts | integer | Points scored by the away team during the stint. |
| home_1 | character | Home lineup slot 1 player name (raw). |
| home_2 | character | Home lineup slot 2 player name (raw). |
| home_3 | character | Home lineup slot 3 player name (raw). |
| home_4 | character | Home lineup slot 4 player name (raw). |
| home_5 | character | Home lineup slot 5 player name (raw). |
| away_1 | character | Away lineup slot 1 player name (raw). |
| away_2 | character | Away lineup slot 2 player name (raw). |
| away_3 | character | Away lineup slot 3 player name (raw). |
| away_4 | character | Away lineup slot 4 player name (raw). |
| away_5 | character | Away lineup slot 5 player name (raw). |

Returns a `hoopR_data` tibble with one row per possession.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | character | Date the game was played (MM/DD/YYYY). |
| home | character | Home team name. |
| away | character | Away team name. |
| period | integer | Period of the game (1-2 halves pre-2016, 1-4 quarters 2016+). |
| poss_num | integer | Sequential possession number within the game. |
| poss_team | character | Team name on offense for the possession. |
| home_1 | character | Home lineup slot 1 player name (raw). |
| home_2 | character | Home lineup slot 2 player name (raw). |
| home_3 | character | Home lineup slot 3 player name (raw). |
| home_4 | character | Home lineup slot 4 player name (raw). |
| home_5 | character | Home lineup slot 5 player name (raw). |
| away_1 | character | Away lineup slot 1 player name (raw). |
| away_2 | character | Away lineup slot 2 player name (raw). |
| away_3 | character | Away lineup slot 3 player name (raw). |
| away_4 | character | Away lineup slot 4 player name (raw). |
| away_5 | character | Away lineup slot 5 player name (raw). |
| home_score | integer | Home team score after the event. |
| away_score | integer | Away team score after the event. |
| pts | integer | Points scored. |
| is_assisted | integer | Whether the possession ended in an assisted make. |
| is_transition | integer | Whether the play occurred in transition. |
| is_garbage_time | integer | Whether the event occurred in garbage time. |
| start_event_type | character | Event type that started the possession. |
| first_shot_time | integer | Elapsed game seconds at the possession's first shot attempt. |
| first_shot_type | character | Event type of the possession's first shot attempt. |
| last_event_time | integer | Elapsed game seconds at the possession's final event. |
| last_event_type | character | Event type of the possession's final event. |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| home_ncaa_team_id | character | stats.ncaa.org team identifier for the home team. |
| home_espn_team_id | character | ESPN team identifier for the home team. |
| away_ncaa_team_id | character | stats.ncaa.org team identifier for the away team. |
| away_espn_team_id | character | ESPN team identifier for the away team. |
| poss_team_ncaa_team_id | character | stats.ncaa.org team identifier for the possession team. |
| poss_team_espn_team_id | character | ESPN team identifier for the possession team. |
| home_1_player_id | character | stats.ncaa.org player identifier for home lineup slot 1. |
| home_1_clean_name | character | Cleaned display name for home lineup slot 1. |
| home_2_player_id | character | stats.ncaa.org player identifier for home lineup slot 2. |
| home_2_clean_name | character | Cleaned display name for home lineup slot 2. |
| home_3_player_id | character | stats.ncaa.org player identifier for home lineup slot 3. |
| home_3_clean_name | character | Cleaned display name for home lineup slot 3. |
| home_4_player_id | character | stats.ncaa.org player identifier for home lineup slot 4. |
| home_4_clean_name | character | Cleaned display name for home lineup slot 4. |
| home_5_player_id | character | stats.ncaa.org player identifier for home lineup slot 5. |
| home_5_clean_name | character | Cleaned display name for home lineup slot 5. |
| away_1_player_id | character | stats.ncaa.org player identifier for away lineup slot 1. |
| away_1_clean_name | character | Cleaned display name for away lineup slot 1. |
| away_2_player_id | character | stats.ncaa.org player identifier for away lineup slot 2. |
| away_2_clean_name | character | Cleaned display name for away lineup slot 2. |
| away_3_player_id | character | stats.ncaa.org player identifier for away lineup slot 3. |
| away_3_clean_name | character | Cleaned display name for away lineup slot 3. |
| away_4_player_id | character | stats.ncaa.org player identifier for away lineup slot 4. |
| away_4_clean_name | character | Cleaned display name for away lineup slot 4. |
| away_5_player_id | character | stats.ncaa.org player identifier for away lineup slot 5. |
| away_5_clean_name | character | Cleaned display name for away lineup slot 5. |
| espn_game_id | character | ESPN game identifier crosswalked to this contest. |
| season | integer | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per player-team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team | character | Team name. |
| player_code | character | Player display name as 'Last, First' used as the RAPM join key. |
| rapm_off | numeric | Within-team offensive regularized adjusted plus-minus. |
| rapm_def | numeric | Within-team defensive regularized adjusted plus-minus. |
| team_off_poss | numeric | Team offensive possessions used in the RAPM fit. |
| num_players | integer | Number of teammates included in the within-team RAPM fit. |
| rapm_net | numeric | Within-team net regularized adjusted plus-minus (rapm_off + rapm_def). |
| season | integer | Season identifier (4-digit season-ending year). |
| player_id | character | stats.ncaa.org player identifier. |
| team_id | character | Unique team identifier. |
| person_id | character | Internal person identifier used to join across seasons/teams. |

Returns a `hoopR_data` tibble with one row per player-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit season-ending year). |
| player_id | character | stats.ncaa.org player identifier. |
| person_id | character | Internal person identifier used to join across seasons/teams. |
| player | character | Player display name ('LAST.FIRST' format). |
| team | character | Team name. |
| orapm | numeric | League-wide offensive regularized adjusted plus-minus. |
| drapm | numeric | League-wide defensive regularized adjusted plus-minus. |
| rapm_net | numeric | League-wide net regularized adjusted plus-minus (orapm + drapm). |
| off_poss | integer | Offensive possessions used in the RAPM fit. |
| def_poss | integer | Defensive possessions used in the RAPM fit. |
| estimand | character | Estimand tag for the RAPM fit (e.g. 'league' for the Division I stint solve). |

Returns a `hoopR_data` tibble with one row per player-game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_date | character | Date the game was played (MM/DD/YYYY). |
| home | character | Home team name. |
| away | character | Away team name. |
| team | character | Team name. |
| player | character | Player name (raw, upper-cased). |
| mins | numeric | Minutes played. |
| o_poss | numeric | Offensive possessions played. |
| pts | numeric | Points scored. |
| orb | numeric | Offensive rebounds. |
| drb | numeric | Defensive rebounds. |
| ast | numeric | Assists. |
| stl | numeric | Steals. |
| blk | numeric | Blocks. |
| tov | numeric | Turnovers. |
| pf | numeric | Personal fouls. |
| ts_pct | numeric | True shooting percentage. |
| efg_pct | numeric | Effective field goal percentage. |
| fgm | numeric | Field goals made by the lineup. |
| fga | numeric | Field goal attempts by the lineup. |
| fg_pct | numeric | Field goal percentage. |
| tpm | numeric | 3-point field goals made. |
| tpa | numeric | 3-point field goal attempts. |
| tp_pct | numeric | 3-point field goal percentage. |
| ftm | numeric | Free throws made by the lineup. |
| fta | numeric | Free throw attempts by the lineup. |
| ft_pct | numeric | Free throw percentage. |
| rimm | numeric | Rim-area shots made. |
| rima | numeric | Rim-area shot attempts. |
| rim_pct | numeric | Rim-area field goal percentage. |
| midm | numeric | Mid-range shots made. |
| mida | numeric | Mid-range shot attempts. |
| mid_pct | numeric | Mid-range field goal percentage. |
| pbackm | numeric | Post/back-to-basket shots made. |
| pbacka | numeric | Post/back-to-basket attempts. |
| pback_pct | numeric | Post/back-to-basket shooting percentage. |
| blk_rim | numeric | Blocked shots at the rim. |
| blk_mid | numeric | Blocked mid-range shots. |
| blk_three | numeric | Blocked 3-point attempts. |
| pct_fga_trans | numeric | Share of field goal attempts taken in transition. |
| pct_tpa_trans | numeric | Share of 3-point attempts taken in transition. |
| pct_rima_trans | numeric | Share of rim-area attempts taken in transition. |
| pct_fgm_trans | numeric | Share of field goals made in transition. |
| pct_tpm_trans | numeric | Share of 3-pointers made in transition. |
| pct_rimm_trans | numeric | Share of rim-area shots made in transition. |
| pct_fgm_ast | numeric | Share of field goals made that were assisted. |
| pct_tpm_ast | numeric | Share of 3-pointers made that were assisted. |
| pct_rimm_ast | numeric | Share of rim-area shots made that were assisted. |
| pts_trans | numeric | Points scored in transition. |
| orb_trans | numeric | Offensive rebounds in transition possessions. |
| drb_trans | numeric | Defensive rebounds in transition possessions. |
| ast_trans | numeric | Assists in transition possessions. |
| stl_trans | numeric | Steals in transition possessions. |
| blk_trans | numeric | Blocks in transition possessions. |
| tov_trans | numeric | Turnovers in transition possessions. |
| ts_pct_trans | numeric | True shooting percentage in transition possessions. |
| efg_pct_trans | numeric | Effective field goal percentage in transition possessions. |
| fgm_trans | numeric | Field goals made in transition possessions. |
| fga_trans | numeric | Field goal attempts in transition possessions. |
| fg_pct_trans | numeric | Field goal percentage in transition possessions. |
| tpm_trans | numeric | 3-point field goals made in transition possessions. |
| tpa_trans | numeric | 3-point field goal attempts in transition possessions. |
| tp_pct_trans | numeric | 3-point field goal percentage in transition possessions. |
| ftm_trans | numeric | Free throws made in transition possessions. |
| fta_trans | numeric | Free throw attempts in transition possessions. |
| ft_pct_trans | numeric | Free throw percentage in transition possessions. |
| rimm_trans | numeric | Rim-area shots made in transition possessions. |
| rima_trans | numeric | Rim-area shot attempts in transition possessions. |
| rim_pct_trans | numeric | Rim-area field goal percentage in transition possessions. |
| midm_trans | numeric | Mid-range shots made in transition possessions. |
| mida_trans | numeric | Mid-range shot attempts in transition possessions. |
| mid_pct_trans | numeric | Mid-range field goal percentage in transition possessions. |
| pts_half | numeric | Points scored in half-court possessions. |
| orb_half | numeric | Offensive rebounds in half-court possessions. |
| drb_half | numeric | Defensive rebounds in half-court possessions. |
| ast_half | numeric | Assists in half-court possessions. |
| stl_half | numeric | Steals in half-court possessions. |
| blk_half | numeric | Blocks in half-court possessions. |
| tov_half | numeric | Turnovers in half-court possessions. |
| ts_pct_half | numeric | True shooting percentage in half-court possessions. |
| efg_pct_half | numeric | Effective field goal percentage in half-court possessions. |
| fgm_half | numeric | Field goals made in half-court possessions. |
| fga_half | numeric | Field goal attempts in half-court possessions. |
| fg_pct_half | numeric | Field goal percentage in half-court possessions. |
| tpm_half | numeric | 3-point field goals made in half-court possessions. |
| tpa_half | numeric | 3-point field goal attempts in half-court possessions. |
| tp_pct_half | numeric | 3-point field goal percentage in half-court possessions. |
| ftm_half | numeric | Free throws made in half-court possessions. |
| fta_half | numeric | Free throw attempts in half-court possessions. |
| ft_pct_half | numeric | Free throw percentage in half-court possessions. |
| rimm_half | numeric | Rim-area shots made in half-court possessions. |
| rima_half | numeric | Rim-area shot attempts in half-court possessions. |
| rim_pct_half | numeric | Rim-area field goal percentage in half-court possessions. |
| midm_half | numeric | Mid-range shots made in half-court possessions. |
| mida_half | numeric | Mid-range shot attempts in half-court possessions. |
| mid_pct_half | numeric | Mid-range field goal percentage in half-court possessions. |
| pts_ast | numeric | Points scored off an assisted make. |
| fgm_ast | numeric | Field goals made that came off an assist. |
| tpm_ast | numeric | 3-point field goals made that came off an assist. |
| rimm_ast | numeric | Rim-area shots made that came off an assist. |
| midm_ast | numeric | Mid-range shots made that came off an assist. |
| pts_unast | numeric | Points scored off an unassisted make. |
| efg_pct_unast | numeric | Effective field goal percentage that were unassisted. |
| fgm_unast | numeric | Field goals made that were unassisted. |
| fga_unast | numeric | Field goal attempts that were unassisted. |
| fg_pct_unast | numeric | Field goal percentage that were unassisted. |
| tpm_unast | numeric | 3-point field goals made that were unassisted. |
| tpa_unast | numeric | 3-point field goal attempts that were unassisted. |
| tp_pct_unast | numeric | 3-point field goal percentage that were unassisted. |
| rimm_unast | numeric | Rim-area shots made that were unassisted. |
| rima_unast | numeric | Rim-area shot attempts that were unassisted. |
| rim_pct_unast | numeric | Rim-area field goal percentage that were unassisted. |
| midm_unast | numeric | Mid-range shots made that were unassisted. |
| mida_unast | numeric | Mid-range shot attempts that were unassisted. |
| mid_pct_unast | numeric | Mid-range field goal percentage that were unassisted. |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| home_ncaa_team_id | character | stats.ncaa.org team identifier for the home team. |
| home_espn_team_id | character | ESPN team identifier for the home team. |
| away_ncaa_team_id | character | stats.ncaa.org team identifier for the away team. |
| away_espn_team_id | character | ESPN team identifier for the away team. |
| team_ncaa_team_id | character | stats.ncaa.org team identifier. |
| team_espn_team_id | character | ESPN team identifier. |
| player_id | character | stats.ncaa.org player identifier. |
| clean_name | character | Cleaned/title-cased display name. |
| espn_game_id | character | ESPN game identifier crosswalked to this contest. |
| season | integer | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per team-game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| home | character | Home team name. |
| away | character | Away team name. |
| team | character | Team name. |
| mins | numeric | Minutes played. |
| o_mins | numeric | Minutes with the team on offense. |
| d_mins | numeric | Minutes with the team on defense. |
| o_poss | numeric | Offensive possessions played. |
| d_poss | numeric | Defensive possessions played. |
| ortg | numeric | Offensive rating (points per 100 possessions). |
| drtg | numeric | Defensive rating (points allowed per 100 possessions). |
| netrtg | numeric | Net rating (ortg minus drtg). |
| pts | numeric | Points scored. |
| d_pts | numeric | Points allowed. |
| fga | numeric | Field goal attempts by the lineup. |
| d_fga | numeric | Opponent field goal attempts. |
| fgm | numeric | Field goals made by the lineup. |
| d_fgm | numeric | Opponent field goals made. |
| tpa | numeric | 3-point field goal attempts. |
| d_tpa | numeric | Opponent 3-point attempts. |
| tpm | numeric | 3-point field goals made. |
| d_tpm | numeric | Opponent 3-pointers made. |
| fta | numeric | Free throw attempts by the lineup. |
| d_fta | numeric | Opponent free throw attempts. |
| ftm | numeric | Free throws made by the lineup. |
| d_ftm | numeric | Opponent free throws made. |
| rima | numeric | Rim-area shot attempts. |
| d_rima | numeric | Opponent rim-area attempts. |
| rimm | numeric | Rim-area shots made. |
| d_rimm | numeric | Opponent rim-area shots made. |
| orb | numeric | Offensive rebounds. |
| d_orb | numeric | Opponent offensive rebounds. |
| drb | numeric | Defensive rebounds. |
| d_drb | numeric | Opponent defensive rebounds. |
| blk | numeric | Blocks. |
| d_blk | numeric | Opponent blocks. |
| to | numeric | Turnovers by the lineup. |
| d_to | numeric | Opponent turnovers. |
| ast | numeric | Assists. |
| d_ast | numeric | Opponent assists. |
| e_poss | numeric | Estimated possessions (alternate possession estimator). |
| fg_pct | numeric | Field goal percentage. |
| d_fg_pct | numeric | Opponent field goal percentage. |
| tpp | numeric | 3-point field goal percentage. |
| d_tpp | numeric | Opponent 3-point percentage. |
| ftp | numeric | Free throw percentage. |
| d_ftp | numeric | Opponent free throw percentage. |
| efg_pct | numeric | Effective field goal percentage. |
| d_efg_pct | numeric | Opponent effective field goal percentage. |
| ts_pct | numeric | True shooting percentage. |
| d_ts_pct | numeric | Opponent true shooting percentage. |
| rim_pct | numeric | Rim-area field goal percentage. |
| d_rim_pct | numeric | Opponent rim-area field goal percentage. |
| mid_pct | numeric | Mid-range field goal percentage. |
| d_mid_pct | numeric | Opponent mid-range field goal percentage. |
| tp_rate | numeric | Share of shot attempts taken from 3-point range. |
| d_tp_rate | numeric | Opponent share of shot attempts from 3-point range. |
| rim_rate | numeric | Share of shot attempts taken at the rim. |
| d_rim_rate | numeric | Opponent share of shot attempts at the rim. |
| mid_rate | numeric | Share of shot attempts taken mid-range. |
| d_mid_rate | numeric | Opponent share of shot attempts mid-range. |
| ft_rate | numeric | Free throw rate (FTA per FGA). |
| d_ft_rate | numeric | Opponent free throw rate. |
| ast_rate | numeric | Assist rate. |
| d_ast_rate | numeric | Opponent assist rate. |
| to_rate | numeric | Turnover rate. |
| d_to_rate | numeric | Opponent turnover rate. |
| blk_rate | numeric | Block rate. |
| o_blk_rate | numeric | Offensive possessions ending in a block allowed, as a rate. |
| orb_pct | numeric | Offensive rebound percentage. |
| drb_pct | numeric | Defensive rebound percentage. |
| time_per_poss | numeric | Average seconds per possession. |
| d_time_per_poss | numeric | Opponent average seconds per possession. |
| contest_id | character | Unique stats.ncaa.org contest identifier. |
| home_ncaa_team_id | character | stats.ncaa.org team identifier for the home team. |
| home_espn_team_id | character | ESPN team identifier for the home team. |
| away_ncaa_team_id | character | stats.ncaa.org team identifier for the away team. |
| away_espn_team_id | character | ESPN team identifier for the away team. |
| team_ncaa_team_id | character | stats.ncaa.org team identifier. |
| team_espn_team_id | character | ESPN team identifier. |
| espn_game_id | character | ESPN game identifier crosswalked to this contest. |
| season | integer | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per player-team-season.

|          |           |                                                 |
|----------|-----------|-------------------------------------------------|
| col_name | types     | description                                     |
| season   | integer   | Season identifier (4-digit season-ending year). |
| team     | character | Team name.                                      |
| player   | character | Player name (raw, upper-cased).                 |
| games    | integer   | Games played (season total).                    |

Returns a `hoopR_data` tibble with one row per player-team-season.

|             |           |                                                 |
|-------------|-----------|-------------------------------------------------|
| col_name    | types     | description                                     |
| season      | integer   | Season identifier (4-digit season-ending year). |
| team_id     | character | Unique team identifier.                         |
| team        | character | Team name.                                      |
| player_id   | character | stats.ncaa.org player identifier.               |
| player      | character | Player name (raw, upper-cased).                 |
| clean_name  | character | Cleaned/title-cased display name.               |
| name        | character | Player full display name.                       |
| jersey      | character | Jersey number.                                  |
| class       | character | Class year (e.g. 'Fr.', 'So.', 'Jr.', 'Sr.').   |
| position    | character | Position abbreviation.                          |
| height      | character | Height as a 'feet-inches' string (e.g. '6-1').  |
| ht_inches   | integer   | Height in total inches.                         |
| hometown    | character | Player hometown (city, state).                  |
| high_school | character | Player high school.                             |
| gp          | character | Games played.                                   |
| gs          | character | Games started.                                  |

Returns a `hoopR_data` tibble with one row per game.

|            |           |                                                 |
|------------|-----------|-------------------------------------------------|
| col_name   | types     | description                                     |
| contest_id | character | Unique stats.ncaa.org contest identifier.       |
| game_date  | character | Date the game was played (MM/DD/YYYY).          |
| home       | character | Home team name.                                 |
| away       | character | Away team name.                                 |
| home_score | integer   | Home team score after the event.                |
| away_score | integer   | Away team score after the event.                |
| season     | integer   | Season identifier (4-digit season-ending year). |

Returns a `hoopR_data` tibble with one row per team-season.

|            |           |                                                 |
|------------|-----------|-------------------------------------------------|
| col_name   | types     | description                                     |
| team       | character | Team name.                                      |
| conference | character | Conference affiliation.                         |
| id         | character | stats.ncaa.org team identifier.                 |
| season     | integer   | Season identifier (4-digit season-ending year). |

## Details

League-wide regularized adjusted plus-minus – a single ridge fit over
all Division I stints per season, distinct from
`load_ncaa_mbb_rapm_within_team()`'s within-team fit. Published coverage
runs seasons 2011 through 2026.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_ncaa_mbb_pbp(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_pbp/ncaa_mbb_pbp_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_pbp/ncaa_mbb_pbp_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_shots(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_shots/ncaa_mbb_shots_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_shots/ncaa_mbb_shots_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_lineups(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_lineups/ncaa_mbb_lineups_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_lineups/ncaa_mbb_lineups_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_matchup_stints(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_matchup_stints/ncaa_mbb_matchup_stints_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_matchup_stints/ncaa_mbb_matchup_stints_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_possessions(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_possessions/ncaa_mbb_possessions_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_possessions/ncaa_mbb_possessions_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_rapm_within_team(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm_within_team/ncaa_mbb_rapm_within_team_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_rapm(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm/ncaa_mbb_rapm_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rapm/ncaa_mbb_rapm_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_player_box(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_player_box/ncaa_mbb_player_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_player_box/ncaa_mbb_player_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_team_box(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_box/ncaa_mbb_team_box_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_box/ncaa_mbb_team_box_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_rosters(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rosters/ncaa_mbb_rosters_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_rosters/ncaa_mbb_rosters_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_team_rosters(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_rosters/ncaa_mbb_team_rosters_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_rosters/ncaa_mbb_team_rosters_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_schedule(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_schedule/ncaa_mbb_schedule_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_schedule/ncaa_mbb_schedule_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
# \donttest{
  try(load_ncaa_mbb_team_ids(seasons = most_recent_mbb_season()))
#> Warning: cannot open URL 'https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_ids/ncaa_mbb_team_ids_2027.rds': HTTP status was '404 Not Found'
#> Warning: Failed to readRDS from <https://github.com/sportsdataverse/sportsdataverse-data/releases/download/ncaa_mbb_team_ids/ncaa_mbb_team_ids_2027.rds>
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 0 × 0
# }
```
