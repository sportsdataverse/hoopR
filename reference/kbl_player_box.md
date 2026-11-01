# **Get KBL Player Box Score**

Player box score of a final game with the vendor's advanced rates, one
row per player of both teams.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/player-stat`

## Usage

``` r
kbl_player_box(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Player box score of a final game with the
vendor's advanced rates, one row per player of both teams. The columns
are always these, in this order (sportsdataverse-py `kbl_player_box`);
an empty valid answer raises `hoopR_no_data`, a valid body with no rows
for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| home_away | character | Side (string): '1' home, '2' away; '3' on both teams' rows in the 1997-98 sample, so join on `player.tcode` instead. |
| started | integer | 1 when the player started the game, else 0. |
| pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
| player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
| player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
| team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| back_num | character | Jersey number (string). |
| pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
| player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
| score | integer | Points. This game. |
| fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). This game. |
| fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). This game. |
| fgt | integer | Field goals made, two- and three-point (fg + threep). This game. |
| fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). This game. |
| threep | integer | Three-point field goals made (action 205). This game. |
| threep_a | integer | Three-point attempts, made + missed (205 + 206). This game. |
| ft | integer | Free throws made (action 203). This game. |
| ft_a | integer | Free-throw attempts, made + missed (203 + 204). This game. |
| dk | integer | Dunks made (action 207); included in `fg`. This game. |
| dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). This game. |
| rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). This game. |
| offr | integer | Offensive rebounds (action 209). This game. |
| defr | integer | Defensive rebounds (action 210). This game. |
| ast | integer | Assists (action 211). This game. |
| stl | integer | Steals (action 212). This game. |
| bs | integer | Blocked shots (action 213). This game. |
| to | integer | Turnovers (action 214). This game. |
| foul | integer | Personal fouls (wft + woft). This game. |
| wft | integer | Fouls that awarded free throws (action 215). This game. |
| woft | integer | Fouls that awarded no free throws (action 216). This game. |
| pp | integer | Field goals made in the paint. This game. |
| pp_a | integer | Field-goal attempts in the paint. This game. |
| pscore | integer | Points in the paint (2 \* pp). This game. |
| sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). This game. |
| dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). This game. |
| gd | integer | Good-defense plays (action 221). This game. |
| idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). This game. |
| fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). This game. |
| ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). This game. |
| tf | integer | Probably technical fouls (unverified; 0 in most rows). This game. |
| inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. This game. |
| inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. This game. |
| play_min | integer | Minutes of playing time; add `playSec` seconds. This game. |
| play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. This game. |
| fo | integer | Fouls drawn (the player rows of a team sum to the opponent's `foul`, checked on the 2025-26 sample game). This game. |
| margin_cn | integer | Plus-minus: the point margin while the player was on court. This game. |
| offrtg | double | Offensive rating: points scored per 100 possessions (estimated). This game. |
| defrtg | double | Defensive rating: points allowed per 100 possessions (estimated). This game. |
| netrtg | double | Net rating: offrtg - defrtg. This game. |
| efg_rt | double | Effective field-goal percentage, 0-100. This game. |
| ts_rt | double | True-shooting percentage, 0-100. This game. |
| ast_rt | double | Assist rate: share of teammates' field goals assisted while on court, 0-100. This game. |
| ast_to | double | Assist-to-turnover ratio. This game. |
| ast_ratio | double | Assist ratio: assists per 100 possessions used. This game. |
| oreb_rt | double | Offensive-rebound percentage, 0-100. This game. |
| dreb_rt | double | Defensive-rebound percentage, 0-100. This game. |
| reb_rt | double | Total-rebound percentage, 0-100. This game. |
| pace | double | Possessions per 40 minutes (estimated; a player row covers his minutes on court). This game. |
| tov_rt | double | Turnover rate: turnovers per 100 possessions, 0-100. This game. |
| poss | double | Possessions (estimated). This game. |
| per | double | Player efficiency rating (KBL's formula; scale unverified). This game. |
| pie | double | Player impact estimate: share of the game's positive events, as a percentage. This game. |
| usg_rt | double | Usage rate: share of team possessions used while on court, 0-100. This game. |
| to_ratio | double | Turnover ratio: turnovers per 100 possessions used. This game. |
| minutes_played | double | Playing time in minutes (play_min + play_sec / 60), derived. |

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
  try(kbl_player_box(gmkey = "S47G01N49"))
#> ── KBL Player Box Score from api.kbl.or.kr ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:41:46 UTC
#> # A tibble: 24 × 71
#>    gmkey  season_code season game_code game_no team_code home_away started pcode
#>    <chr>        <int>  <int> <chr>       <int> <chr>     <chr>       <int> <chr>
#>  1 S47G0…          47   2026 01             49 50        2               0 2902…
#>  2 S47G0…          47   2026 01             49 50        2               0 2904…
#>  3 S47G0…          47   2026 01             49 50        2               0 2905…
#>  4 S47G0…          47   2026 01             49 50        2               0 2906…
#>  5 S47G0…          47   2026 01             49 50        2               1 2909…
#>  6 S47G0…          47   2026 01             49 50        2               1 2914…
#>  7 S47G0…          47   2026 01             49 50        2               1 2915…
#>  8 S47G0…          47   2026 01             49 50        2               1 2916…
#>  9 S47G0…          47   2026 01             49 50        2               0 2916…
#> 10 S47G0…          47   2026 01             49 50        2               1 2916…
#> # ℹ 14 more rows
#> # ℹ 62 more variables: player_name <chr>, player_name_en <chr>,
#> #   team_name <chr>, back_num <chr>, pos <chr>, player_flag <chr>, score <int>,
#> #   fg <int>, fg_a <int>, fgt <int>, fgt_a <int>, threep <int>, threep_a <int>,
#> #   ft <int>, ft_a <int>, dk <int>, dk_a <int>, rb <int>, offr <int>,
#> #   defr <int>, ast <int>, stl <int>, bs <int>, to <int>, foul <int>,
#> #   wft <int>, woft <int>, pp <int>, pp_a <int>, pscore <int>, sast <int>, …
# }
```
