# **FEB Player Box Score**

**Per-player box score of one FEB game: minutes, points, shooting
splits, rebounds, assists, fouls and plus/minus.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/BoxScore/{game_id}`

One row per player and team. `p1` / `p2` / `p3` are free throws, two-
and three-point field goals (`m` made, `a` attempted, `p` percentage
0-100); `seconds_played` is the provider's `min` (seconds, not minutes);
`player_id` is the FEB person id (stable across seasons) and
`shirt_number` stays a string (`"00"` is not `"0"`).

## Usage

``` r
feb_player_box(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
| team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
| team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
| player_id | integer | FEB person id: stable across seasons and clubs (A. Jorda Rodriguez = 1676991 in 2025-26 and 2026-27). Joins the box score, play-by-play, shots and leaders; not the per-season licence_id. |
| shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
| player | character | Player name as 'I. SURNAME(S)', uppercase ('V. AGUILAR HERNANDEZ'). |
| starter | logical | True when the player was in the starting five (the page's I column), false when on the bench. |
| captain | logical | True for the team captain. Null on 2020-21 games, where the feed does not send it. |
| seconds_played | integer | Seconds on court (the feed's min, an integer count of seconds: 1064 = 17:44; a team row sums its players, 12000 = 200:00). Null on /TeamStats rows. |
| min_formatted | character | Time played as 'mm:ss'. |
| pts | integer | Points scored (the team's points on team rows; the final score when the clock is FINAL, else live). |
| p1m | integer | Free throws made (tiros libres; integer as a string). |
| p1a | integer | Free throws attempted (integer as a string). |
| p1p | double | Free-throw percentage, 0-100, as a string with a DECIMAL COMMA ('77,3'); '0,0' when no attempts. |
| p2m | integer | Two-point field goals made (integer as a string). |
| p2a | integer | Two-point field goals attempted (integer as a string). |
| p2p | double | Two-point percentage, 0-100, string with a decimal comma ('54,1'). |
| p3m | integer | Three-point field goals made (integer as a string). |
| p3a | integer | Three-point field goals attempted (integer as a string). |
| p3p | double | Three-point percentage, 0-100, string with a decimal comma ('47,6'). |
| fgm | integer | Field goals made, 2PT + 3PT (tiros de campo; integer as a string). |
| fga | integer | Field goals attempted, 2PT + 3PT (integer as a string). |
| fgp | double | Field-goal percentage, 0-100, string with a decimal comma ('51,7'). |
| ro | integer | Offensive rebounds (rebotes ofensivos; integer as a string). |
| rd | integer | Defensive rebounds (rebotes defensivos; integer as a string). |
| rt | integer | Total rebounds (rebotes totales; integer as a string). |
| reb | integer | Total rebounds (the same count as rt). |
| assist | integer | Assists (asistencias; integer as a string). |
| st | integer | Steals (balones robados, page column BR; integer as a string). |
| to | integer | Turnovers (balones perdidos, page column BP; integer as a string). |
| bs | integer | Blocks made (tapones a favor, page column TF; integer as a string). |
| tc | integer | Shots of this player/team that were blocked (tapones en contra / recibidos, page column TC; integer as a string). |
| mt | integer | Dunks (mates, page column MT; integer as a string). |
| pf | integer | Personal fouls committed (faltas cometidas, page column FC; integer as a string). |
| rf | integer | Fouls received / drawn (faltas recibidas, page column FR; integer as a string). |
| pllss | integer | Plus/minus while the player was on court (balance, page column +/-), signed integer. |
| val | integer | FEB efficiency rating (valoracion): points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - shots blocked - fouls committed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_player_box(game_id = 2535725))
#> ── FEB player box from intrafeb.feb.es ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:40:44 UTC
#> # A tibble: 24 × 38
#>    game_id team_side team_id team  player_id shirt_number player starter captain
#>      <int> <chr>       <int> <chr>     <int> <chr>        <chr>  <lgl>   <lgl>  
#>  1 2535725 home      1009716 BUEN…   1371559 3            V. AG… TRUE    FALSE  
#>  2 2535725 home      1009716 BUEN…   2813013 5            N. RE… TRUE    FALSE  
#>  3 2535725 home      1009716 BUEN…   2880241 6            J. ZE… TRUE    FALSE  
#>  4 2535725 home      1009716 BUEN…   2432962 10           S. ME… FALSE   TRUE   
#>  5 2535725 home      1009716 BUEN…   1603635 11           J. GO… FALSE   FALSE  
#>  6 2535725 home      1009716 BUEN…   2880232 16           A. MA… FALSE   FALSE  
#>  7 2535725 home      1009716 BUEN…   2500822 22           M. VO… TRUE    FALSE  
#>  8 2535725 home      1009716 BUEN…   2162563 25           A. LA… FALSE   FALSE  
#>  9 2535725 home      1009716 BUEN…   2117867 42           S. SA… FALSE   FALSE  
#> 10 2535725 home      1009716 BUEN…   1981843 44           B. VA… TRUE    FALSE  
#> # ℹ 14 more rows
#> # ℹ 29 more variables: seconds_played <int>, min_formatted <chr>, pts <int>,
#> #   p1m <int>, p1a <int>, p1p <dbl>, p2m <int>, p2a <int>, p2p <dbl>,
#> #   p3m <int>, p3a <int>, p3p <dbl>, fgm <int>, fga <int>, fgp <dbl>, ro <int>,
#> #   rd <int>, rt <int>, reb <int>, assist <int>, st <int>, to <int>, bs <int>,
#> #   tc <int>, mt <int>, pf <int>, rf <int>, pllss <int>, val <int>
# }
```
