# **FIBA GDAP: player game stats**

A player's game log (full box lines) at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapplayergamestatisticsbyplayerid`

## Usage

``` r
fiba_gdap_player_game_stats(player_id, comp, return_parsed = TRUE)
```

## Arguments

- player_id:

  (integer, required) Required. FIBA person id (global): personId of a
  roster row, pId in play-by-play, P\_`<id>` in the game-page box

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | FIBA person id (Int64), global; the player_id argument. |
| competition_id | integer | FIBA competition id (Int64) the game log belongs to; the comp argument. |
| game_id | integer | FIBA game id, global across competitions (GDAP key space): gdapGameId, the `<gameId>` of a game-page URL. |
| game_day | integer | Game day number within the round. |
| round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
| round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
| round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_name | character | Player's team name. |
| team_code | character | Player's team code. |
| team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| versus_team_id | integer | Opponent's competition team id (see teamId). |
| versus_team_name | character | Opponent's name. |
| versus_team_code | character | Opponent's code. |
| versus_team_organisation_id | integer | Opponent's organisation id (see organisationId). |
| play_duration_in_seconds | integer | Playing time in seconds in the game. |
| points | integer | Points in the game. |
| field_goals_made | integer | Field goals made in the game. |
| field_goals_attempted | integer | Field goals attempted in the game. |
| field_goals_percentage | double | Field-goal percentage, 0-100 (in the game; full float precision in averages). |
| two_points_made | integer | Two-point field goals made in the game. |
| two_points_attempted | integer | Two-point field goals attempted in the game. |
| two_points_percentage | double | Two-point field-goal percentage, 0-100 (in the game; full float precision in averages). |
| three_points_made | integer | Three-point field goals made in the game. |
| three_points_attempted | integer | Three-point field goals attempted in the game. |
| three_points_percentage | double | Three-point field-goal percentage, 0-100 (in the game; full float precision in averages). |
| free_throws_made | integer | Free throws made in the game. |
| free_throws_attempted | integer | Free throws attempted in the game. |
| free_throws_percentage | double | Free-throw percentage, 0-100 (in the game; full float precision in averages). |
| offensive_rebounds | integer | Offensive rebounds in the game. |
| defensive_rebounds | integer | Defensive rebounds in the game. |
| rebounds | integer | Rebounds in the game. |
| assists | integer | Assists in the game. |
| personal_fouls | integer | Personal fouls in the game. |
| turnovers | integer | Turnovers in the game. |
| steals | integer | Steals in the game. |
| blocked_shots | integer | Blocked shots in the game. |
| plus_minus | integer | Plus/minus (point differential while on court) in the game. |
| efficiency | integer | Efficiency (FIBA EFF) in the game. |

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
[`fiba_gdap_game_officials()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_officials.md),
[`fiba_gdap_game_periods()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_periods.md),
[`fiba_gdap_games_between()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_games_between.md),
[`fiba_gdap_gateway_competition_ids()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_competition_ids.md),
[`fiba_gdap_gateway_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_federation_ranking.md),
[`fiba_gdap_medal_count()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_medal_count.md),
[`fiba_gdap_national_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_national_teams.md),
[`fiba_gdap_nominations()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_nominations.md),
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

## Examples

``` r
# \donttest{
  try(fiba_gdap_player_game_stats(player_id = 211501, comp = 208182))
#> ── FIBA gdap_player_game_stats from fiba.basketball ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:30:18 UTC
#> # A tibble: 8 × 39
#>   player_id competition_id game_id game_day round_id round_code round_name    
#>       <int>          <int>   <int>    <int>    <int> <chr>      <chr>         
#> 1    211501         208182  100720        1    25283 F          Final         
#> 2    211501         208182  100723        1    25279 SF         Semi-Finals   
#> 3    211501         208182  100724        1    25277 QF         Quarter-Finals
#> 4    211501         208182  100743        2    25276 FR         First Round   
#> 5    211501         208182  100744        1    25276 FR         First Round   
#> 6    211501         208182  100748        3    25276 FR         First Round   
#> 7    211501         208182  100797        1    25285 SR         Second Round  
#> 8    211501         208182  100806        2    25285 SR         Second Round  
#> # ℹ 32 more variables: team_id <int>, team_name <chr>, team_code <chr>,
#> #   team_organisation_id <int>, versus_team_id <int>, versus_team_name <chr>,
#> #   versus_team_code <chr>, versus_team_organisation_id <int>,
#> #   play_duration_in_seconds <int>, points <int>, field_goals_made <int>,
#> #   field_goals_attempted <int>, field_goals_percentage <dbl>,
#> #   two_points_made <int>, two_points_attempted <int>,
#> #   two_points_percentage <dbl>, three_points_made <int>, …
# }
```
