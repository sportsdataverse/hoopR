# **Liga Uruguaya de Basquetbol (Genius LiveStats)**

Convenience wrappers binding the Genius family to the Liga Uruguaya de
Basquetbol (men's; Genius ORG `FUBB`, LiveStats ORG `FUBB`). Season
rule: END year; Genius year + 1 (2025-26 = 2026).

- `lub_competitions()`: every competition of the `FUBB` org, with its
  END-year season
  ([`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)).

- `lub_schedule()`: every match of one season
  ([`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md)).

- `lub_team_box()`, `lub_player_box()`, `lub_pbp()`, `lub_shots()`: one
  finished game
  ([`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
  [`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
  [`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
  [`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md)).

## Usage

``` r
lub_competitions(return_parsed = TRUE)

lub_schedule(season = NULL, comp_id = NULL, round_number = -1, return_parsed = TRUE)

lub_team_box(match_id, return_parsed = TRUE)

lub_player_box(match_id, return_parsed = TRUE)

lub_pbp(match_id, return_parsed = TRUE)

lub_shots(match_id, return_parsed = TRUE)
```

## Arguments

- season:

  END-year season (see the season rule). `NULL` (default) = the newest
  season the org lists.

- comp_id:

  Genius competition id; skips the season lookup (needed when the label
  rule matches several competitions).

- round_number:

  Round to list; -1 (default) lists every round.

- match_id:

  Genius match id (`match_id` of `lub_schedule()`) of a game of this
  competition.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the raw list.

## Value

The base function's `hoopR_data` tibble, same columns and types (the raw
list when `return_parsed = FALSE`), one table per function:

### `lub_competitions()`

The columns of
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | ORG code the request used (the hosted ORG, or the LiveStats ORG for the /u/ shell). |
| comp_id | integer | Genius competition id (compId): one per org competition-season; the {compId} of hosted and data/competition paths |
| label | character | Competition label as the org typed it, free text in any language: may or may not carry a season ('BASKET LEAGUE 2019 - 20', '1st division', 'Kypello Elladas' (in Greek script) = Greek Cup, 'Mavroskoufeia' (in Greek script) = Mavroskoufeia youth tournament) |
| league_id | integer | Genius league id of the org (ESAKE = 115; IBBA has two: 187 and 549) |
| year | integer | Genius season year of the competition: the START year of a two-year season (BNXT '2023-2024' = 2023), the year itself for a calendar season. null when the page gives none |
| season | integer | sdv END-year season of the competition (2026 = 2025-26) from the label span, else the Genius year; null when no rule applies. See season_rule. |
| season_rule | character | Which rule produced season: 'label span', 'genius year + 1 (split)', 'genius year (calendar)', 'label year (calendar)' or 'unknown'. |
| selected | logical | True for the competition the hosted chooser pre-selects (the org's default, not always the newest). |

### `lub_schedule()`

The columns of
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | From the block id `extfix_<id>`. Genius match id: the {matchId} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
| link_match_id | integer | Match id of the block's `/match/<id>/summary` link; equals match_id (the capture refuses a page where it does not); null when the org hides match pages (FFBB) |
| comp_id | integer | CompId of the match link, or of the team links when the org hides match pages (FFBB); equals the {compId} asked for. A 'To be determined' slot (no team or match link) takes the {compId} the page's other blocks prove |
| org | character | ORG code of the match link (or the team links, as comp_id) |
| status | character | Status from the block class STATUS\_\*: COMPLETE, SCHEDULED, POSTPONED, ... |
| date_time | character | Tip-off as displayed, 'Mon D, YYYY, h:mm AM' (local time, zone not stated); null when unscheduled |
| venue_id | integer | Genius venue id (the /venue/{id} of hosted pages); null when the venue is plain text (FFBB) |
| venue_name | character | Venue name as entered (local script) |
| home_team_id | integer | Home team: Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| home_team_name | character | Home team full name |
| home_team_code | character | Home team code (local script possible) |
| home_score | integer | Home points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
| away_team_id | integer | Away team: Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| away_team_name | character | Away team full name |
| away_team_code | character | Away team code (local script possible) |
| away_score | integer | Away points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |

### `lub_team_box()`

The columns of
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| name | character | Team name as the org enters it |
| name_international | character | Team name in Latin script |
| short_name | character | Short team name (shortName in the feed), in the competition's own script when the org enters one. |
| code | character | Team code, three letters as entered (may be in the local script, e.g. Greek 'AEK' in Greek script) |
| code_international | character | Team code in Latin script |
| coach | character | Head coach display name |
| score | integer | Team points (current or final); a numeric string in the 2014-15 era sample (WBBL 12248), an integer since |
| full_score | integer | Team points including overtime; equal to score in every sample (a numeric string in the 2014-15 era) |
| p1_score | integer | Points scored in period 1 (a numeric string in the 2014-15 era) |
| p2_score | integer | Points scored in period 2 (a numeric string in the 2014-15 era) |
| p3_score | integer | Points scored in period 3 (a numeric string in the 2014-15 era) |
| p4_score | integer | Points scored in period 4 (a numeric string in the 2014-15 era) |
| ot_score | integer | Points the team scored in overtime; null without overtime. Whether several overtimes are summed is unverified. |
| fouls | integer | Team fouls in the current (last) period |
| timeouts | integer | Timeouts counter of the current period (unverified: remaining vs taken); 0 in every sampled (finished) game |
| minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
| seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes \* 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
| field_goals_made | integer | Team total: field goals made |
| field_goals_attempted | integer | Team total: field goals attempted |
| field_goals_percentage | double | Team total: field-goal percentage, 0-100, rounded to an integer by the feed |
| three_pointers_made | integer | Team total: three-pointers made |
| three_pointers_attempted | integer | Team total: three-pointers attempted |
| three_pointers_percentage | double | Team total: three-point percentage, 0-100, rounded to an integer |
| two_pointers_made | integer | Team total: two-pointers made |
| two_pointers_attempted | integer | Team total: two-pointers attempted |
| two_pointers_percentage | double | Team total: two-point percentage, 0-100, rounded to an integer |
| free_throws_made | integer | Team total: free throws made |
| free_throws_attempted | integer | Team total: free throws attempted |
| free_throws_percentage | double | Team total: free-throw percentage, 0-100, rounded to an integer |
| rebounds_defensive | integer | Team total: defensive rebounds |
| rebounds_offensive | integer | Team total: offensive rebounds |
| rebounds_total | integer | Team total: total rebounds |
| assists | integer | Team total: assists |
| turnovers | integer | Team total: turnovers |
| steals | integer | Team total: steals |
| blocks | integer | Team total: blocks made |
| blocks_received | integer | Team total: own shots blocked by an opponent |
| fouls_personal | integer | Team total: personal fouls committed |
| fouls_on | integer | Team total: fouls drawn |
| points | integer | Team total: points |
| points_from_turnovers | integer | Team total: points off turnovers |
| points_second_chance | integer | Team total: second-chance points |
| points_fast_break | integer | Team total: fast-break points |
| points_in_the_paint | integer | Team total: points in the paint |
| eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Team tot_eff_2 is 2 in every 2016+ sample (a constant, not a stat). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_3 | double | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_4 | double | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| bench_points | integer | Team total: points scored by non-starters |
| biggest_lead | integer | Team total: biggest lead, points |
| biggest_scoring_run | integer | Team total: biggest unanswered scoring run, points |
| lead_changes | integer | Team total: lead changes in the game (same value on both teams) |
| times_scores_level | integer | Team total: times the score was tied (same value on both teams) |
| time_leading | double | Team total: minutes the team led, decimal minutes (33.58 = 33 min 35 s) |
| fouls_team | integer | Team total: team (bench) fouls |
| fouls_total | integer | Team total: all fouls committed (personal + technical + team bench) |
| rebounds_team | integer | Team total: team rebounds (credited to no player) |
| rebounds_team_defensive | integer | Team total: team defensive rebounds |
| rebounds_team_offensive | integer | Team total: team offensive rebounds |
| turnovers_team | integer | Team total: team turnovers (credited to no player, e.g. shot clock) |

### `lub_player_box()`

The columns of
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
| name | character | Display name ('T. Nichols') |
| first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
| family_name | character | Family name in the competition's own script |
| international_first_name | character | Given name in Latin script |
| international_family_name | character | Family name in Latin script (often upper case) |
| scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
| shirt_number | character | Shirt number as a string ('0' and '00' differ) |
| playing_position | character | Playing position code (PG, SG, SF, PF, C, G, F, ...); empty string when not entered |
| starter | integer | 1 when the player started the game, else 0 |
| captain | integer | 1 for the team captain, else 0; absent in some orgs |
| active | integer | 1 when the player is on court now (at game end: on court at the final whistle), else 0 |
| minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
| seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes \* 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
| field_goals_made | integer | Field goals the player made in the game (two- and three-pointers together; a count). |
| field_goals_attempted | integer | Field goals the player attempted in the game (two- and three-pointers together; a count). |
| field_goals_percentage | double | Field-goal percentage, 0-100, rounded to an integer by the feed |
| three_pointers_made | integer | Three-pointers made |
| three_pointers_attempted | integer | Three-pointers attempted |
| three_pointers_percentage | double | Three-point percentage, 0-100, rounded to an integer |
| two_pointers_made | integer | Two-pointers made |
| two_pointers_attempted | integer | Two-pointers attempted |
| two_pointers_percentage | double | Two-point percentage, 0-100, rounded to an integer |
| free_throws_made | integer | Free throws the player made in the game (a count). |
| free_throws_attempted | integer | Free throws the player attempted in the game (a count). |
| free_throws_percentage | double | Free-throw percentage, 0-100, rounded to an integer |
| rebounds_defensive | integer | Defensive rebounds |
| rebounds_offensive | integer | Offensive rebounds |
| rebounds_total | integer | Total rebounds (offensive plus defensive) the player collected in the game. |
| assists | integer | Assists credited to the player in the game. |
| turnovers | integer | Turnovers committed by the player in the game. |
| steals | integer | Steals credited to the player in the game. |
| blocks | integer | Shots the player blocked in the game (blocks made, not received). |
| blocks_received | integer | Own shots blocked by an opponent |
| fouls_personal | integer | Personal fouls committed |
| fouls_on | integer | Fouls drawn: personal fouls committed against the player in the game. |
| points | integer | Points the player scored in the game, free throws included. |
| points_from_turnovers | integer | Points off turnovers |
| points_second_chance | integer | Second-chance points |
| points_fast_break | integer | Fast-break points |
| points_in_the_paint | integer | Points the player scored in the paint in the game (the feed's sPointsInThePaint). |
| plus_minus_points | integer | Plus/minus: team point margin while the player was on court |
| eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_3 | double | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_4 | double | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
| eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site. Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |

### `lub_pbp()`

The columns of
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| row_index | integer | Position of the action in the feed order, 0 = the newest action by game time (normally the game end row). The feed is not strictly sorted by action_number, so sort on action_number for entry order. |
| action_number | integer | Action sequence number, unique within the game (gaps where actions were deleted); a shot joins its play-by-play row on it. Null in the 2014-15 feed. |
| previous_action | integer | action_number of the linked earlier action (the shot an assist or rebound belongs to); null when the feed sends an empty string. |
| period | integer | Period number; restarts at 1 for the first overtime (read it with period_type). |
| period_type | character | Period type: REGULAR or OVERTIME. |
| gt | character | Game clock, 'mm:ss' remaining in the period |
| clock | character | Game clock with hundredths, 'mm:ss:cc' remaining in the period; absent in older feeds (the 2014-15 WBBL sample has gt only) |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
| player | character | Player display name; ” when no player |
| shirt_number | character | Player shirt number (string); ” when no player |
| first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
| family_name | character | Family name in the competition's own script |
| international_first_name | character | Given name in Latin script |
| international_family_name | character | Family name in Latin script (often upper case) |
| scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
| action_type | character | Action type: 2pt, 3pt, freethrow, rebound, assist, turnover, steal, block, foul, foulon (foul drawn), substitution, timeout, jumpball, period, game, headcoachchallenge |
| sub_type | character | Action subtype, free-text code per actionType: shot type for 2pt/3pt (layup, drivinglayup, jumpshot, pullupjumpshot, turnaroundjumpshot, ...), 'in'/'out' for substitutions, 'start'/'end' for period and game, foul kind for fouls; empty string when none |
| qualifier | character | Qualifier codes of the action joined with commas (pointsinthepaint, fromturnover, 2ndchance, fastbreak, blocked, ...); null when none. |
| success | integer | 1 = made / successful, 0 = missed (shots, free throws); 1 for other actions |
| scoring | integer | 1 when the action is a scoring attempt (shot or free throw), else 0 |
| score_1 | integer | Team 1 score after the action, always an integer (the feed sends a string in most games). |
| score_2 | integer | Team 2 score after the action, always an integer (the feed sends a string in most games). |
| lead | integer | Score margin after the action, team 1 minus team 2 (negative when team 2 leads) |

### `lub_shots()`

The columns of
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
| action_number | integer | Action sequence number, unique within the game (gaps where actions were deleted); a shot joins its play-by-play row on it. Null in the 2014-15 feed. |
| period | integer | Period number; restarts at 1 for the first overtime (read it with period_type). |
| period_type | character | Period type: REGULAR or OVERTIME. |
| action_type | character | Shot value: 2pt or 3pt |
| sub_type | character | Shot type (layup, drivinglayup, jumpshot, pullupjumpshot, dunk, ...) |
| result | integer | Shot result: 1 = made, 0 = missed. |
| x | double | Court x, PERCENT of the full court length (0-100, float), along the long axis. Not normalised to one basket: a team attacks one end in periods 1-2 and the other end in periods 3-4 (ESAKE 2902690: team 1 mean x 90 and 86 in P1-P2, 11 and 19 in P3-P4). Which end x = 0 is, and which end team 1 starts at, are unverified |
| y | double | Court y, PERCENT of the full court width (0-100, float), across the court (observed 1.7-97.2). Origin side unverified |
| player | character | Shooter's display name as the org enters it, in the local script when it uses one. |
| shirt_number | character | Shooter's shirt number (string) |

## Details

The season's competition is picked from the `FUBB` chooser by the label
rule include = `liga uruguaya|^lub`, exclude = `amistosos|femenina`
(case-insensitive); cups and play-offs have their own `comp_id`. Several
matching competitions raise `hoopR_bad_request` (pass `comp_id`); none
raises `hoopR_no_data`.

Genius match ids are one global sequence shared by every customer and
`data.json` names no competition, so each game alias checks the id on
the game's LiveStats shell (`/u/FUBB/<match_id>/`: one extra request per
game, cached per process for an hour): its competition name must pass
the label rule. Another org's game, a cup or play-off game of `FUBB`, or
a shell request that fails twice (or names no competition) raises
`hoopR_asset_fetch`. The base `genius_*()` function reads any game
unchecked.

Access, proxy and error notes: see
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md).

     lub_competitions()
     lub_schedule()

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)
