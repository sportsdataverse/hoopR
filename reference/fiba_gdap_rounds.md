# **FIBA GDAP: rounds**

Rounds of a competition (group stage, knockout rounds).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`

## Usage

``` r
fiba_gdap_rounds(comp, return_parsed = TRUE)
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
| game_system | character | Pairing system label (Single, Home and Away, Best of 3). |
| game_system_code | character | Pairing system code: S single game, HA home and away, BOF3 best of three. |
| parent_round_id | integer | roundId of the round this one belongs to; null for a top-level round. |
| round_code | character | Round code (GP group phase, QF, SF, F final, RS regular season, CL17-32 classification...). |
| round_id | integer | Round id (GDAP key space, unique across competitions); the first segment of gameName. |
| round_name | character | Round label (Group Phase, Quarter-Finals, Final...). |
| round_number | integer | Round number within the competition (1-based). |
| round_type | character | Round type label: Group Round, Non Group Round, Super Round (getgdapgamesbycompetitionid uses the code G/NG here). |
| round_type_code | character | Round type code: G group, NG non-group (knockout), S super round. |
| round_status_code | character | Round status: COMPL completed, PROGR in progress, CLOS closed. |
| start_date | character | Round start, local date-time. |
| end_date | character | Round end, local date-time (23:59:59.9999999 on the last day). |
| has_teams_assigned | logical | True once the round's teams are known. |
| round_kind | character | Standard Round or Qualifiers. |
| standing_header_code | character | Code of the standings table the round feeds. |
| standing_header_name | character | Name of the standings table the round feeds. |
| qualified_team_information | character | Qualification note of the round; null in every sample. |
| round_order | integer | Display order of the round. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

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
[`fiba_gdap_round_gamedays()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_gamedays.md),
[`fiba_gdap_round_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_standings.md),
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md),
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)

## Examples

``` r
# \donttest{
  try(fiba_gdap_rounds(comp = 208182))
#> ── FIBA gdap_rounds from fiba.basketball ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:53:10 UTC
#> # A tibble: 10 × 18
#>    game_system game_system_code parent_round_id round_code round_id round_name  
#>    <chr>       <chr>                      <int> <chr>         <int> <chr>       
#>  1 Single      S                          25274 FR            25276 First Round 
#>  2 Single      S                          25274 SR            25285 Second Round
#>  3 Single      S                             NA CL17-32       25284 Classificat…
#>  4 Single      S                          25275 QF            25277 Quarter-Fin…
#>  5 Single      S                          25275 CL5-8         25278 Class. Game…
#>  6 Single      S                          25275 SF            25279 Semi-Finals 
#>  7 Single      S                          25275 CL7-8         25280 Class. Game…
#>  8 Single      S                          25275 CL5-6         25281 Class. Game…
#>  9 Single      S                          25275 3PG           25282 3rd Place G…
#> 10 Single      S                          25275 F             25283 Final       
#> # ℹ 12 more variables: round_number <int>, round_type <chr>,
#> #   round_type_code <chr>, round_status_code <chr>, start_date <chr>,
#> #   end_date <chr>, has_teams_assigned <lgl>, round_kind <chr>,
#> #   standing_header_code <chr>, standing_header_name <chr>,
#> #   qualified_team_information <chr>, round_order <int>
# }
```
