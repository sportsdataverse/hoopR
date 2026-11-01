# **Load hoopR NBA Stats Coaches**

Loads season-level NBA coaching staff data scraped from the NBA Stats
API. One row per coach-team-season triple. Backed by the
`hoopR-nba-stats-data` pipeline that reads raw JSONs from
`hoopR-nba-stats-raw` and publishes csv/parquet/rds artifacts to the
`nba_stats_coaches` release tag.

Loads season-level NBA draft picks scraped from the NBA Stats API
(`drafthistory`-style outputs). One row per pick. Backed by the
`hoopR-nba-stats-data` pipeline that reads raw JSONs from
`hoopR-nba-stats-raw` and publishes csv/parquet/rds artifacts to the
`nba_stats_draft` release tag.

Loads the per-event 10-man on-court lineup (5 home + 5 away) scraped
alongside the NBA Stats API play-by-play feed. One row per play-by-play
action, with each player slot's NBA Stats person id. Backed by the
`hoopR-nba-stats-data` pipeline that publishes csv.gz/parquet/rds
artifacts to the `nba_stats_game_lineups` release tag.

Loads the per-game **inactive player** list scraped from the NBA Stats
API – the `InactivePlayers` result set of `boxscoresummaryv2`. One row
per inactive athlete-game pair, not a full per-game roster: use
`load_nba_stats_player_game_logs()` for the athletes who did play.
Backed by the `hoopR-nba-stats-data` pipeline that publishes
csv/parquet/rds artifacts to the `nba_stats_game_rosters` release tag.

