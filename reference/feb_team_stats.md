# **FEB Team Stats**

**Team totals of both teams in one FEB game: shooting, rebounds,
assists, turnovers, fouls.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`

One row per team, home first. `fastb`, `ptsto`, `secpts`, `bench` and
`paint` are null on every sampled game (the stat crews do not fill
them); `seconds_played` and `val` are null on these rows.

## Usage

``` r
feb_team_stats(game_id)
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
| team_code | character | Federation team code, 8 digits as a string: the 6-digit club_code plus a 2-digit team suffix ('03058600'). Null on 2020-21 games. |
| club_code | character | Federation club code, 6 digits as a string (the first 6 digits of team_code). Whether it is stable across seasons is unverified. Null on 2020-21 games. |
| seconds_played | integer | Seconds on court (the feed's min, an integer count of seconds: 1064 = 17:44; a team row sums its players, 12000 = 200:00). Null on /TeamStats rows. |
| min_formatted | character | Time played as 'mm:ss'; '0:00' on /TeamStats rows (only box-score totals carry a value). |
| pts | integer | Team points: the final score when the game is over, else the live score. |
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
| assist | integer | Assists (asistencias; integer as a string). |
| st | integer | Steals (balones robados, page column BR; integer as a string). |
| to | integer | Turnovers (balones perdidos, page column BP; integer as a string). |
| bs | integer | Blocks made (tapones a favor, page column TF; integer as a string). |
| tc | integer | Shots of this team that were blocked (tapones en contra, page column TC). Null on /TeamStats rows. |
| mt | integer | Dunks (mates, page column MT). Null on /TeamStats rows. |
| pf | integer | Personal fouls committed (faltas cometidas, page column FC; integer as a string). |
| rf | integer | Fouls received / drawn (faltas recibidas, page column FR; integer as a string). |
| fouls | integer | Team fouls committed in the game (equals pf on the samples). |
| val | integer | FEB efficiency rating (valoracion). Null on /TeamStats rows, filled on box-score totals. |
| fastb | integer | Fast-break points. Null on every sampled game: the federation's stat crews do not fill it. |
| ptsto | integer | Points off turnovers. Null on every sampled game: the federation's stat crews do not fill it. |
| secpts | integer | Second-chance points. Null on every sampled game: the federation's stat crews do not fill it. |
| bench | integer | Bench points. Null on every sampled game: the federation's stat crews do not fill it. |
| paint | integer | Points in the paint. Null on every sampled game: the federation's stat crews do not fill it. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

     feb_team_stats(game_id = 2535725)

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md)
