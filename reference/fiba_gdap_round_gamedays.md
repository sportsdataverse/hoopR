# **FIBA GDAP: round gamedays**

Rounds of a competition with their game days.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionroundgamedaysbyid`

## Usage

``` r
fiba_gdap_round_gamedays(comp, return_parsed = TRUE)
```

## Arguments

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
| competition_id | integer | FIBA competition id (Int64) the rounds belong to; the comp argument. |
| round_game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
| round_game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
| round_parent_round_id | integer | roundId of the round this one belongs to; null for a top-level round. |
| round_round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
| round_round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
| round_round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| round_round_number | integer | Round number within the competition (1-based). |
| round_round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
| round_round_type_code | character | Round type code: G group, NG non-group (knockout), S super round. |
| round_round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
| round_start_date | character | Round start, local date-time. |
| round_end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
| round_has_teams_assigned | logical | True once the round's teams are known. |
| round_round_kind | character | Standard Round or Qualifiers. |
| round_standing_header_code | character | Code of the standings table the round feeds. |
| round_standing_header_name | character | Name of the standings table the round feeds. |
| round_qualified_team_information | character | Qualification note of the round; null in every sample. |
| round_round_order | integer | Display order of the round. |
| gamedays | character | Game days of the round as a JSON string; empty (null) for the competitions sampled. |

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
[`fiba_gdap_player_game_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_game_stats.md),
[`fiba_gdap_player_info()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_info.md),
[`fiba_gdap_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_stats.md),
[`fiba_gdap_ranking_zones()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_ranking_zones.md),
[`fiba_gdap_roster()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster.md),
[`fiba_gdap_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_coaches.md),
[`fiba_gdap_roster_latest()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_latest.md),
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
  try(fiba_gdap_round_gamedays(comp = 208182))
#> ── FIBA gdap_round_gamedays from fiba.basketball ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:39:19 UTC
#> # A tibble: 12 × 20
#>    competition_id round_game_system round_game_system_code round_parent_round_id
#>             <int> <chr>             <chr>                                  <int>
#>  1         208182 NA                NA                                        NA
#>  2         208182 NA                NA                                        NA
#>  3         208182 Single            S                                      25274
#>  4         208182 Single            S                                      25275
#>  5         208182 Single            S                                      25275
#>  6         208182 Single            S                                      25275
#>  7         208182 Single            S                                      25275
#>  8         208182 Single            S                                      25275
#>  9         208182 Single            S                                      25275
#> 10         208182 Single            S                                      25275
#> 11         208182 Single            S                                         NA
#> 12         208182 Single            S                                      25274
#> # ℹ 16 more variables: round_round_code <chr>, round_round_id <int>,
#> #   round_round_name <chr>, round_round_number <int>, round_round_type <chr>,
#> #   round_round_type_code <chr>, round_round_status_code <chr>,
#> #   round_start_date <chr>, round_end_date <chr>,
#> #   round_has_teams_assigned <lgl>, round_round_kind <chr>,
#> #   round_standing_header_code <chr>, round_standing_header_name <chr>,
#> #   round_qualified_team_information <chr>, round_round_order <int>, …
# }
```
