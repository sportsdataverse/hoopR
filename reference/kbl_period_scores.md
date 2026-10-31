# **Get KBL Period Scores**

Points by period (quarters and overtimes) and side of a final game, from
the game header.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}`

## Usage

``` r
kbl_period_scores(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Points by period (quarters and overtimes) and
side of a final game, from the game header. The columns are always
these, in this order (sportsdataverse-py `kbl_period_scores`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
| side | character | Which side of the game the row belongs to: home or away. |
| team_code | character | Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
| period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
| period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
| score | integer | Points the side scored in the period. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

## See also

Other KBL Functions:
[`kbl_current_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_current_standings.md),
[`kbl_game()`](https://hoopR.sportsdataverse.org/reference/kbl_game.md),
[`kbl_game_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_game_leaders.md),
[`kbl_pbp()`](https://hoopR.sportsdataverse.org/reference/kbl_pbp.md),
[`kbl_player_box()`](https://hoopR.sportsdataverse.org/reference/kbl_player_box.md),
[`kbl_player_totals()`](https://hoopR.sportsdataverse.org/reference/kbl_player_totals.md),
[`kbl_players()`](https://hoopR.sportsdataverse.org/reference/kbl_players.md),
[`kbl_playoff_games()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_games.md),
[`kbl_playoff_seeds()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_seeds.md),
[`kbl_playoff_series()`](https://hoopR.sportsdataverse.org/reference/kbl_playoff_series.md),
[`kbl_round_mvps()`](https://hoopR.sportsdataverse.org/reference/kbl_round_mvps.md),
[`kbl_rounds()`](https://hoopR.sportsdataverse.org/reference/kbl_rounds.md),
[`kbl_schedule()`](https://hoopR.sportsdataverse.org/reference/kbl_schedule.md),
[`kbl_score_track()`](https://hoopR.sportsdataverse.org/reference/kbl_score_track.md),
[`kbl_season_leaders()`](https://hoopR.sportsdataverse.org/reference/kbl_season_leaders.md),
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md),
[`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md),
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_period_scores(gmkey = "S47G01N49"))
#> ── KBL Period Scores from api.kbl.or.kr ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:56 UTC
#> # A tibble: 8 × 10
#>   gmkey season_code season game_code game_no side  team_code period period_label
#>   <chr>       <int>  <int> <chr>       <int> <chr> <chr>      <int> <chr>       
#> 1 S47G…          47   2026 01             49 home  66             1 Q1          
#> 2 S47G…          47   2026 01             49 home  66             2 Q2          
#> 3 S47G…          47   2026 01             49 home  66             3 Q3          
#> 4 S47G…          47   2026 01             49 home  66             4 Q4          
#> 5 S47G…          47   2026 01             49 away  50             1 Q1          
#> 6 S47G…          47   2026 01             49 away  50             2 Q2          
#> 7 S47G…          47   2026 01             49 away  50             3 Q3          
#> 8 S47G…          47   2026 01             49 away  50             4 Q4          
#> # ℹ 1 more variable: score <int>
# }
```
