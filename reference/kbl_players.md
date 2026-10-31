# **Get KBL Players**

The site's player directory (current and former players) with their
current or last team.

Endpoint: `GET https://api.kbl.or.kr/players`

## Usage

``` r
kbl_players()
```

## Value

A `hoopR_data` tibble: The site's player directory (current and former
players) with their current or last team. The columns are always these,
in this order (sportsdataverse-py `kbl_players`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
| player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
| player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
| team_code | character | Team code of the player's current or last team. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_name | character | Short name (Korean) of the player's current or last team. |
| team_name_en | character | Current team short name in English (e.g. 'JUNG KWAN JANG'). |
| back_num | character | Jersey number (string). |
| pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
| player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
| last_career | character | Meaning unverified: a season-code-like number, 'A' or ”. |

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
  try(kbl_players())
#> ── KBL Players from api.kbl.or.kr ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:31:01 UTC
#> # A tibble: 1,497 × 10
#>    pcode  player_name player_name_en   team_code team_name team_name_en back_num
#>    <chr>  <chr>       <chr>            <chr>     <chr>     <chr>        <chr>   
#>  1 290801 CJ 레슬리   CJ 레슬리        70        안양 KGC  JUNG KWAN J… "15"    
#>  2 235041 G.J 헌터    Gray Hunter      35        수원삼성  SAMSUNG      "7"     
#>  3 210070 R.F. 바셋   R.F. Bassette    60        전주KCC   KCC          "5"     
#>  4 290237 가넷 톰슨   Garnett Thompson 30        대구오리온스…… KBL          "5"     
#>  5 650016 가이 루커   Guy Terrance. R… 70        안양KT&G  JUNG KWAN J… "22"    
#>  6 290414 강권희      강권희           06        부산KT    KT           "35"    
#>  7 225032 강기중      Kang Ki Joong    16        원주동부  DB           "2"     
#>  8 245042 강대협      Kang Dae Hyup    65        인천전자랜드…… KBL          "10"    
#>  9 250058 강동희      Kang Dong Hee    16        원주동부  DB           ""      
#> 10 291192 강바일      KANG B I         35        서울 삼성 SAMSUNG      "19"    
#> # ℹ 1,487 more rows
#> # ℹ 3 more variables: pos <chr>, player_flag <chr>, last_career <chr>
# }
```
