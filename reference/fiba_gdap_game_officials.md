# **FIBA GDAP: game officials**

Officials nominated to one game (referees, table officials,
commissioner).

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game_officials(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64) of the game the official was nominated to. |
| person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
| role_code | character | Role code (REF, FIBATDEL...). |
| role_name | character | Role name on the game (Crew chief, Umpire, Commissioner, Assistant scorer...). |
| role_order | character | Order within the role; a numeric string or null. |
| default_nationality | character | FIBA code of the official's main nationality. |
| license_nationality | character | FIBA code of the federation that licenses the official. |

## Details

FIBA's terms restrict this source. The GDAP developer-portal terms limit
API use to 'Authorized Users' (federations, organisers, FIBA partners)
and say any broader use 'is not authorised'; the fiba.basketball terms
say no portion of the site may be duplicated, redistributed or
manipulated. The package owner reviewed both clauses on 2026-10-12,
accepted them and approved the full intake, published data releases
included. Users who are not themselves authorised by FIBA should check
the terms before using the wrappers.

The GDAP subscription key is public (fiba.basketball ships it in every
page); the runtime reads it from the live page at run time and never
logs it. Officials' contact details and coaches' and officials' dates of
birth are dropped from every body.

Id key spaces: competition_id is one per edition (2023 World Cup =
208182) and game_id is global across competitions (the `<gameId>` of a
game-page URL). team_id is per team per competition (Germany is 279569
at the 2023 World Cup and 281545 at Paris 2024), while organisation_id
is the stable federation or club (64 = Germany, every year); the game
page's T\_`<id>` and the play-by-play oId are organisation ids, not team
ids.

Errors are classed conditions (all inherit `hoopR_error`):
`hoopR_no_data` when FIBA has nothing (HTTP 404, or GDAP answers
[`{}`](https://rdrr.io/r/base/Paren.html) / `[]` for an unknown id);
`hoopR_bad_request` for HTTP 400 / 422 or a malformed id, season or
date; `hoopR_asset_fetch` for any other failed fetch or an answer that
is not about the request (an error envelope, HTTP 401 after a key
refresh, HTTP 500, a body for another game, competition, team, player,
federation, family or season). Seasons are FIBA's own key, which equals
the sdv key: the END year for club competitions, the event year for
national-team events, the target tournament year for qualifiers.

     fiba_gdap_game_officials(game_id = 100720)

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md),
[`fiba_gamepage_period_scores()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_period_scores.md),
[`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md),
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md),
[`fiba_gdap_competition()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_competition.md),
[`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md),
[`fiba_gdap_federation_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_games.md),
[`fiba_gdap_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_ranking.md),
[`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md),
[`fiba_gdap_game()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game.md),
[`fiba_gdap_game_periods()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_periods.md),
[`fiba_gdap_games_between()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_games_between.md),
[`fiba_gdap_gateway_competition_ids()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_competition_ids.md),
[`fiba_gdap_gateway_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_federation_ranking.md),
[`fiba_gdap_medal_count()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_medal_count.md),
[`fiba_gdap_national_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_national_teams.md),
[`fiba_gdap_nominations()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_nominations.md),
[`fiba_gdap_player_game_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_game_stats.md),
[`fiba_gdap_player_info()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_info.md),
[`fiba_gdap_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_stats.md),
[`fiba_gdap_ranking_zones()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_ranking_zones.md),
[`fiba_gdap_roster()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster.md),
[`fiba_gdap_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_coaches.md),
[`fiba_gdap_roster_latest()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_latest.md),
[`fiba_gdap_round_gamedays()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_gamedays.md),
[`fiba_gdap_round_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_standings.md),
[`fiba_gdap_rounds()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_rounds.md),
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md),
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)