Loads season-level 5-man on-court lineup statistics
(`leaguedashlineups`-style outputs, `Base` measure). Backed by the
`hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds artifacts
to the `nba_stats_lineups` release tag. For `Advanced`/`Misc`/`Scoring`/
`Opponent`/`Four Factors` measures and 2/3/4-man groupings, use
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
with `table = "lineups_*"`.

Loads game-level officials data scraped from the NBA Stats API
(`boxscoresummaryv2`-style outputs). One row per official-game pair.
Backed by the `hoopR-nba-stats-data` pipeline that publishes
csv/parquet/rds artifacts to the `nba_stats_officials` release tag.

Loads season-level NBA play-by-play scraped from the NBA Stats API
modern game-feed. One row per play-by-play action, with shot location,
on/off-court lineup joins available via `load_nba_stats_game_lineups()`.
Backed by the `hoopR-nba-stats-data` pipeline that publishes
csv.gz/parquet/rds artifacts to the `nba_stats_pbp` release tag.

Loads per-player per-game box scores scraped from the NBA Stats API
`boxscoretraditionalv3`-style output. One row per athlete-game pair.
Backed by the `hoopR-nba-stats-data` pipeline that publishes
csv/parquet/rds artifacts to the `nba_stats_player_boxscores` release
tag.

Loads per-player per-game logs scraped from
`stats.nba.com/leaguegamelog?PlayerOrTeam=P` (one row per athlete-game
pair: minutes, shooting splits, rebounds, steals, blocks, turnovers,
personal fouls, plus/minus). Backed by the `hoopR-nba-stats-data`
pipeline that publishes csv/parquet/rds artifacts to the
`nba_stats_player_game_logs` release tag.

Loads season-level NBA player statistics (`leaguedashplayerstats`-style
outputs, `Base` measure). Backed by the `hoopR-nba-stats-data` pipeline
that publishes csv/parquet/rds artifacts to the
`nba_stats_player_season_stats` release tag. For
`Advanced`/`Misc`/`Scoring`/`Usage`/`Defense` measures and player
tracking (drives, passing, touches, speed/distance, etc.), use
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
with `table = "player_stats_*"` or `table = "player_tracking_*"`.

Loads possession-level data derived from the NBA Stats API play-by-play
– one row per possession, with the on-court 5-man lineups for both
teams, shooting/rebounding/turnover splits, and the possession start
type. Backed by the `hoopR-nba-stats-data` pipeline that publishes
csv.gz/parquet/rds artifacts to the `nba_stats_possessions` release tag.

Loads season-level NBA team rosters scraped from the NBA Stats API. One
row per athlete-team-season triple. Backed by the `hoopR-nba-stats-data`
pipeline that publishes csv/parquet/rds artifacts to the
`nba_stats_rosters` release tag.

Loads season-level NBA schedules scraped from
`stats.nba.com/leaguegamefinder` (regular season + playoffs combined,
pre-rejoined home/away). Backed by the `hoopR-nba-stats-data` pipeline
that publishes csv/parquet/rds artifacts to the `nba_stats_schedules`
release tag.

Loads shot events scraped from the NBA Stats API. One row per shot
attempt with legacy court coordinates, action/sub type, distance, and
made/missed result, carried through from the play-by-play feed (not
`shotchartdetail`). Backed by the `hoopR-nba-stats-data` pipeline that
publishes csv/parquet/rds artifacts to the `nba_stats_shots` release
tag.

Loads season-level NBA standings (`leaguestandingsv3`-style outputs).
One row per team-season. Backed by the `hoopR-nba-stats-data` pipeline
that publishes csv/parquet/rds artifacts to the `nba_stats_standings`
release tag.

Loads per-team per-game box scores scraped from the NBA Stats API
`boxscoretraditionalv3`-style output. One row per team-game pair. Backed
by the `hoopR-nba-stats-data` pipeline that publishes csv/parquet/rds
artifacts to the `nba_stats_team_boxscores` release tag.

Loads season-level team statistics (`leaguedashteamstats`-style outputs,
`Base` measure). Backed by the `hoopR-nba-stats-data` pipeline that
publishes csv/parquet/rds artifacts to the `nba_stats_team_season_stats`
release tag. For
`Advanced`/`Misc`/`Scoring`/`Defense`/`Opponent`/`Four Factors`
measures, use
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
with `table = "team_stats_*"`.

## Usage

``` r
load_nba_stats_coaches(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_draft(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_game_lineups(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_game_rosters(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_lineups(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_officials(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_pbp(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_player_boxscores(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_player_game_logs(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_player_season_stats(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_possessions(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_rosters(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_schedule(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_shots(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_standings(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_team_boxscores(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_stats_team_season_stats(
  seasons = most_recent_nba_stats_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit years – the season's **START** year (e.g. `2024`
  for the 2024-25 season), matching sportsdataverse-py's
  `load_nba_stats_*` convention (see the file-level note in
  `R/load_nba_stats.R`). Published coverage floors vary by loader (1996
  for most; 2007 for `load_nba_stats_lineups()` – see that function's
  own Description) and run through the most recent season with no gaps.
  Pass `seasons = TRUE` for every published season for that specific
  loader.

- ...:

  Additional arguments passed to an underlying function that writes the
  season data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

Returns a `hoopR_data` tibble with one row per coach-team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique NBA Stats team identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| coach_id | integer | Unique coach identifier. |
| first_name | character | Coach's first name. |
| last_name | character | Coach's last name. |
| coach_name | character | Coach's full name. |
| is_assistant | integer | Whether the coach is an assistant coach (1) or head coach (0). |
| coach_type | character | Coaching role (e.g. 'Head Coach', 'Assistant Coach'). |
| sort_sequence | integer | Display sort order within the coaching staff. |
| sub_sort_sequence | integer | Secondary display sort order within the coaching staff. |
| season_type | character | Portion of the season (e.g. 'Regular Season', 'Playoffs'). |

Returns a `hoopR_data` tibble of NBA draft picks.

|  |  |  |
|----|----|----|
| col_name | types | description |
| person_id | integer | Unique player identifier. |
| player_name | character | Player's name. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| round_number | integer | Draft round number. |
| round_pick | integer | Pick number within the round. |
| overall_pick | integer | Overall pick number. |
| draft_type | character | Draft type ('Draft', 'Undrafted', etc.). |
| team_id | integer | Unique NBA Stats team identifier. |
| team_city | character | Team city or region. |
| team_name | character | Full team display name. |
| team_abbreviation | character | Three-letter team abbreviation. |
| organization | character | Player's college / organization prior to the draft. |
| organization_type | character | Type of organization (e.g. college, international). |
| player_profile_flag | integer | Player profile flag. |

Returns a `hoopR_data` tibble with one row per play-by-play action.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| action_number | integer | Sequential play-by-play action number within the game. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| home_player_1 | integer | Home on-court lineup slot 1 player identifier. |
| home_player_2 | integer | Home on-court lineup slot 2 player identifier. |
| home_player_3 | integer | Home on-court lineup slot 3 player identifier. |
| home_player_4 | integer | Home on-court lineup slot 4 player identifier. |
| home_player_5 | integer | Home on-court lineup slot 5 player identifier. |
| away_player_1 | integer | Away on-court lineup slot 1 player identifier. |
| away_player_2 | integer | Away on-court lineup slot 2 player identifier. |
| away_player_3 | integer | Away on-court lineup slot 3 player identifier. |
| away_player_4 | integer | Away on-court lineup slot 4 player identifier. |
| away_player_5 | integer | Away on-court lineup slot 5 player identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |

Returns a `hoopR_data` tibble with one row per inactive athlete-game
pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_id | integer | Unique player identifier. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| jersey_num | character | Jersey number worn by the player. |
| team_id | integer | Unique NBA Stats team identifier. |
| team_city | character | Team city or region. |
| team_name | character | Full team display name. |
| team_abbreviation | character | Three-letter team abbreviation. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| game_id | character | Unique game identifier. |

Returns a `hoopR_data` tibble of 5-man lineup season stats (182 columns:
standard box-score rate/counting stats plus the 5 player-id slots and
`group_id`/`group_name`). See `names(load_nba_stats_lineups())` for the
full column set, or the `lineups_base` table of
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
for the equivalent parameter-cube asset.

Returns a `hoopR_data` tibble with one row per official-game pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| official_id | integer | Unique official / referee identifier. |
| first_name | character | Official's first name. |
| last_name | character | Official's last name. |
| jersey_num | character | Jersey number worn by the official. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| game_id | character | Unique game identifier. |

Returns a `hoopR_data` tibble of per-event play-by-play rows.

|  |  |  |
|----|----|----|
| col_name | types | description |
| order_index | integer | Play-by-play chronological order index within the game. |
| action_number | integer | Sequential play-by-play action number within the game. |
| clock | character | Game clock remaining in the period. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| team_id | integer | Unique NBA Stats team identifier for the acting team. |
| team_tricode | character | Three-letter team code. |
| person_id | integer | Unique player identifier for the acting player. |
| player_name | character | Acting player's name. |
| player_name_i | character | Acting player's name with abbreviated first initial. |
| x_legacy | integer | Legacy X coordinate on the court (0 = basket center). |
| y_legacy | integer | Legacy Y coordinate on the court (baseline at 0). |
| shot_distance | integer | Shot distance from the basket, in feet (shot events only). |
| shot_result | character | Shot result, 'Made' or 'Missed' (shot events only). |
| is_field_goal | integer | Whether the action is a field goal attempt (1) or not (0). |
| score_home | character | Home team score after the play. |
| score_away | character | Away team score after the play. |
| points_total | integer | Points scored on the action, if any. |
| location | character | Court location code for the action. |
| description | character | Text description of the play. |
| action_type | character | Action type label (e.g. 'Made Shot', 'Missed Shot', 'Rebound'). |
| sub_type | character | Sub type of the action (e.g. 'Jump Shot', 'Layup'). |
| video_available | integer | Whether NBA Stats video is available for the action. |
| shot_value | integer | Points the shot was worth, 2 or 3 (shot events only). |
| action_id | integer | Unique play-by-play action identifier. |
| game_id | character | Unique game identifier. |
| seconds_remaining | numeric | Seconds remaining in the period at the action. |
| event_type | character | Normalized event type label. |
| is_made_shot | logical | Whether the action is a made shot. |
| is_missed_shot | logical | Whether the action is a missed shot. |
| is_free_throw | logical | Whether the action is a free throw. |
| is_rebound | logical | Whether the action is a rebound. |
| is_turnover | logical | Whether the action is a turnover. |
| is_foul | logical | Whether the action is a foul. |
| is_substitution | logical | Whether the action is a substitution. |
| is_jump_ball | logical | Whether the action is a jump ball. |
| is_timeout | logical | Whether the action is a timeout. |
| is_period | logical | Whether the action is a period-boundary marker. |
| possession_number | integer | Sequential possession number within the game. |
| off_player_1 | integer | Offensive on-court lineup slot 1 player identifier. |
| off_player_2 | integer | Offensive on-court lineup slot 2 player identifier. |
| off_player_3 | integer | Offensive on-court lineup slot 3 player identifier. |
| off_player_4 | integer | Offensive on-court lineup slot 4 player identifier. |
| off_player_5 | integer | Offensive on-court lineup slot 5 player identifier. |
| def_player_1 | integer | Defensive on-court lineup slot 1 player identifier. |
| def_player_2 | integer | Defensive on-court lineup slot 2 player identifier. |
| def_player_3 | integer | Defensive on-court lineup slot 3 player identifier. |
| def_player_4 | integer | Defensive on-court lineup slot 4 player identifier. |
| def_player_5 | integer | Defensive on-court lineup slot 5 player identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |

Returns a `hoopR_data` tibble with one row per athlete-game pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique NBA Stats team identifier. |
| team_name | character | Full team display name. |
| team_tricode | character | Three-letter team code. |
| side | character | Whether the team was 'home' or 'away'. |
| person_id | integer | Unique player identifier. |
| first_name | character | Player's first name. |
| family_name | character | Player's family (last) name. |
| name_i | character | Player's name with abbreviated first initial. |
| player_slug | character | URL-safe player name slug. |
| position | character | Player's roster position. |
| comment | character | Reason the player did not play, if applicable (e.g. 'DND - Injury'). |
| jersey_num | character | Jersey number worn by the player. |
| minutes | character | Minutes played, as an `MM:SS` string. |
| field_goals_made | integer | Field goals made. |
| field_goals_attempted | integer | Field goal attempts. |
| field_goals_percentage | numeric | Field goal percentage (0-1). |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_percentage | numeric | Free throw percentage (0-1). |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Assists. |
| steals | integer | Steals. |
| blocks | integer | Blocks. |
| turnovers | integer | Turnovers. |
| fouls_personal | integer | Personal fouls. |
| points | integer | Points scored. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |
| game_id | character | Unique game identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |

Returns a `hoopR_data` tibble of per-athlete per-game log rows.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season_id | character | Unique season identifier string. |
| team_id | integer | Unique NBA Stats team identifier. |
| team_abbreviation | character | Three-letter team abbreviation. |
| team_name | character | Full team display name. |
| game_id | character | Unique game identifier. |
| game_date | character | Date the game was played, as an ISO 'YYYY-MM-DD' string. |
| matchup | character | Matchup string, e.g. 'BOS vs. NYK' or 'BOS @ NYK'. |
| wl | character | Game result, 'W' or 'L'. |
| min | integer | Minutes played. |
| fgm | integer | Field goals made. |
| fga | integer | Field goal attempts. |
| fg_pct | numeric | Field goal percentage (0-1). |
| fg3m | integer | Three-point field goals made. |
| fg3a | integer | Three-point field goal attempts. |
| fg3_pct | numeric | Three-point field goal percentage (0-1). |
| ftm | integer | Free throws made. |
| fta | integer | Free throw attempts. |
| ft_pct | numeric | Free throw percentage (0-1). |
| oreb | integer | Offensive rebounds. |
| dreb | integer | Defensive rebounds. |
| reb | integer | Total rebounds. |
| ast | integer | Assists. |
| stl | integer | Steals. |
| blk | integer | Blocks. |
| tov | integer | Turnovers. |
| pf | integer | Personal fouls. |
| pts | integer | Points scored. |
| plus_minus | integer | Plus/minus point differential while on court. |
| video_available | integer | Whether NBA Stats video is available for the game. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| season_type | character | Portion of the season (e.g. 'Regular Season', 'Playoffs'). |

Returns a `hoopR_data` tibble of player season stats (210 columns: rank
fields, bio fields, and standard/rank box-score rate/counting stats for
the season). See `names(load_nba_stats_player_season_stats())` for the
full column set, or the `player_stats_base` table of
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
for the equivalent parameter-cube asset.

Returns a `hoopR_data` tibble with one row per possession.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| possession_number | integer | Sequential possession number within the game. |
| offense_team_id | integer | Team identifier for the team on offense. |
| defense_team_id | integer | Team identifier for the team on defense. |
| start_order_index | integer | Play-by-play order index at the start of the possession. |
| end_order_index | integer | Play-by-play order index at the end of the possession. |
| start_seconds_remaining | numeric | Seconds remaining in the period at possession start. |
| end_seconds_remaining | numeric | Seconds remaining in the period at possession end. |
| points | integer | Points scored on the possession. |
| is_second_chance | logical | Whether the possession followed an offensive rebound. |
| number_in_period | integer | Sequential possession number within the period. |
| possession_start_type | character | How the possession started (e.g. 'OffDeadball', 'OffRebound'). |
| count_as_possession | logical | Whether the event counts as a scoreable possession. |
| fg2a | integer | 2-point field goal attempts by the lineup. |
| fg2m | integer | 2-point field goals made by the lineup. |
| fg3a | integer | 3-point field goal attempts by the lineup. |
| fg3m | integer | 3-point field goals made by the lineup. |
| fta | integer | Free throw attempts by the lineup. |
| ftm | integer | Free throws made by the lineup. |
| oreb | integer | Offensive rebounds. |
| dreb | integer | Defensive rebounds. |
| tov | integer | Turnovers. |
| off_player_1 | integer | Offensive lineup slot 1 player identifier. |
| off_player_2 | integer | Offensive lineup slot 2 player identifier. |
| off_player_3 | integer | Offensive lineup slot 3 player identifier. |
| off_player_4 | integer | Offensive lineup slot 4 player identifier. |
| off_player_5 | integer | Offensive lineup slot 5 player identifier. |
| def_player_1 | integer | Defensive lineup slot 1 player identifier. |
| def_player_2 | integer | Defensive lineup slot 2 player identifier. |
| def_player_3 | integer | Defensive lineup slot 3 player identifier. |
| def_player_4 | integer | Defensive lineup slot 4 player identifier. |
| def_player_5 | integer | Defensive lineup slot 5 player identifier. |
| lineup_source | character | Provenance of the lineup join (e.g. 'game_lineups', 'derived'). |
| season | integer | Season identifier (4-digit year, END year of the season). |

Returns a `hoopR_data` tibble with one row per athlete-team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique NBA Stats team identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| league_id | character | League identifier ('00' for NBA). |
| player | character | Player's full name. |
| nickname | character | Player's nickname. |
| player_slug | character | URL-safe player name slug. |
| num | character | Jersey number worn by the player. |
| position | character | Player's roster position. |
| height | character | Player's listed height (feet-inches). |
| weight | character | Player's listed weight (lbs). |
| birth_date | character | Player's date of birth. |
| age | numeric | Player's age. |
| exp | character | Years of NBA experience ('R' for rookie). |
| school | character | Player's last college / school attended. |
| player_id | integer | Unique player identifier. |
| how_acquired | character | How the player joined the roster (e.g. 'Draft', 'Trade'). |
| supplemental_status | integer | Roster supplemental / two-way status flag. |
| season_type | character | Portion of the season (e.g. 'Regular Season', 'Playoffs'). |

Returns a `hoopR_data` tibble of per-season schedules, one row per game
with the home/away sides pre-joined into `home_*` / `away_*` columns.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| season_type | character | Portion of the season (e.g. 'Regular Season', 'Playoffs'). |
| game_date | character | Date the game was played, as an ISO 'YYYY-MM-DD' string. |
| matchup | character | Matchup string, home side first (e.g. 'BOS vs. NYK'). |
| home_team_id | integer | Unique NBA Stats team identifier for the home team. |
| home_team_abbreviation | character | Home team abbreviation. |
| home_team_name | character | Home team full name. |
| home_pts | integer | Points scored by the home team. |
| home_wl | character | Home team result, 'W' or 'L'. |
| away_team_id | integer | Unique NBA Stats team identifier for the away team. |
| away_team_abbreviation | character | Away team abbreviation. |
| away_team_name | character | Away team full name. |
| away_pts | integer | Points scored by the away team. |
| away_wl | character | Away team result, 'W' or 'L'. |

Returns a `hoopR_data` tibble with one row per shot attempt.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| clock | character | Game clock remaining in the period. |
| team_id | integer | Unique NBA Stats team identifier for the shooting team. |
| team_tricode | character | Three-letter team code (e.g. 'BOS' / 'NYK'). |
| person_id | integer | Unique player identifier for the shooter. |
| player_name | character | Shooter's name. |
| action_type | character | Action type label ('Made Shot' or 'Missed Shot'). |
| sub_type | character | Shot sub type (e.g. 'Jump Shot', 'Layup', 'Dunk'). |
| shot_result | character | Shot result, 'Made' or 'Missed'. |
| shot_value | integer | Points the shot was worth (2 or 3). |
| shot_distance | integer | Shot distance from the basket, in feet. |
| x_legacy | integer | Legacy X coordinate on the court (0 = basket center). |
| y_legacy | integer | Legacy Y coordinate on the court (baseline at 0). |
| description | character | Text description of the play. |
| score_home | character | Home team score after the play. |
| score_away | character | Away team score after the play. |

Returns a `hoopR_data` tibble of team standings (94 columns: win/ loss
splits by home/road/conference/division/last-10, streak fields, and
points-per-game aggregates). See `names(load_nba_stats_standings())` for
the full column set. The `standings` table of
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
is the equivalent parameter-cube asset (same underlying
`leaguestandingsv3` endpoint).

Returns a `hoopR_data` tibble with one row per team-game pair.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique NBA Stats team identifier. |
| team_name | character | Full team display name. |
| team_tricode | character | Three-letter team code. |
| side | character | Whether the team was 'home' or 'away'. |
| minutes | character | Total minutes played, as an `MM:SS` string. |
| field_goals_made | integer | Field goals made. |
| field_goals_attempted | integer | Field goal attempts. |
| field_goals_percentage | numeric | Field goal percentage (0-1). |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_percentage | numeric | Free throw percentage (0-1). |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| assists | integer | Assists. |
| steals | integer | Steals. |
| blocks | integer | Blocks. |
| turnovers | integer | Turnovers. |
| fouls_personal | integer | Personal fouls. |
| points | integer | Points scored. |
| plus_minus_points | numeric | Plus/minus point differential. |
| game_id | character | Unique game identifier. |
| season | integer | Season identifier (4-digit year, END year of the season). |

Returns a `hoopR_data` tibble of team season stats (178 columns: rank
fields plus standard/rank box-score rate/counting stats for the season).
See `names(load_nba_stats_team_season_stats())` for the full column set,
or the `team_stats_base` table of
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)
for the equivalent parameter-cube asset.

## See also

Other NBA Stats loader functions:
[`load_nba_stats_leaguedash()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_leaguedash.md)

## Examples

``` r
# \donttest{
  try(load_nba_stats_coaches(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 298 × 11
#>       team_id season coach_id first_name last_name coach_name     is_assistant
#>         <int>  <int>    <int> <chr>      <chr>     <chr>                 <int>
#>  1 1610612737   2027   202439 Quin       Snyder    Quin Snyder               1
#>  2 1610612737   2027     2166 Igor       Kokoskov  Igor Kokoskov             2
#>  3 1610612737   2027   202327 Ekpe       Udoh      Ekpe Udoh                 2
#>  4 1610612737   2027   203753 Ronald     Nored     Ronald Nored              2
#>  5 1610612737   2027   204238 Antonio    Lang      Antonio Lang              2
#>  6 1610612737   2027  1626233 Jeff       Watkinson Jeff Watkinson            2
#>  7 1610612737   2027  1628216 Bryan      Bailey    Bryan Bailey              2
#>  8 1610612737   2027  1628852 Ryan       Schmidt   Ryan Schmidt              2
#>  9 1610612737   2027  1641826 Mike       Brey      Mike Brey                 2
#> 10 1610612737   2027  1629239 Sanjay     Lumpkin   Sanjay Lumpkin            2
#> # ℹ 288 more rows
#> # ℹ 4 more variables: coach_type <chr>, sort_sequence <int>,
#> #   sub_sort_sequence <int>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_draft(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 60 × 14
#>    person_id player_name  season round_number round_pick overall_pick draft_type
#>        <int> <chr>         <int>        <int>      <int>        <int> <chr>     
#>  1   1643407 AJ Dybantsa    2027            1          1            1 Draft     
#>  2   1643408 Darryn Pete…   2027            1          2            2 Draft     
#>  3   1643409 Cameron Boo…   2027            1          3            3 Draft     
#>  4   1643410 Caleb Wilson   2027            1          4            4 Draft     
#>  5   1643413 Keaton Wagl…   2027            1          5            5 Draft     
#>  6   1643414 Mikel Brown…   2027            1          6            6 Draft     
#>  7   1643411 Darius Acuf…   2027            1          7            7 Draft     
#>  8   1643412 Kingston Fl…   2027            1          8            8 Draft     
#>  9   1643516 Morez Johns…   2027            1          9            9 Draft     
#> 10   1643415 Brayden Bur…   2027            1         10           10 Draft     
#> # ℹ 50 more rows
#> # ℹ 7 more variables: team_id <int>, team_city <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, organization <chr>, organization_type <chr>,
#> #   player_profile_flag <int>
# }
# \donttest{
  try(load_nba_stats_game_lineups(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 46,651 × 14
#>    game_id    action_number period home_player_1 home_player_2 home_player_3
#>    <chr>              <int>  <int>         <int>         <int>         <int>
#>  1 0022600001             2      1       1628381       1629130       1630595
#>  2 0022600001             4      1       1628381       1629130       1630595
#>  3 0022600001             7      1       1628381       1629130       1630595
#>  4 0022600001             9      1       1628381       1629130       1630595
#>  5 0022600001            10      1       1628381       1629130       1630595
#>  6 0022600001            11      1       1628381       1629130       1630595
#>  7 0022600001            12      1       1628381       1629130       1630595
#>  8 0022600001            13      1       1628381       1629130       1630595
#>  9 0022600001            14      1       1628381       1629130       1630595
#> 10 0022600001            15      1       1628381       1629130       1630595
#> # ℹ 46,641 more rows
#> # ℹ 8 more variables: home_player_4 <int>, home_player_5 <int>,
#> #   away_player_1 <int>, away_player_2 <int>, away_player_3 <int>,
#> #   away_player_4 <int>, away_player_5 <int>, season <int>
# }
# \donttest{
  try(load_nba_stats_game_rosters(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 296 × 11
#>    player_id first_name last_name  jersey_num    team_id team_city  team_name
#>        <int> <chr>      <chr>      <chr>           <int> <chr>      <chr>    
#>  1   1629632 Coby       White      "3   "     1610612766 Charlotte  Hornets  
#>  2   1629684 Grant      Williams   "2   "     1610612766 Charlotte  Hornets  
#>  3   1642369 Michael    Ajayi      "10  "     1610612766 Charlotte  Hornets  
#>  4   1642851 Kon        Knueppel   "7   "     1610612766 Charlotte  Hornets  
#>  5   1643573 Kylan      Boswell    "18  "     1610612766 Charlotte  Hornets  
#>  6   1643590 Felix      Okpara     "34  "     1610612764 Washington Wizards  
#>  7   1630551 Justin     Champagnie "9   "     1610612764 Washington Wizards  
#>  8   1641736 Reece      Beekman    "26  "     1610612764 Washington Wizards  
#>  9   1641774 Tristan    Vukcevic   "00  "     1610612764 Washington Wizards  
#> 10   1642364 Jamir      Watkins    "5   "     1610612764 Washington Wizards  
#> # ℹ 286 more rows
#> # ℹ 4 more variables: team_abbreviation <chr>, season <int>, game_id <chr>,
#> #   season_type_id <chr>
# }
# \donttest{
  try(load_nba_stats_lineups(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 32,000 × 192
#>    group_set group_id     group_name team_id team_abbreviation    gp     w     l
#>    <chr>     <chr>        <chr>        <int> <chr>             <int> <int> <int>
#>  1 Lineups   -203468-162… C. McColl…  1.61e9 ATL                   7     3     4
#>  2 Lineups   -1626157-16… K. Towns …  1.61e9 NYK                   6     2     4
#>  3 Lineups   -1626181-16… N. Powell…  1.61e9 CHI                   6     1     5
#>  4 Lineups   -1626167-16… M. Turner…  1.61e9 MIL                   6     1     5
#>  5 Lineups   -201935-162… J. Harden…  1.61e9 CLE                   6     4     2
#>  6 Lineups   -202691-203… K. Thomps…  1.61e9 MIA                   6     2     4
#>  7 Lineups   -203471-162… D. Schröd…  1.61e9 CHA                   7     3     4
#>  8 Lineups   -1628368-16… D. Fox - …  1.61e9 SAS                   6     4     2
#>  9 Lineups   -1627739-16… K. Dunn -…  1.61e9 LAC                   4     1     3
#> 10 Lineups   -203897-162… Z. LaVine…  1.61e9 SAC                   4     0     4
#> # ℹ 31,990 more rows
#> # ℹ 184 more variables: w_pct <dbl>, min <dbl>, e_off_rating <dbl>,
#> #   off_rating <dbl>, e_def_rating <dbl>, def_rating <dbl>, e_net_rating <dbl>,
#> #   net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>, ast_ratio <dbl>,
#> #   oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>, tm_tov_pct <dbl>,
#> #   efg_pct <dbl>, ts_pct <dbl>, e_pace <dbl>, pace <dbl>, pace_per40 <dbl>,
#> #   poss <int>, pie <dbl>, gp_rank <int>, w_rank <int>, l_rank <int>, …
# }
# \donttest{
  try(load_nba_stats_officials(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 264 × 7
#>    official_id first_name last_name jersey_num season game_id    season_type_id
#>          <int> <chr>      <chr>     <chr>       <int> <chr>      <chr>         
#>  1        2530 Ed         Malloy    "7   "       2027 0022600001 2             
#>  2      202041 Kevin      Scott     "24  "       2027 0022600001 2             
#>  3     1626302 Aaron      Smith     "51  "       2027 0022600001 2             
#>  4      201639 Josh       Tiven     "58  "       2027 0022600002 2             
#>  5      202901 Matt       Myers     "43  "       2027 0022600002 2             
#>  6      203593 Justin     Van Duyne "64  "       2027 0022600002 2             
#>  7      101283 Brian      Forte     "45  "       2027 0022600003 2             
#>  8      202037 J.T.       Orr       "72  "       2027 0022600003 2             
#>  9      202049 Ben        Taylor    "46  "       2027 0022600003 2             
#> 10      202007 Nick       Buchert   "3   "       2027 0022600004 2             
#> # ℹ 254 more rows
# }
# \donttest{
  try(load_nba_stats_pbp(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 46,651 × 49
#>    order_index action_number clock       period   team_id team_tricode person_id
#>          <int>         <int> <chr>        <int>     <int> <chr>            <int>
#>  1           0             2 PT12M00.00S      1    0      ""                   0
#>  2           1             4 PT12M00.00S      1    1.61e9 "DET"          1631105
#>  3           2             7 PT11M48.00S      1    1.61e9 "BOS"          1629011
#>  4           3             9 PT11M48.00S      1    1.61e9 "BOS"          1629011
#>  5           4            10 PT11M32.00S      1    1.61e9 "DET"          1628381
#>  6           5            11 PT11M32.00S      1    1.61e9 "BOS"          1641775
#>  7           6            12 PT11M24.00S      1    1.61e9 "BOS"          1629011
#>  8           7            13 PT11M12.00S      1    1.61e9 "DET"          1629130
#>  9           8            14 PT11M12.00S      1    1.61e9 "DET"          1628381
#> 10           9            15 PT11M09.00S      1    1.61e9 "DET"          1628381
#> # ℹ 46,641 more rows
#> # ℹ 42 more variables: player_name <chr>, player_name_i <chr>, x_legacy <int>,
#> #   y_legacy <int>, shot_distance <int>, shot_result <chr>,
#> #   is_field_goal <int>, score_home <chr>, score_away <chr>,
#> #   points_total <int>, location <chr>, description <chr>, action_type <chr>,
#> #   sub_type <chr>, video_available <int>, shot_value <int>, action_id <int>,
#> #   game_id <chr>, seconds_remaining <dbl>, event_type <chr>, …
# }
# \donttest{
  try(load_nba_stats_player_boxscores(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 2,767 × 37
#>    team_id team_city team_name team_tricode team_slug side  person_id first_name
#>      <int> <chr>     <chr>     <chr>        <chr>     <chr>     <int> <chr>     
#>  1  1.61e9 Detroit   Pistons   DET          pistons   home    1641709 Ausar     
#>  2  1.61e9 Detroit   Pistons   DET          pistons   home    1628381 John      
#>  3  1.61e9 Detroit   Pistons   DET          pistons   home    1631105 Jalen     
#>  4  1.61e9 Detroit   Pistons   DET          pistons   home    1629130 Duncan    
#>  5  1.61e9 Detroit   Pistons   DET          pistons   home    1630595 Cade      
#>  6  1.61e9 Detroit   Pistons   DET          pistons   home    1630198 Isaiah    
#>  7  1.61e9 Detroit   Pistons   DET          pistons   home    1630194 Paul      
#>  8  1.61e9 Detroit   Pistons   DET          pistons   home    1641842 Ronald    
#>  9  1.61e9 Detroit   Pistons   DET          pistons   home    1642450 Daniss    
#> 10  1.61e9 Detroit   Pistons   DET          pistons   home    1628989 Kevin     
#> # ℹ 2,757 more rows
#> # ℹ 29 more variables: family_name <chr>, name_i <chr>, player_slug <chr>,
#> #   position <chr>, comment <chr>, jersey_num <chr>, minutes <chr>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   free_throws_made <int>, free_throws_attempted <int>, …
# }
# \donttest{
  try(load_nba_stats_player_game_logs(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 176 × 31
#>    season_id team_id team_abbreviation team_name game_id game_date matchup wl   
#>    <chr>       <int> <chr>             <chr>     <chr>   <chr>     <chr>   <chr>
#>  1 22026      1.61e9 BOS               Boston C… 002260… 2026-10-… BOS @ … L    
#>  2 22026      1.61e9 DET               Detroit … 002260… 2026-10-… DET vs… W    
#>  3 22026      1.61e9 SAS               San Anto… 002260… 2026-10-… SAS vs… L    
#>  4 22026      1.61e9 OKC               Oklahoma… 002260… 2026-10-… OKC @ … W    
#>  5 22026      1.61e9 NYK               New York… 002260… 2026-10-… NYK vs… L    
#>  6 22026      1.61e9 PHI               Philadel… 002260… 2026-10-… PHI @ … W    
#>  7 22026      1.61e9 MIL               Milwauke… 002260… 2026-10-… MIL @ … L    
#>  8 22026      1.61e9 ATL               Atlanta … 002260… 2026-10-… ATL @ … W    
#>  9 22026      1.61e9 ORL               Orlando … 002260… 2026-10-… ORL vs… L    
#> 10 22026      1.61e9 CHA               Charlott… 002260… 2026-10-… CHA @ … W    
#> # ℹ 166 more rows
#> # ℹ 23 more variables: min <int>, fgm <int>, fga <int>, fg_pct <dbl>,
#> #   fg3m <int>, fg3a <int>, fg3_pct <dbl>, ftm <int>, fta <int>, ft_pct <dbl>,
#> #   oreb <int>, dreb <int>, reb <int>, ast <int>, stl <int>, blk <int>,
#> #   tov <int>, pf <int>, pts <int>, plus_minus <int>, video_available <int>,
#> #   season <int>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_player_season_stats(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 5,292 × 212
#>    player_id player_name   nickname  team_id team_abbreviation   age    gp     w
#>        <int> <chr>         <chr>       <int> <chr>             <dbl> <int> <int>
#>  1   1643407 AJ Dybantsa   AJ         1.61e9 WAS                  19     2     1
#>  2   1631260 AJ Green      AJ         1.61e9 MIL                  27     6     1
#>  3   1642358 AJ Johnson    AJ         1.61e9 NOP                  21     1     1
#>  4    203932 Aaron Gordon  Aaron      1.61e9 DEN                  31     5     3
#>  5   1630174 Aaron Nesmith Aaron      1.61e9 IND                  27     5     1
#>  6   1630598 Aaron Wiggins Aaron      1.61e9 ATL                  27     7     3
#>  7   1642846 Ace Bailey    Ace        1.61e9 UTA                  20     6     1
#>  8   1643530 Aday Mara     Aday       1.61e9 OKC                  21     6     4
#>  9   1641737 Adem Bona     Adem       1.61e9 PHI                  23     7     6
#> 10   1642349 Ajay Mitchell Ajay       1.61e9 OKC                  24     6     4
#> # ℹ 5,282 more rows
#> # ℹ 204 more variables: l <int>, w_pct <dbl>, min <dbl>, e_off_rating <dbl>,
#> #   off_rating <dbl>, sp_work_off_rating <dbl>, e_def_rating <dbl>,
#> #   def_rating <dbl>, sp_work_def_rating <dbl>, e_net_rating <dbl>,
#> #   net_rating <dbl>, sp_work_net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>,
#> #   ast_ratio <dbl>, oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>,
#> #   tm_tov_pct <dbl>, e_tov_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>, …
# }
# \donttest{
  try(load_nba_stats_possessions(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 17,810 × 35
#>    game_id    period possession_number offense_team_id defense_team_id
#>    <chr>       <int>             <int>           <int>           <int>
#>  1 0022600001      1                 1      1610612738      1610612765
#>  2 0022600001      1                 2      1610612765      1610612738
#>  3 0022600001      1                 3      1610612738      1610612765
#>  4 0022600001      1                 4      1610612765      1610612738
#>  5 0022600001      1                 5      1610612738      1610612765
#>  6 0022600001      1                 6      1610612765      1610612738
#>  7 0022600001      1                 7      1610612738      1610612765
#>  8 0022600001      1                 8      1610612765      1610612738
#>  9 0022600001      1                 9      1610612738      1610612765
#> 10 0022600001      1                10      1610612765      1610612738
#> # ℹ 17,800 more rows
#> # ℹ 30 more variables: start_order_index <int>, end_order_index <int>,
#> #   start_seconds_remaining <dbl>, end_seconds_remaining <dbl>, points <int>,
#> #   is_second_chance <lgl>, number_in_period <int>,
#> #   possession_start_type <chr>, count_as_possession <lgl>, fg2a <int>,
#> #   fg2m <int>, fg3a <int>, fg3m <int>, fta <int>, ftm <int>, oreb <int>,
#> #   dreb <int>, tov <int>, off_player_1 <int>, off_player_2 <int>, …
# }
# \donttest{
  try(load_nba_stats_rosters(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 524 × 18
#>       team_id season league_id player nickname player_slug num   position height
#>         <int>  <int> <chr>     <chr>  <chr>    <chr>       <chr> <chr>    <chr> 
#>  1 1610612737   2027 00        Lugue… Luguentz luguentz-d… 0     G        6-4   
#>  2 1610612737   2027 00        RayJ … RayJ     rayj-dennis 00    G        6-1   
#>  3 1610612737   2027 00        Kesho… Keshon   keshon-gil… 00    G        6-3   
#>  4 1610612737   2027 00        Jalen… Jalen    jalen-john… 1     F        6-8   
#>  5 1610612737   2027 00        Aaron… Aaron    aaron-wigg… 2     G        6-5   
#>  6 1610612737   2027 00        CJ Mc… CJ       cj-mccollum 3     G        6-2   
#>  7 1610612737   2027 00        Kings… Kingston kingston-f… 4     G        6-3   
#>  8 1610612737   2027 00        Dyson… Dyson    dyson-dani… 5     G        6-7   
#>  9 1610612737   2027 00        Nicke… Nickeil  nickeil-al… 7     G        6-5   
#> 10 1610612737   2027 00        Doria… Dorian   dorian-fin… 8     F        6-7   
#> # ℹ 514 more rows
#> # ℹ 9 more variables: weight <chr>, birth_date <chr>, age <dbl>, exp <chr>,
#> #   school <chr>, player_id <int>, how_acquired <chr>,
#> #   supplemental_status <int>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_schedule(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 1,274 × 15
#>    game_id    season season_type game_date  matchup     home_team_id
#>    <chr>       <int> <chr>       <chr>      <chr>              <int>
#>  1 0012600001   2027 preseason   2026-10-08 MIA vs. NOP   1610612748
#>  2 0012600002   2027 preseason   2026-10-10 MIA vs. MIN   1610612748
#>  3 0012600003   2027 preseason   2026-10-14 MIA vs. BKN   1610612748
#>  4 0012600004   2027 preseason   2026-10-05 ATL vs. MEM   1610612737
#>  5 0012600005   2027 preseason   2026-10-08 SAS vs. ATL   1610612759
#>  6 0012600006   2027 preseason   2026-10-10 IND vs. ATL   1610612754
#>  7 0012600007   2027 preseason   2026-10-12 ATL vs. OKC   1610612737
#>  8 0012600008   2027 preseason   2026-10-16 DAL vs. ATL   1610612742
#>  9 0012600009   2027 preseason   2026-10-03 TOR vs. MIA   1610612761
#> 10 0012600010   2027 preseason   2026-10-06 GSW vs. LAL   1610612744
#> # ℹ 1,264 more rows
#> # ℹ 9 more variables: home_team_abbreviation <chr>, home_team_name <chr>,
#> #   home_pts <int>, home_wl <chr>, away_team_id <int>,
#> #   away_team_abbreviation <chr>, away_team_name <chr>, away_pts <int>,
#> #   away_wl <chr>
# }
# \donttest{
  try(load_nba_stats_shots(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 15,585 × 19
#>    game_id    season season_type_id period clock  team_id team_tricode person_id
#>    <chr>       <int> <chr>           <int> <chr>    <int> <chr>            <int>
#>  1 0022600001   2027 2                   1 PT11M…  1.61e9 DET            1628381
#>  2 0022600001   2027 2                   1 PT11M…  1.61e9 DET            1629130
#>  3 0022600001   2027 2                   1 PT11M…  1.61e9 DET            1628381
#>  4 0022600001   2027 2                   1 PT10M…  1.61e9 DET            1631105
#>  5 0022600001   2027 2                   1 PT10M…  1.61e9 BOS            1628369
#>  6 0022600001   2027 2                   1 PT10M…  1.61e9 DET            1631105
#>  7 0022600001   2027 2                   1 PT09M…  1.61e9 BOS            1628401
#>  8 0022600001   2027 2                   1 PT09M…  1.61e9 BOS             202331
#>  9 0022600001   2027 2                   1 PT09M…  1.61e9 DET            1629130
#> 10 0022600001   2027 2                   1 PT08M…  1.61e9 DET            1631105
#> # ℹ 15,575 more rows
#> # ℹ 11 more variables: player_name <chr>, action_type <chr>, sub_type <chr>,
#> #   shot_result <chr>, shot_value <int>, shot_distance <int>, x_legacy <int>,
#> #   y_legacy <int>, description <chr>, score_home <chr>, score_away <chr>
# }
# \donttest{
  try(load_nba_stats_standings(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 30 × 94
#>    league_id season_id    team_id team_city     team_name   team_slug conference
#>    <chr>     <chr>          <int> <chr>         <chr>       <chr>     <chr>     
#>  1 00        22026     1610612755 Philadelphia  76ers       sixers    East      
#>  2 00        22026     1610612763 Memphis       Grizzlies   grizzlies West      
#>  3 00        22026     1610612765 Detroit       Pistons     pistons   East      
#>  4 00        22026     1610612745 Houston       Rockets     rockets   West      
#>  5 00        22026     1610612738 Boston        Celtics     celtics   East      
#>  6 00        22026     1610612757 Portland      Trail Blaz… blazers   West      
#>  7 00        22026     1610612739 Cleveland     Cavaliers   cavaliers East      
#>  8 00        22026     1610612747 Los Angeles   Lakers      lakers    West      
#>  9 00        22026     1610612760 Oklahoma City Thunder     thunder   West      
#> 10 00        22026     1610612761 Toronto       Raptors     raptors   East      
#> # ℹ 20 more rows
#> # ℹ 87 more variables: conference_record <chr>, playoff_rank <int>,
#> #   clinch_indicator <chr>, division <chr>, division_record <chr>,
#> #   division_rank <int>, wins <int>, losses <int>, win_pct <dbl>,
#> #   league_rank <int>, record <chr>, home <chr>, road <chr>, l10 <chr>,
#> #   last10_home <chr>, last10_road <chr>, ot <chr>, three_pts_or_less <chr>,
#> #   ten_pts_or_more <chr>, long_home_streak <int>, …
# }
# \donttest{
  try(load_nba_stats_team_boxscores(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 178 × 29
#>       team_id team_city     team_name    team_tricode team_slug    side  minutes
#>         <int> <chr>         <chr>        <chr>        <chr>        <chr> <chr>  
#>  1 1610612765 Detroit       Pistons      DET          pistons      home  240:00 
#>  2 1610612738 Boston        Celtics      BOS          celtics      away  240:00 
#>  3 1610612752 New York      Knicks       NYK          knicks       home  240:00 
#>  4 1610612755 Philadelphia  76ers        PHI          sixers       away  240:00 
#>  5 1610612759 San Antonio   Spurs        SAS          spurs        home  240:00 
#>  6 1610612760 Oklahoma City Thunder      OKC          thunder      away  240:00 
#>  7 1610612748 Miami         Heat         MIA          heat         home  240:00 
#>  8 1610612750 Minnesota     Timberwolves MIN          timberwolves away  240:00 
#>  9 1610612747 Los Angeles   Lakers       LAL          lakers       home  240:00 
#> 10 1610612744 Golden State  Warriors     GSW          warriors     away  240:00 
#> # ℹ 168 more rows
#> # ℹ 22 more variables: field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   free_throws_made <int>, free_throws_attempted <int>,
#> #   free_throws_percentage <dbl>, rebounds_offensive <int>,
#> #   rebounds_defensive <int>, rebounds_total <int>, assists <int>, …
# }
# \donttest{
  try(load_nba_stats_team_season_stats(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.2.0 ──
#> # A tibble: 420 × 188
#>       team_id team_name       gp     w     l w_pct   min e_off_rating off_rating
#>         <int> <chr>        <int> <int> <int> <dbl> <dbl>        <dbl>      <dbl>
#>  1 1610612737 Atlanta Haw…     7     3     4 0.429   336         110        112.
#>  2 1610612738 Boston Celt…     5     4     1 0.8     245         115.       118 
#>  3 1610612751 Brooklyn Ne…     5     0     5 0       245         103.       105.
#>  4 1610612766 Charlotte H…     7     3     4 0.429   336          99        101.
#>  5 1610612741 Chicago Bul…     6     1     5 0.167   288         104.       106.
#>  6 1610612739 Cleveland C…     6     4     2 0.667   293         114.       116.
#>  7 1610612742 Dallas Mave…     6     4     2 0.667   288         112        114.
#>  8 1610612743 Denver Nugg…     5     3     2 0.6     245         112.       112.
#>  9 1610612765 Detroit Pis…     6     5     1 0.833   288         109.       111.
#> 10 1610612744 Golden Stat…     6     3     3 0.5     288         114.       116.
#> # ℹ 410 more rows
#> # ℹ 179 more variables: e_def_rating <dbl>, def_rating <dbl>,
#> #   e_net_rating <dbl>, net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>,
#> #   ast_ratio <dbl>, oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>,
#> #   tm_tov_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>, e_pace <dbl>, pace <dbl>,
#> #   pace_per40 <dbl>, poss <int>, pie <dbl>, gp_rank <int>, w_rank <int>,
#> #   l_rank <int>, w_pct_rank <int>, min_rank <int>, off_rating_rank <int>, …
# }
```
