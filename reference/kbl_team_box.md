# **Get KBL Team Box Score**

Team box score of a final game with advanced rates and team-only counts,
one row per team.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/team-record`

## Usage

``` r
kbl_team_box(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: Team box score of a final game with advanced
rates and team-only counts, one row per team. The columns are always
these, in this order (sportsdataverse-py `kbl_team_box`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
| game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| score | integer | Points. This game, team total. |
| fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). This game, team total. |
| fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). This game, team total. |
| fgt | integer | Field goals made, two- and three-point (fg + threep). This game, team total. |
| fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). This game, team total. |
| threep | integer | Three-point field goals made (action 205). This game, team total. |
| threep_a | integer | Three-point attempts, made + missed (205 + 206). This game, team total. |
| ft | integer | Free throws made (action 203). This game, team total. |
| ft_a | integer | Free-throw attempts, made + missed (203 + 204). This game, team total. |
| dk | integer | Dunks made (action 207); included in `fg`. This game, team total. |
| dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). This game, team total. |
| rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). This game, team total. |
| offr | integer | Offensive rebounds (action 209). This game, team total. |
| defr | integer | Defensive rebounds (action 210). This game, team total. |
| ast | integer | Assists (action 211). This game, team total. |
| stl | integer | Steals (action 212). This game, team total. |
| bs | integer | Blocked shots (action 213). This game, team total. |
| to | integer | Turnovers (action 214). This game, team total. |
| foul | integer | Personal fouls (wft + woft). This game, team total. |
| wft | integer | Fouls that awarded free throws (action 215). This game, team total. |
| woft | integer | Fouls that awarded no free throws (action 216). This game, team total. |
| pp | integer | Field goals made in the paint. This game, team total. |
| pp_a | integer | Field-goal attempts in the paint. This game, team total. |
| pscore | integer | Points in the paint (2 \* pp). This game, team total. |
| sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). This game, team total. |
| dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). This game, team total. |
| gd | integer | Good-defense plays (action 221). This game, team total. |
| idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). This game, team total. |
| fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). This game, team total. |
| ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). This game, team total. |
| tf | integer | Probably technical fouls (unverified; 0 in most rows). This game, team total. |
| inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. This game, team total. |
| inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. This game, team total. |
| play_min | integer | Minutes of playing time summed over the players (200 = 5 x 40 in regulation); add playSec. This game, team total. |
| play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. This game, team total. |
| bf | integer | Meaning unverified (probably bench fouls; 0 in every game sample). This game, team total. |
| foulout | integer | Players fouled out (unverified). This game, team total. |
| team_r | integer | Team rebounds (action 218). This game, team total. |
| tfb | integer | Team fast breaks (action 217). This game, team total. |
| tto | integer | Team turnovers (action 223). This game, team total. |
| fb_score_cn | integer | Fast-break points. This game, team total. |
| turnover_score_cn | integer | Points off turnovers. This game, team total. |
| sec_chance_score_cn | integer | Second-chance points. This game, team total. |
| bench_score_cn | integer | Bench points. This game, team total. |
| max_conti_score_cn | integer | Longest scoring run: the most consecutive points without an opponent score. This game, team total. |
| max_lead_score_cn | integer | Largest lead, in points. This game, team total. |
| score_high_time_cn | integer | Seconds the team led (the two teams' values sum to less than the 2,400-second game when it was tied or level at times). This game, team total. |
| offrtg | double | Offensive rating: points scored per 100 possessions (estimated). This game, team total. |
| defrtg | double | Defensive rating: points allowed per 100 possessions (estimated). This game, team total. |
| netrtg | double | Net rating: offrtg - defrtg. This game, team total. |
| efg_rt | double | Effective field-goal percentage, 0-100. This game, team total. |
| ts_rt | double | True-shooting percentage, 0-100. This game, team total. |
| ast_rt | double | Assist rate: share of teammates' field goals assisted while on court, 0-100. This game, team total. |
| ast_to | double | Assist-to-turnover ratio. This game, team total. |
| ast_ratio | double | Assist ratio: assists per 100 possessions used. This game, team total. |
| oreb_rt | double | Offensive-rebound percentage, 0-100. This game, team total. |
| dreb_rt | double | Defensive-rebound percentage, 0-100. This game, team total. |
| reb_rt | double | Total-rebound percentage, 0-100. This game, team total. |
| pace | double | Possessions per 40 minutes (estimated; a player row covers his minutes on court). This game, team total. |
| tov_rt | double | Turnover rate: turnovers per 100 possessions, 0-100. This game, team total. |
| poss | double | Possessions (estimated). This game, team total. |
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
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_team_box(gmkey = "S47G01N49"))
#> ── KBL Team Box Score from api.kbl.or.kr ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:53:55 UTC
#> # A tibble: 2 × 68
#>   gmkey   season_code season game_code game_no team_code score    fg  fg_a   fgt
#>   <chr>         <int>  <int> <chr>       <int> <chr>     <int> <int> <int> <int>
#> 1 S47G01…          47   2026 01             49 50           64    14    35    25
#> 2 S47G01…          47   2026 01             49 66           74    23    43    30
#> # ℹ 58 more variables: fgt_a <int>, threep <int>, threep_a <int>, ft <int>,
#> #   ft_a <int>, dk <int>, dk_a <int>, rb <int>, offr <int>, defr <int>,
#> #   ast <int>, stl <int>, bs <int>, to <int>, foul <int>, wft <int>,
#> #   woft <int>, pp <int>, pp_a <int>, pscore <int>, sast <int>, dfl <int>,
#> #   gd <int>, idf <int>, fb <int>, ef <int>, tf <int>, inout <int>,
#> #   inout1 <int>, play_min <int>, play_sec <int>, bf <int>, foulout <int>,
#> #   team_r <int>, tfb <int>, tto <int>, fb_score_cn <int>, …
# }
```
