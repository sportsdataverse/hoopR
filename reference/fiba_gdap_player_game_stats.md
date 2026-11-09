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

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(fiba_gdap_player_game_stats(player_id = 211501, comp = 208182))
#> ── FIBA gdap_player_game_stats from fiba.basketball ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:05:39 UTC
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
