# **Get KBL Shots**

Shot chart of a final game (2006-07 on): every charted shot with x/y
pixels on the full-court image.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`

## Usage

``` r
kbl_shots(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Shot chart of a final game (2006-07 on): every
charted shot with x/y pixels on the full-court image. The columns are
always these, in this order (sportsdataverse-py `kbl_shots`); an empty
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
| pcode | character | KBL player code (six-digit string) of the shooter. |
| player_name | character | Shooter's name in Korean. |
| player_name_en | character | Shooter's name in English / romanized. |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
| period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
| x | integer | Shot location x, pixels on the site's 726 x 412 full-court image (origin top-left, x along the court, right); see basket. |
| y | integer | Shot location y, pixels on the 726 x 412 full-court image (origin top-left, y down). |
| made | logical | True when the shot went in (wire o = 'O'), False when it missed ('X'). |
| basket | character | Target basket: '1' the right-hand one (x \> 363), '2' the left-hand one; teams switch baskets at half-time. |

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
[`kbl_period_scores()`](https://hoopR.sportsdataverse.org/reference/kbl_period_scores.md),
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
[`kbl_standings()`](https://hoopR.sportsdataverse.org/reference/kbl_standings.md),
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_shots(gmkey = "S47G01N49"))
#> ── KBL Shots from api.kbl.or.kr ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:31:04 UTC
#> # A tibble: 127 × 15
#>    gmkey   season_code season game_code game_no pcode player_name player_name_en
#>    <chr>         <int>  <int> <chr>       <int> <chr> <chr>       <chr>         
#>  1 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  2 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  3 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  4 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  5 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  6 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  7 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  8 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#>  9 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#> 10 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#> # ℹ 117 more rows
#> # ℹ 7 more variables: team_code <chr>, period <int>, period_label <chr>,
#> #   x <int>, y <int>, made <lgl>, basket <chr>
# }
```
