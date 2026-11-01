# **Get KBL Teams**

The current ten clubs with Korean and English names and the code of each
club's D-League side.

Endpoint: `GET https://api.kbl.or.kr/common/teamList`

## Usage

``` r
kbl_teams()
```

## Value

A `hoopR_data` tibble: The current ten clubs with Korean and English
names and the code of each club's D-League side. The columns are always
these, in this order (sportsdataverse-py `kbl_teams`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
| team_code_d | character | Team code of the club's D-League (reserve) side, in the same team-code space as `teamCode`. |
| team_name | character | Team short name (Korean, no space, e.g. Changwon LG); the English form is `teamNameEn`. |
| team_name_full | character | Team full name (Korean). |
| team_name_en | character | Team short name in English. |
| team_name_full_en | character | Team full name in English (e.g. 'CHANGWON LG SAKERS'). |

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
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md)

## Examples

``` r
# \donttest{
  try(kbl_teams())
#> ── KBL Teams from api.kbl.or.kr ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:17 UTC
#> # A tibble: 10 × 6
#>    team_code team_code_d team_name team_name_full team_name_en team_name_full_en
#>    <chr>     <chr>       <chr>     <chr>          <chr>        <chr>            
#>  1 16        28          원주DB    원주 DB 프로미 DB           WONJU DB PROMY   
#>  2 35        26          서울삼성  서울 삼성 썬더스…… SAMSUNG      SEOUL SAMSUNG TH…
#>  3 66        67          고양소노  고양 소노 스카이거너스…… SONO         GOYANG SONO SKY …
#>  4 55        19          서울SK    서울 SK 나이츠 SK           SEOUL SK KNIGHTS 
#>  5 50        36          창원LG    창원 LG 세이커스…… LG           CHANGWON LG SAKE…
#>  6 70        57          안양정관장…… 안양 정관장 레드부스터스… JUNG KWAN J… ANYANG JUNG KWAN…
#>  7 60        24          부산KCC   부산 KCC 이지스…… KCC          BUSAN KCC EGIS   
#>  8 06        18          수원KT    수원 KT 소닉붐 KT           SUWON KT SONICBO…
#>  9 64        68          대구한국가스공사… 대구 한국가스공사 페가수… KOREA GAS C… DAEGU KOREAGASCO…
#> 10 10        31          울산현대모비스…… 울산 현대모비스 피버스…… HYUNDAI      ULSAN HYUNDAI MO…
# }
```
