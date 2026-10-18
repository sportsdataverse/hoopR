# **Get CEBL Player Game Log**

One player's game log: one row per game played, with the Genius match id
of the game.

Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/gamelog/`

## Usage

``` r
cebl_player_gamelog(player_id, season = NULL, competition = NULL)
```

## Arguments

- player_id:

  (required) CEBL player id (global across seasons and teams), e.g.
  570965 (Javonte Smart); `player_id` in cebl_player_stats.

- season:

  (default `NULL`) Season: the calendar year (May to August) = the sdv
  END year. `NULL` = every season combined (the Stats Hub's All-Time).
  An unknown year answers `hoopR_no_data`.

- competition:

  (default `NULL`) REGULAR (regular season) or FINALS (the playoffs).
  `NULL` = both.

## Value

A `hoopR_data` tibble: One player's game log: one row per game played,
with the Genius match id of the game. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`cebl_player_gamelog`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | CEBL player id of the log asked for (from the request; the body does not echo it). |
| season | integer | Season of the game: the year of game_date (the calendar year = the sdv END year). |
| game_date | POSIXct | Tip-off of the game, ISO 8601 in UTC (same as the game's `start_time_utc`). |
| genius_match_id | integer | Genius LiveStats match id parsed from the stats URL (the join to the genius family, organisation CEBL, where play-by-play and shots live). Derived from the URL, not fetched; null when the URL is absent. |
| team_abbreviated_name | character | Three-letter code of the player's team in that game ('OTT'). |
| matchup | character | '{TEAM} {team score} {vs or @} {opponent score} {OPP}': the player's team code and score first; `vs` = a home game, `@` = an away game ('OTT 91 @ 95 BHB'). |
| minutes | double | Minutes played as decimal minutes (26.4), not mm:ss; the API sends a string. |
| points | integer | Points scored in the game. An integer. |
| field_goals_made | integer | Field goals made (2- and 3-pointers) in the game. An integer. |
| field_goals_attempted | integer | Field goals attempted (2- and 3-pointers) in the game. An integer. |
| field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
| three_points_made | integer | Three-pointers made in the game. An integer. |
| three_points_attempted | integer | Three-pointers attempted in the game. An integer. |
| three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
| free_throws_made | integer | Free throws made in the game. An integer. |
| free_throws_attempted | integer | Free throws attempted in the game. An integer. |
| free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
| offensive_rebounds | integer | Offensive rebounds in the game. An integer. |
| defensive_rebounds | integer | Defensive rebounds in the game. An integer. |
| rebounds | integer | Total rebounds in the game; the API sends it as a string ('5'), cast to Int64. |
| assists | integer | Assists in the game. An integer. |
| turn_overs | integer | Turnovers in the game. An integer. |
| steals | integer | Steals in the game. An integer. |
| blocks | integer | Shots blocked in the game. An integer. |
| fouls | integer | Personal fouls committed in the game. An integer. |
| is_target_scorer | logical | True when the player made the basket that reached the Elam Ending target score and ended the game. |
| game_stats_url_en | character | cebl.ca game page, `https://www.cebl.ca/game?id={matchId}`: `id` is the Genius match id (the join to genius-livestats/). |
| game_stats_url_fr | character | French cebl.ca game page (`https://www.cebl.ca/fr-ca/game?id={matchId}`). |
| team_stats_url_en | character | cebl.ca stats page of the player's team in that game (English). |
| team_stats_url_fr | character | cebl.ca stats page of the player's team in that game (French). |

## Details

- CEBL own API, owner-approved gray area: these wrappers read the
  league's own FastAPI service (api.data.cebl.ca, the backend of the
  CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle
  ships to every browser. The key is not issued to third parties and no
  developer terms were found; cebl.ca's terms of use were not reviewed.
  The runtime reads the key from the bundle at run time, falls back to a
  documented constant, never prints it, and raises `hoopR_asset_fetch`
  with a 'key rotated?' hint on a persistent 401. www.cebl.ca/robots.txt
  disallows nothing. Payloads are not redistributed as release assets;
  requests are spaced at least 1 s apart.

- Season is the calendar year (May to August) = the sdv END year: no
  mapping. The first season is 2019. An unknown season, team or player
  answers an empty list, which the runtime raises as `hoopR_no_data`.
  Ids are CEBL's own; a relocated franchise has two team ids (cebl_teams
  lists all 15).

- This API has no box-score, play-by-play or shot route. They live in
  Genius LiveStats (organisation CEBL, see the genius family):
  cebl_games and cebl_player_gamelog carry the Genius match id as
  genius_match_id, parsed from the stats URLs (derived, not fetched; the
  match of a cancelled game may have no data). home_team_id is Genius
  team 1 and away_team_id team 2 (checked on match 2600563).

- Some completed schedule rows have null scores (2026), and a cancelled
  game has status CANELLED (the API's spelling) with null or zero
  scores. The schedule lists unplayed games too, so no wrapper refuses
  an unfinished game. Aggregates are decimal strings upstream and double
  here. Players' names, nationality and birth date are the public bio;
  no contact data is served.

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty
  list, an all-null profile: an unknown season, team or player),
  `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and
  `hoopR_asset_fetch` (a key the API still refuses after one re-read,
  any other non-200, a non-JSON body, an error envelope, a body for
  another season, team or player), all inheriting `hoopR_error`. HTTP
  500 is the API's answer to a bad id and is not retried. Wrappers
  raise; they never return an empty frame.

- Deliberate divergence: a string column that the API sends as an
  object, or a list of objects, carries compact JSON here
  (`{"name":"TSN"}`), where sdv-py's String cast writes Python's
  `str(dict)` repr (`{'name': 'TSN'}`). No string column of the
  committed fixtures carries an object.

     cebl_player_gamelog(player_id = 570965, season = 2025)

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
