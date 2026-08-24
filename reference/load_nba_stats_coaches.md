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
  for the 2024-25 season), matching sdv-py's `load_nba_stats_*`
  convention (see the file-level note in `R/load_nba_stats.R`).
  Published coverage floors vary by loader (1996 for most; 2007 for
  `load_nba_stats_lineups()` – see that function's own Description) and
  run through the most recent season with no gaps. Pass `seasons = TRUE`
  for every published season for that specific loader.

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
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 267 × 11
#>       team_id season coach_id first_name last_name coach_name     is_assistant
#>         <int>  <int>    <int> <chr>      <chr>     <chr>                 <int>
#>  1 1610612737   2026   202439 Quin       Snyder    Quin Snyder               1
#>  2 1610612737   2026   203753 Ronald     Nored     Ronald Nored              2
#>  3 1610612737   2026   204238 Antonio    Lang      Antonio Lang              2
#>  4 1610612737   2026  1626233 Jeff       Watkinson Jeff Watkinson            2
#>  5 1610612737   2026     2166 Igor       Kokoskov  Igor Kokoskov             2
#>  6 1610612737   2026   202327 Ekpe       Udoh      Ekpe Udoh                 2
#>  7 1610612737   2026  1628216 Bryan      Bailey    Bryan Bailey              2
#>  8 1610612737   2026  1628852 Ryan       Schmidt   Ryan Schmidt              2
#>  9 1610612737   2026  1629239 Sanjay     Lumpkin   Sanjay Lumpkin            2
#> 10 1610612737   2026  1641826 Mike       Brey      Mike Brey                 2
#> # ℹ 257 more rows
#> # ℹ 4 more variables: coach_type <chr>, sort_sequence <int>,
#> #   sub_sort_sequence <int>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_draft(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 59 × 14
#>    person_id player_name  season round_number round_pick overall_pick draft_type
#>        <int> <chr>         <int>        <int>      <int>        <int> <chr>     
#>  1   1642843 Cooper Flagg   2026            1          1            1 Draft     
#>  2   1642844 Dylan Harper   2026            1          2            2 Draft     
#>  3   1642845 VJ Edgecombe   2026            1          3            3 Draft     
#>  4   1642851 Kon Knueppel   2026            1          4            4 Draft     
#>  5   1642846 Ace Bailey     2026            1          5            5 Draft     
#>  6   1642848 Tre Johnson    2026            1          6            6 Draft     
#>  7   1642847 Jeremiah Fe…   2026            1          7            7 Draft     
#>  8   1642856 Egor Dëmin     2026            1          8            8 Draft     
#>  9   1642867 Collin Murr…   2026            1          9            9 Draft     
#> 10   1642863 Khaman Malu…   2026            1         10           10 Draft     
#> # ℹ 49 more rows
#> # ℹ 7 more variables: team_id <int>, team_city <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, organization <chr>, organization_type <chr>,
#> #   player_profile_flag <int>
# }
# \donttest{
  try(load_nba_stats_game_lineups(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 707,440 × 14
#>    game_id    action_number period home_player_1 home_player_2 home_player_3
#>    <chr>              <int>  <int>         <int>         <int>         <int>
#>  1 0012500001             2      1       1629020       1629028       1629060
#>  2 0012500001             4      1       1629020       1629028       1629060
#>  3 0012500001             7      1       1629020       1629028       1629060
#>  4 0012500001             8      1       1629020       1629028       1629060
#>  5 0012500001             9      1       1629020       1629028       1629060
#>  6 0012500001            10      1       1629020       1629028       1629060
#>  7 0012500001            11      1       1629020       1629028       1629060
#>  8 0012500001            13      1       1629020       1629028       1629060
#>  9 0012500001            13      1       1629020       1629028       1629060
#> 10 0012500001            15      1       1629020       1629028       1629060
#> # ℹ 707,430 more rows
#> # ℹ 8 more variables: home_player_4 <int>, home_player_5 <int>,
#> #   away_player_1 <int>, away_player_2 <int>, away_player_3 <int>,
#> #   away_player_4 <int>, away_player_5 <int>, season <int>
# }
# \donttest{
  try(load_nba_stats_game_rosters(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 156 × 10
#>    player_id first_name last_name jersey_num    team_id team_city     team_name
#>        <int> <chr>      <chr>     <chr>           <int> <chr>         <chr>    
#>  1   1627832 Fred       VanVleet  "5   "     1610612745 Houston       Rockets  
#>  2   1642384 Isaiah     Crawford  "24  "     1610612745 Houston       Rockets  
#>  3   1642850 Thomas     Sorber    "12  "     1610612760 Oklahoma City Thunder  
#>  4   1629026 Kenrich    Williams  "34  "     1610612760 Oklahoma City Thunder  
#>  5   1630198 Isaiah     Joe       "11  "     1610612760 Oklahoma City Thunder  
#>  6   1631114 Jalen      Williams  "8   "     1610612760 Oklahoma City Thunder  
#>  7   1642260 Nikola     Topic     "44  "     1610612760 Oklahoma City Thunder  
#>  8   1642382 Branden    Carlson   "15  "     1610612760 Oklahoma City Thunder  
#>  9      2544 LeBron     James     "23  "     1610612747 Los Angeles   Lakers   
#> 10   1628467 Maxi       Kleber    "14  "     1610612747 Los Angeles   Lakers   
#> # ℹ 146 more rows
#> # ℹ 3 more variables: team_abbreviation <chr>, season <int>, game_id <chr>
# }
# \donttest{
  try(load_nba_stats_lineups(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 48,188 × 182
#>    group_set group_id     group_name team_id team_abbreviation    gp     w     l
#>    <chr>     <chr>        <chr>        <int> <chr>             <int> <int> <int>
#>  1 Lineups   -1626157-16… K. Towns …  1.61e9 NYK                  17    14     3
#>  2 Lineups   -1628368-16… D. Fox - …  1.61e9 SAS                  20    11     9
#>  3 Lineups   -201935-162… J. Harden…  1.61e9 CLE                  16     7     9
#>  4 Lineups   -202699-162… T. Harris…  1.61e9 DET                  12     6     6
#>  5 Lineups   -201935-162… J. Harden…  1.61e9 CLE                  16     8     8
#>  6 Lineups   -202331-203… P. George…  1.61e9 PHI                   7     3     4
#>  7 Lineups   -1630578-16… A. Sengun…  1.61e9 HOU                   6     2     4
#>  8 Lineups   -2544-20393… L. James …  1.61e9 LAL                   9     4     5
#>  9 Lineups   -203468-162… C. McColl…  1.61e9 ATL                   6     2     4
#> 10 Lineups   -2544-20393… L. James …  1.61e9 LAL                   6     1     5
#> # ℹ 48,178 more rows
#> # ℹ 174 more variables: w_pct <dbl>, min <dbl>, e_off_rating <dbl>,
#> #   off_rating <dbl>, e_def_rating <dbl>, def_rating <dbl>, e_net_rating <dbl>,
#> #   net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>, ast_ratio <dbl>,
#> #   oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>, tm_tov_pct <dbl>,
#> #   efg_pct <dbl>, ts_pct <dbl>, e_pace <dbl>, pace <dbl>, pace_per40 <dbl>,
#> #   poss <int>, pie <dbl>, gp_rank <int>, w_rank <int>, l_rank <int>, …
# }
# \donttest{
  try(load_nba_stats_officials(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 260 × 6
#>    official_id first_name last_name  jersey_num season game_id   
#>          <int> <chr>      <chr>      <chr>       <int> <chr>     
#>  1        2534 Zach       Zarba      "15  "       2026 0022500001
#>  2      200833 Eric       Dalen      "37  "       2026 0022500001
#>  3     1626301 Jason      Goldenberg "35  "       2026 0022500001
#>  4        1155 JB         DeRosa     "14  "       2026 0022500002
#>  5      204059 Tyler      Ford       "39  "       2026 0022500002
#>  6     1627963 Phenizee   Ransom     "70  "       2026 0022500002
#>  7        2882 Sean       Wright     "4   "       2026 0022500423
#>  8     1627524 Nate       Green      "41  "       2026 0022500423
#>  9     1628954 Jenna      Schroeder  "20  "       2026 0022500423
#> 10      101283 Brian      Forte      "45  "       2026 0042500101
#> # ℹ 250 more rows
# }
# \donttest{
  try(load_nba_stats_pbp(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 707,440 × 49
#>    order_index action_number clock       period   team_id team_tricode person_id
#>          <int>         <int> <chr>        <int>     <int> <chr>            <int>
#>  1           0             2 PT12M00.00S      1    0      ""                   0
#>  2           1             4 PT12M00.00S      1    1.61e9 "LAL"          1629028
#>  3           2             7 PT11M38.00S      1    1.61e9 "LAL"          1630559
#>  4           3             8 PT11M35.00S      1    1.61e9 "LAL"          1631222
#>  5           4             9 PT11M29.00S      1    1.61e9 "LAL"          1629060
#>  6           5            10 PT11M26.00S      1    1.61e9 "LAL"          1629028
#>  7           6            11 PT11M25.00S      1    1.61e9 "LAL"          1630559
#>  8           7            13 PT11M07.00S      1    1.61e9 "PHX"          1626164
#>  9           8            13 PT11M07.00S      1    1.61e9 "LAL"          1629020
#> 10           9            15 PT11M02.00S      1    1.61e9 "LAL"          1629028
#> # ℹ 707,430 more rows
#> # ℹ 42 more variables: player_name <chr>, player_name_i <chr>, x_legacy <int>,
#> #   y_legacy <int>, shot_distance <int>, shot_result <chr>,
#> #   is_field_goal <int>, score_home <chr>, score_away <chr>,
#> #   points_total <int>, location <chr>, description <chr>, action_type <chr>,
#> #   sub_type <chr>, video_available <int>, shot_value <int>, action_id <int>,
#> #   game_id <chr>, seconds_remaining <dbl>, event_type <chr>, …
# }
# \donttest{
  try(load_nba_stats_player_boxscores(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 34,587 × 34
#>     team_id team_name team_tricode side  person_id first_name family_name name_i
#>       <int> <chr>     <chr>        <chr>     <int> <chr>      <chr>       <chr> 
#>  1   1.61e9 Thunder   OKC          home    1629652 Luguentz   Dort        L. Do…
#>  2   1.61e9 Thunder   OKC          home    1631096 Chet       Holmgren    C. Ho…
#>  3   1.61e9 Thunder   OKC          home    1628392 Isaiah     Hartenstein I. Ha…
#>  4   1.61e9 Thunder   OKC          home    1641717 Cason      Wallace     C. Wa…
#>  5   1.61e9 Thunder   OKC          home    1628983 Shai       Gilgeous-A… S. Gi…
#>  6   1.61e9 Thunder   OKC          home    1631119 Jaylin     Williams    J. Wi…
#>  7   1.61e9 Thunder   OKC          home    1630598 Aaron      Wiggins     A. Wi…
#>  8   1.61e9 Thunder   OKC          home    1627936 Alex       Caruso      A. Ca…
#>  9   1.61e9 Thunder   OKC          home    1642964 Brooks     Barnhizer   B. Ba…
#> 10   1.61e9 Thunder   OKC          home    1642349 Ajay       Mitchell    A. Mi…
#> # ℹ 34,577 more rows
#> # ℹ 26 more variables: player_slug <chr>, position <chr>, comment <chr>,
#> #   jersey_num <chr>, minutes <chr>, field_goals_made <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   three_pointers_made <int>, three_pointers_attempted <int>,
#> #   three_pointers_percentage <dbl>, free_throws_made <int>,
#> #   free_throws_attempted <int>, free_throws_percentage <dbl>, …
# }
# \donttest{
  try(load_nba_stats_player_game_logs(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 2,630 × 31
#>    season_id team_id team_abbreviation team_name game_id game_date matchup wl   
#>    <chr>       <int> <chr>             <chr>     <chr>   <chr>     <chr>   <chr>
#>  1 42025      1.61e9 HOU               Houston … 004250… 2026-04-… HOU @ … L    
#>  2 42025      1.61e9 DEN               Denver N… 004250… 2026-04-… DEN vs… W    
#>  3 42025      1.61e9 ATL               Atlanta … 004250… 2026-04-… ATL @ … L    
#>  4 42025      1.61e9 NYK               New York… 004250… 2026-04-… NYK vs… W    
#>  5 42025      1.61e9 TOR               Toronto … 004250… 2026-04-… TOR @ … L    
#>  6 42025      1.61e9 MIN               Minnesot… 004250… 2026-04-… MIN @ … L    
#>  7 42025      1.61e9 LAL               Los Ange… 004250… 2026-04-… LAL vs… W    
#>  8 42025      1.61e9 CLE               Clevelan… 004250… 2026-04-… CLE vs… W    
#>  9 42025      1.61e9 DET               Detroit … 004250… 2026-04-… DET vs… L    
#> 10 42025      1.61e9 BOS               Boston C… 004250… 2026-04-… BOS vs… W    
#> # ℹ 2,620 more rows
#> # ℹ 23 more variables: min <int>, fgm <int>, fga <int>, fg_pct <dbl>,
#> #   fg3m <int>, fg3a <int>, fg3_pct <dbl>, ftm <int>, fta <int>, ft_pct <dbl>,
#> #   oreb <int>, dreb <int>, reb <int>, ast <int>, stl <int>, blk <int>,
#> #   tov <int>, pf <int>, pts <int>, plus_minus <int>, video_available <int>,
#> #   season <int>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_player_season_stats(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 9,744 × 210
#>    player_id player_name    nickname team_id team_abbreviation   age    gp     w
#>        <int> <chr>          <chr>      <int> <chr>             <dbl> <int> <int>
#>  1   1630639 A.J. Lawson    A.J.      1.61e9 TOR                  25     7     3
#>  2    203932 Aaron Gordon   Aaron     1.61e9 DEN                  30     3     1
#>  3   1628988 Aaron Holiday  Aaron     1.61e9 HOU                  29     6     2
#>  4   1630598 Aaron Wiggins  Aaron     1.61e9 OKC                  27    13    10
#>  5   1641737 Adem Bona      Adem      1.61e9 PHI                  23    10     3
#>  6   1642876 Adou Thiero    Adou      1.61e9 LAL                  22     6     1
#>  7   1642349 Ajay Mitchell  Ajay      1.61e9 OKC                  24    11    10
#>  8   1627936 Alex Caruso    Alex      1.61e9 OKC                  32    15    11
#>  9   1630578 Alperen Sengun Alperen   1.61e9 HOU                  23     6     2
#> 10   1642873 Amari Williams Amari     1.61e9 BOS                  24     1     0
#> # ℹ 9,734 more rows
#> # ℹ 202 more variables: l <int>, w_pct <dbl>, min <dbl>, e_off_rating <dbl>,
#> #   off_rating <dbl>, sp_work_off_rating <dbl>, e_def_rating <dbl>,
#> #   def_rating <dbl>, sp_work_def_rating <dbl>, e_net_rating <dbl>,
#> #   net_rating <dbl>, sp_work_net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>,
#> #   ast_ratio <dbl>, oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>,
#> #   tm_tov_pct <dbl>, e_tov_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>, …
# }
# \donttest{
  try(load_nba_stats_possessions(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 278,341 × 35
#>    game_id    period possession_number offense_team_id defense_team_id
#>    <chr>       <int>             <int>           <int>           <int>
#>  1 0012500001      1                 1      1610612747      1610612756
#>  2 0012500001      1                 2      1610612756      1610612747
#>  3 0012500001      1                 3      1610612747      1610612756
#>  4 0012500001      1                 4      1610612756      1610612747
#>  5 0012500001      1                 5      1610612747      1610612756
#>  6 0012500001      1                 6      1610612756      1610612747
#>  7 0012500001      1                 7      1610612747      1610612756
#>  8 0012500001      1                 8      1610612756      1610612747
#>  9 0012500001      1                 9      1610612747      1610612756
#> 10 0012500001      1                10      1610612756      1610612747
#> # ℹ 278,331 more rows
#> # ℹ 30 more variables: start_order_index <int>, end_order_index <int>,
#> #   start_seconds_remaining <dbl>, end_seconds_remaining <dbl>, points <int>,
#> #   is_second_chance <lgl>, number_in_period <int>,
#> #   possession_start_type <chr>, count_as_possession <lgl>, fg2a <int>,
#> #   fg2m <int>, fg3a <int>, fg3m <int>, fta <int>, ftm <int>, oreb <int>,
#> #   dreb <int>, tov <int>, off_player_1 <int>, off_player_2 <int>, …
# }
# \donttest{
  try(load_nba_stats_rosters(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 495 × 17
#>       team_id season league_id player nickname player_slug num   position height
#>         <int>  <int> <chr>     <chr>  <chr>    <chr>       <chr> <chr>    <chr> 
#>  1 1610612737   2026 00        Kesho… Keshon   keshon-gil… NA    G        6-4   
#>  2 1610612737   2026 00        RayJ … RayJ     rayj-dennis 00    G        6-1   
#>  3 1610612737   2026 00        Jonat… Jonathan jonathan-k… 0     F        6-7   
#>  4 1610612737   2026 00        Jalen… Jalen    jalen-john… 1     F        6-8   
#>  5 1610612737   2026 00        Keato… Keaton   keaton-wal… 2     G        6-3   
#>  6 1610612737   2026 00        CJ Mc… CJ       cj-mccollum 3     G        6-3   
#>  7 1610612737   2026 00        Gabe … Gabe     gabe-vince… 4     G        6-2   
#>  8 1610612737   2026 00        Dyson… Dyson    dyson-dani… 5     G        6-7   
#>  9 1610612737   2026 00        Nicke… Nickeil  nickeil-al… 7     G        6-5   
#> 10 1610612737   2026 00        Buddy… Buddy    buddy-hield 8     G        6-4   
#> # ℹ 485 more rows
#> # ℹ 8 more variables: weight <chr>, birth_date <chr>, age <dbl>, exp <chr>,
#> #   school <chr>, player_id <int>, how_acquired <chr>, season_type <chr>
# }
# \donttest{
  try(load_nba_stats_schedule(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 1,400 × 15
#>    game_id    season season_type game_date  matchup     home_team_id
#>    <chr>       <int> <chr>       <chr>      <chr>              <int>
#>  1 0012500001   2026 preseason   2025-10-03 LAL vs. PHX   1610612747
#>  2 0012500002   2026 preseason   2025-10-06 MIA vs. MIL   1610612748
#>  3 0012500003   2026 preseason   2025-10-08 MIA vs. SAS   1610612748
#>  4 0012500004   2026 preseason   2025-10-12 LAL vs. GSW   1610612747
#>  5 0012500005   2026 preseason   2025-10-15 LAL vs. DAL   1610612747
#>  6 0012500006   2026 preseason   2025-10-17 MIA vs. MEM   1610612748
#>  7 0012500007   2026 preseason   2025-10-17 LAL vs. SAC   1610612747
#>  8 0012500008   2026 preseason   2025-10-02 NYK vs. PHI   1610612752
#>  9 0012500009   2026 preseason   2025-10-03 NOP vs. MEL   1610612740
#> 10 0012500010   2026 preseason   2025-10-04 PHI vs. NYK   1610612755
#> # ℹ 1,390 more rows
#> # ℹ 9 more variables: home_team_abbreviation <chr>, home_team_name <chr>,
#> #   home_pts <int>, home_wl <chr>, away_team_id <int>,
#> #   away_team_abbreviation <chr>, away_team_name <chr>, away_pts <int>,
#> #   away_wl <chr>
# }
# \donttest{
  try(load_nba_stats_shots(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 233,632 × 18
#>    game_id    season period clock     team_id team_tricode person_id player_name
#>    <chr>       <int>  <int> <chr>       <int> <chr>            <int> <chr>      
#>  1 0022500001   2026      1 PT11M36.…  1.61e9 HOU            1630578 Sengun     
#>  2 0022500001   2026      1 PT11M26.…  1.61e9 OKC            1631096 Holmgren   
#>  3 0022500001   2026      1 PT11M08.…  1.61e9 HOU            1641708 Thompson   
#>  4 0022500001   2026      1 PT11M02.…  1.61e9 HOU            1631095 Smith Jr.  
#>  5 0022500001   2026      1 PT10M50.…  1.61e9 OKC            1631096 Holmgren   
#>  6 0022500001   2026      1 PT10M24.…  1.61e9 HOU            1630578 Sengun     
#>  7 0022500001   2026      1 PT10M07.…  1.61e9 HOU             201142 Durant     
#>  8 0022500001   2026      1 PT09M52.…  1.61e9 OKC            1631096 Holmgren   
#>  9 0022500001   2026      1 PT09M35.…  1.61e9 HOU            1631095 Smith Jr.  
#> 10 0022500001   2026      1 PT09M21.…  1.61e9 OKC            1641717 Wallace    
#> # ℹ 233,622 more rows
#> # ℹ 10 more variables: action_type <chr>, sub_type <chr>, shot_result <chr>,
#> #   shot_value <int>, shot_distance <int>, x_legacy <int>, y_legacy <int>,
#> #   description <chr>, score_home <chr>, score_away <chr>
# }
# \donttest{
  try(load_nba_stats_standings(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 30 × 94
#>    league_id season_id    team_id team_city     team_name team_slug conference
#>    <chr>     <chr>          <int> <chr>         <chr>     <chr>     <chr>     
#>  1 00        22025     1610612760 Oklahoma City Thunder   thunder   West      
#>  2 00        22025     1610612765 Detroit       Pistons   pistons   East      
#>  3 00        22025     1610612738 Boston        Celtics   celtics   East      
#>  4 00        22025     1610612759 San Antonio   Spurs     spurs     West      
#>  5 00        22025     1610612743 Denver        Nuggets   nuggets   West      
#>  6 00        22025     1610612752 New York      Knicks    knicks    East      
#>  7 00        22025     1610612739 Cleveland     Cavaliers cavaliers East      
#>  8 00        22025     1610612747 Los Angeles   Lakers    lakers    West      
#>  9 00        22025     1610612745 Houston       Rockets   rockets   West      
#> 10 00        22025     1610612761 Toronto       Raptors   raptors   East      
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
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 2,630 × 26
#>       team_id team_name team_tricode side  minutes field_goals_made
#>         <int> <chr>     <chr>        <chr> <chr>              <int>
#>  1 1610612760 Thunder   OKC          home  290:00                46
#>  2 1610612745 Rockets   HOU          away  290:00                43
#>  3 1610612747 Lakers    LAL          home  240:00                42
#>  4 1610612744 Warriors  GSW          away  240:00                38
#>  5 1610612752 Knicks    NYK          home  240:00                37
#>  6 1610612739 Cavaliers CLE          away  240:00                40
#>  7 1610612742 Mavericks DAL          home  240:00                31
#>  8 1610612759 Spurs     SAS          away  240:00                50
#>  9 1610612754 Pacers    IND          home  290:00                46
#> 10 1610612760 Thunder   OKC          away  290:00                43
#> # ℹ 2,620 more rows
#> # ℹ 20 more variables: field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   free_throws_made <int>, free_throws_attempted <int>,
#> #   free_throws_percentage <dbl>, rebounds_offensive <int>,
#> #   rebounds_defensive <int>, rebounds_total <int>, assists <int>, …
# }
# \donttest{
  try(load_nba_stats_team_season_stats(seasons = most_recent_nba_stats_season()))
#> ───────────────────────────────────────────────────────────────── hoopR 3.1.0 ──
#> # A tibble: 552 × 178
#>       team_id team_name       gp     w     l w_pct   min e_off_rating off_rating
#>         <int> <chr>        <int> <int> <int> <dbl> <dbl>        <dbl>      <dbl>
#>  1 1610612737 Atlanta Haw…     6     2     4 0.333   288         101.       104.
#>  2 1610612738 Boston Celt…     7     3     4 0.429   336         111.       114.
#>  3 1610612739 Cleveland C…    18     8    10 0.444   879         109.       110.
#>  4 1610612743 Denver Nugg…     6     2     4 0.333   288         106.       108.
#>  5 1610612765 Detroit Pis…    14     7     7 0.5     677         107.       110.
#>  6 1610612745 Houston Roc…     6     2     4 0.333   293         102.       105.
#>  7 1610612747 Los Angeles…    10     4     6 0.4     485         106.       108.
#>  8 1610612750 Minnesota T…    12     6     6 0.5     576         105.       107.
#>  9 1610612752 New York Kn…    19    16     3 0.842   917         117.       120.
#> 10 1610612760 Oklahoma Ci…    15    11     4 0.733   730         116.       118.
#> # ℹ 542 more rows
#> # ℹ 169 more variables: e_def_rating <dbl>, def_rating <dbl>,
#> #   e_net_rating <dbl>, net_rating <dbl>, ast_pct <dbl>, ast_to <dbl>,
#> #   ast_ratio <dbl>, oreb_pct <dbl>, dreb_pct <dbl>, reb_pct <dbl>,
#> #   tm_tov_pct <dbl>, efg_pct <dbl>, ts_pct <dbl>, e_pace <dbl>, pace <dbl>,
#> #   pace_per40 <dbl>, poss <int>, pie <dbl>, gp_rank <int>, w_rank <int>,
#> #   l_rank <int>, w_pct_rank <int>, min_rank <int>, off_rating_rank <int>, …
# }
```
