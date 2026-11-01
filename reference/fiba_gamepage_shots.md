# **FIBA GAMEPAGE: shots**

Shot attempts of one FIBA game (two- and three-pointers and free throws)
with their x/y.

Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`

## Usage

``` r
fiba_gamepage_shots(game_id, comp, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) FIBA game id (global): gameId of a gdap schedule
  row, e.g. 100720 = the World Cup 2023 final.

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). The
  game must belong to it. Find it with fiba_gdap_editions or
  fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list (the game-page objects `game`, `playByPlay`,
  `gameDetails`, `playersTeamA`, `playersTeamB`).

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FIBA game id (Int64), global across competitions: gdapGameId, the `<gameId>` of a game-page URL. |
| competition_id | integer | FIBA competition id (Int64) of the game's edition; the comp argument. |
| statistic_system | character | Live-stats system of the game: OVR (World Cup, Olympics) or FLS (club competitions, most qualifiers); they differ in the play-by-play action ids, order and text. |
| period | character | Period name: Q1..Q4, then OT1, OT2... |
| period_number | integer | 1-based position of the period in the game. |
| action_id | character | Action id (String): '`<n>`:`<seq>`' in OVR games (3:0015), a sequence number in FLS games; unique within the game. |
| order | integer | Sort key within the period (OVR: 1, 2, ...; FLS: 1000, 2000, ...); null on some period events. |
| clock | character | Game clock: time REMAINING in the period, 'm:ss', counting down from 10:00 (5:00 in overtime). |
| clock_seconds | integer | Seconds remaining in the period, derived from clock. |
| action_code | character | Action code: P2 two-point shot, P3 three-point shot, FT free throw, REB rebound, TREB team rebound, ASS assist, ST steal, BS block, TO turnover, TTO team turnover, FOUL foul, RFOUL foul drawn, SUBST substitution, TIMO timeout, plus period events (STARTG, STARTP, ENDP, ENDG). |
| organisation_id | integer | Stable federation or club id (Int64) of the team, the same in every competition (64 = Germany); the page's T\_`<id>` and the play-by-play oId. NOT the per-competition team_id. |
| team_side | character | A or B: whether the row is the schedule's team A or team B (null when the page does not say). |
| player_id | integer | FIBA person id (Int64), global across competitions and roles: the page's P\_`<id>`, play-by-play pId, roster personId and fiba_gdap_roster.player_id. |
| shot_type | character | Shot type derived from action_code: 2PT, 3PT or FT; null on other actions. |
| points_attempted | integer | Points the attempt was worth (2, 3 or 1), made or not; null on other actions. |
| made | logical | True when the shot went in (two-pointers, three-pointers and free throws only; null otherwise). |
| shot_x | integer | Shot x, integer pixels on a half-court image across the court width (observed 0-278, basket near x = 139). Present only on shots; free throws are 0. Which sideline is x = 0 and the scale are UNVERIFIED. |
| shot_y | integer | Shot y, integer pixels from the baseline (y = 0) towards midcourt (observed 0-224, basket near y = 25); both teams' shots are drawn on one basket. Free throws are 0. Scale UNVERIFIED. |
| has_location | logical | True when shot_x / shot_y locate the shot (two- and three-pointers); False for free throws (always 0, 0); null on other actions. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md).

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md),
[`fiba_gamepage_period_scores()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_period_scores.md),
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
  try(fiba_gamepage_shots(game_id = 100720, comp = 208182))
#> ── FIBA gamepage_shots from fiba.basketball ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:47:40 UTC
#> # A tibble: 161 × 19
#>    game_id competition_id statistic_system period period_number action_id order
#>      <int>          <int> <chr>            <chr>          <int> <chr>     <int>
#>  1  100720         208182 OVR              Q1                 1 3:0015        5
#>  2  100720         208182 OVR              Q1                 1 3:0017        7
#>  3  100720         208182 OVR              Q1                 1 3:0019        9
#>  4  100720         208182 OVR              Q1                 1 3:0020       10
#>  5  100720         208182 OVR              Q1                 1 3:0022       12
#>  6  100720         208182 OVR              Q1                 1 3:0023       13
#>  7  100720         208182 OVR              Q1                 1 3:0025       15
#>  8  100720         208182 OVR              Q1                 1 3:0027       17
#>  9  100720         208182 OVR              Q1                 1 3:0031       21
#> 10  100720         208182 OVR              Q1                 1 3:0032       23
#> # ℹ 151 more rows
#> # ℹ 12 more variables: clock <chr>, clock_seconds <int>, action_code <chr>,
#> #   organisation_id <int>, team_side <chr>, player_id <int>, shot_type <chr>,
#> #   points_attempted <int>, made <lgl>, shot_x <int>, shot_y <int>,
#> #   has_location <lgl>
# }
```
