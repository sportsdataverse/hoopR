# **FIBA GDAP: roster**

A team's roster at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`

## Usage

``` r
fiba_gdap_roster(team_id, discipline_format = NULL, return_parsed = TRUE)
```

## Arguments

- team_id:

  (integer, required) Required. Competition team id: one per team per
  competition (teamA.teamId of a game row; Germany is 279569 at the 2023
  World Cup and 281545 at Paris 2024). Not the federation organisationId

- discipline_format:

  (character, optional) Optional; the site passes its discipline format.
  5x5 answers the same as omitting it (verified on awards and rosters)

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_code | character | Team code (FIBA country code or club abbreviation). |
| team_name | character | Team name (the country for a national team, the club for a club team). |
| organisation_id | integer | Stable federation or club id (Int64), the same in every competition and season (64 = Germany). |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| person_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| gender | character | Sex of the person: M or F (Male/Female on getgdapcompetitionnominationsbyid). |
| date_of_birth | character | Date of birth, YYYY-MM-DD. |
| uniform_number | character | Jersey number (a string). |
| uniform_name | character | Name printed on the jersey. |
| position | character | Playing position (roster: Point Guard...; game page: PG, SG, SF, PF, C). |
| height_in_cm | integer | Player height in centimetres. |
| height_in_feet_inches | character | Height, feet and inches string (6'7"). |
| nationality | character | FIBA code of the main nationality. |
| is_on_final_roster | logical | True when on the final (12-player) roster. |
| games_played | integer | Games played in the competition. |
| club_id | integer | Organisation id of the player's club (organisationId key space). |
| club_name | character | Club at the time of the competition. |
| country_fiba_code | character | FIBA code of the country the person represents. |
| club_country_fiba_code | character | FIBA code of the club's country. |
| is_captain | logical | True for the team captain. |
| is_player_free_agent | logical | True when the player had no club. |
| final_roster_member_status_code | character | Roster entry status: VALID, PARTIAL (incomplete registration). |

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
  try(fiba_gdap_roster(team_id = 279569))
#> ── FIBA gdap_roster from fiba.basketball ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:15:08 UTC
#> # A tibble: 12 × 25
#>    team_id team_code team_name organisation_id competition_id person_id
#>      <int> <chr>     <chr>               <int>          <int>     <int>
#>  1  279569 GER       Germany                64         208182    211501
#>  2  279569 GER       Germany                64         208182    155956
#>  3  279569 GER       Germany                64         208182    269000
#>  4  279569 GER       Germany                64         208182    204689
#>  5  279569 GER       Germany                64         208182    188675
#>  6  279569 GER       Germany                64         208182    196287
#>  7  279569 GER       Germany                64         208182    189145
#>  8  279569 GER       Germany                64         208182    181996
#>  9  279569 GER       Germany                64         208182    198299
#> 10  279569 GER       Germany                64         208182    188677
#> 11  279569 GER       Germany                64         208182    227403
#> 12  279569 GER       Germany                64         208182    210175
#> # ℹ 19 more variables: first_name <chr>, last_name <chr>, gender <chr>,
#> #   date_of_birth <chr>, uniform_number <chr>, uniform_name <chr>,
#> #   position <chr>, height_in_cm <int>, height_in_feet_inches <chr>,
#> #   nationality <chr>, is_on_final_roster <lgl>, games_played <int>,
#> #   club_id <int>, club_name <chr>, country_fiba_code <chr>,
#> #   club_country_fiba_code <chr>, is_captain <lgl>, is_player_free_agent <lgl>,
#> #   final_roster_member_status_code <chr>
# }
```
