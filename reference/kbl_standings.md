# **Get KBL Standings**

Standings of one competition with each team's season totals.

Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}`

## Usage

``` r
kbl_standings(season, division = "kbl", game_code = "01")
```

## Arguments

- season:

  Season END year (2026 = 2025-26; the inaugural 1997 season is 1997,
  the latest 2027). kbl_runtime maps it to the KBL seasonCode (47 =
  2025-26).

- division:

  'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League
  reserve league, seasonGrade 2, which has its own season codes; it
  starts with the 2009 summer edition).

- game_code:

  Competition inside the season, two digits: '01' regular season
  (default; the first stage of a D-League edition), '03' playoffs, '04'
  championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
  '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.

## Value

A `hoopR_data` tibble: Standings of one competition with each team's
season totals. The columns are always these, in this order
(sportsdataverse-py `kbl_standings`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
| season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
| game_code | character | Competition type within the season (2-digit string; code table in the README and below): 01 regular season, 03 playoffs, 04 final, ... |
| rank | integer | Standing (1 = first). |
| team_code | character | Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
| team_name | character | Team short name (Korean, e.g. Wonju DB). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
| team_name_full | character | Team full name (Korean). |
| game_count | integer | Games played (this season or competition). |
| wins | integer | Season wins of the team (the wire's TWin). |
| losses | integer | Season losses of the team (the wire's TLoss). |
| draws | integer | Draws (TDraw, always 0). |
| win_rate | double | Win fraction, 0-1. |
| win_diff | double | Games behind the leader. |
| home_wins | integer | Wins in the team's home games. |
| home_losses | integer | Losses in the team's home games. |
| away_wins | integer | Wins in the team's away games. |
| away_losses | integer | Losses in the team's away games. |
| conti_win | integer | Current winning streak (0 when the last game was a loss). |
| conti_loss | integer | Current losing streak (0 when the last game was a win). |
| conti_date | Date | Date (YYYYMMDD) the current streak started (inferred; unverified). |
| max_win | integer | Longest winning streak of the season. |
| max_loss | integer | Longest losing streak of the season. |
| last_game_date | Date | Date of the latest game counted in the row, YYYYMMDD. |
| last_five | character | The last five results as a comma-separated string, most recent first: 1 win, 0 loss (the name is cut short in the API). |
| last_game_won | logical | True when the team's latest game was a win (the wire's win; a boolean, not a count). |
| last_game_lost | logical | True when the team's latest game was a loss (inferred from conti_loss). |
| last_game_drawn | logical | True when the team's latest game was a draw (always false). |
| game_flag | logical | Boolean flag in the standings row; meaning unverified (true in the sample). |
| updated_at | character | When the standings row was written (ISO 8601 UTC timestamp). |
| score | integer | Points. Team season total for the competition (glkey). |
| fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). Team season total for the competition (glkey). |
| fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). Team season total for the competition (glkey). |
| threep | integer | Three-point field goals made (action 205). Team season total for the competition (glkey). |
| threep_a | integer | Three-point attempts, made + missed (205 + 206). Team season total for the competition (glkey). |
| ft | integer | Free throws made (action 203). Team season total for the competition (glkey). |
| ft_a | integer | Free-throw attempts, made + missed (203 + 204). Team season total for the competition (glkey). |
| dk | integer | Dunks made (action 207); included in `fg`. Team season total for the competition (glkey). |
| dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). Team season total for the competition (glkey). |
| ast | integer | Assists. Team season total for the competition (glkey). |
| bs | integer | Blocked shots. Team season total for the competition (glkey). |
| defr | integer | Defensive rebounds. Team season total for the competition (glkey). |
| offr | integer | Offensive rebounds. Team season total for the competition (glkey). |
| stl | integer | Steals. Team season total for the competition (glkey). |
| to | integer | Turnovers. Team season total for the competition (glkey). |
| team_r | integer | Team rebounds (action 218), unverified against `teamR`. Team season total for the competition (glkey). |
| pp | integer | Paint field goals made: 0 in every sampled row (see PScore). |
| pp_a | integer | Paint field-goal attempts: 0 in every sampled row (see PScore). |
| pscore | integer | Points in the paint (pp/ppA are 0 on this route in every sampled row). Team season total for the competition (glkey). |
| wft | integer | Fouls that awarded free throws (action 215). Team season total for the competition (glkey). |
| woft | integer | Fouls that awarded no free throws (action 216). Team season total for the competition (glkey). |
| foul_total | integer | Personal fouls over the season (foulTot). |
| tfb | integer | Team fast breaks (action 217). Team season total for the competition (glkey). |
| tto | integer | Team turnovers (action 223). Team season total for the competition (glkey). |
| tf | integer | Probably technical fouls (unverified; 0 in most rows). Team season total for the competition (glkey). |
| fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). Team season total for the competition (glkey). |
| ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). Team season total for the competition (glkey). |
| bf | integer | Meaning unverified (probably bench fouls; 0 in every game sample). Team season total for the competition (glkey). |
| gd | integer | Good-defense plays (action 221). Team season total for the competition (glkey). |
| idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). Team season total for the competition (glkey). |
| inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. Team season total for the competition (glkey). |
| inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. Team season total for the competition (glkey). |
| foulout | integer | Players fouled out (unverified). Team season total for the competition (glkey). |
| play_min | integer | Minutes of playing time; add `playSec` seconds. Team season total for the competition (glkey). |
| play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. Team season total for the competition (glkey). |

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
[`kbl_team_box()`](https://hoopR.sportsdataverse.org/reference/kbl_team_box.md),
[`kbl_team_tracks()`](https://hoopR.sportsdataverse.org/reference/kbl_team_tracks.md),
[`kbl_teams()`](https://hoopR.sportsdataverse.org/reference/kbl_teams.md)

## Examples

``` r
# \donttest{
  try(kbl_standings(season = 2025))
#> ── KBL Standings from api.kbl.or.kr ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:15 UTC
#> # A tibble: 10 × 64
#>    season season_code game_code  rank team_code team_name         team_name_full
#>     <int>       <int> <chr>     <int> <chr>     <chr>             <chr>         
#>  1   2025          45 01            1 55        서울 SK           서울 SK 나이츠
#>  2   2025          45 01            2 50        창원 LG           창원 LG 세이커스……
#>  3   2025          45 01            3 10        울산 현대모비스   울산 현대모비스 피버스……
#>  4   2025          45 01            4 06        수원 KT           수원 KT 소닉붐
#>  5   2025          45 01            5 64        대구 한국가스공사 대구 한국가스공사 페가수…
#>  6   2025          45 01            6 70        안양 정관장       안양 정관장 레드부스터스…
#>  7   2025          45 01            7 16        원주 DB           원주 DB 프로미
#>  8   2025          45 01            8 66        고양 소노         고양 소노 스카이거너스……
#>  9   2025          45 01            9 60        부산 KCC          부산 KCC 이지스……
#> 10   2025          45 01           10 35        서울 삼성         서울 삼성 썬더스……
#> # ℹ 57 more variables: game_count <int>, wins <int>, losses <int>, draws <int>,
#> #   win_rate <dbl>, win_diff <dbl>, home_wins <int>, home_losses <int>,
#> #   away_wins <int>, away_losses <int>, conti_win <int>, conti_loss <int>,
#> #   conti_date <date>, max_win <int>, max_loss <int>, last_game_date <date>,
#> #   last_five <chr>, last_game_won <lgl>, last_game_lost <lgl>,
#> #   last_game_drawn <lgl>, game_flag <lgl>, updated_at <chr>, score <int>,
#> #   fg <int>, fg_a <int>, threep <int>, threep_a <int>, ft <int>, ft_a <int>, …
# }
```
