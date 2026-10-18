# **Get KZS Team Box Score**

Team totals of a final game's box score, one row per side.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`

## Usage

``` r
kzs_team_box_score(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: Team totals of a final game's box score, one row
per side. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sdv-py `kzs_team_box_score`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
| team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
| team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
| team_name | character | Name of the team for the season, sponsor included. |
| minutes | double | Team minutes: the sum of its players (200.0 = 5 x 40; 0.0 on 2015-16 team lines). |
| two_pm | integer | The team's two-point field goals made. |
| two_pa | integer | The team's two-point field goals attempted. |
| two_p_perc | double | The team's two-point percentage, 0-100. |
| three_pm | integer | The team's three-point field goals made. |
| three_pa | integer | The team's three-point field goals attempted. |
| three_p_perc | double | The team's three-point percentage, 0-100. |
| f_tm | integer | The team's free throws made. |
| f_ta | integer | The team's free throws attempted. |
| f_t_perc | double | The team's free-throw percentage, 0-100. |
| fg_m | integer | The team's field goals made. |
| fg_a | integer | The team's field goals attempted. |
| fg_perc | double | The team's field-goal percentage, 0-100. |
| offensive_rebounds | integer | The team's offensive rebounds. |
| defensive_rebounds | integer | The team's defensive rebounds. |
| total_rebounds | integer | The team's total rebounds. |
| assists | integer | The team's assists. |
| steals | integer | The team's steals. |
| turnovers | integer | The team's turnovers. |
| blocks_in_favor | integer | The team's shots blocked (blocks made). |
| blocks_against | integer | The team's own shots that were blocked. |
| foul_commited | integer | The team's fouls committed. |
| foul_received | integer | The team's fouls drawn. |
| p_ir | integer | The team's PIR, performance index rating ((points + rebounds + assists + steals + blocks + fouls drawn) - (missed field goals + missed free throws + turnovers + shots blocked + fouls committed)). |
| plus_minus | integer | The team's plus-minus: points scored minus allowed while on court (team line: the final margin). |
| assists_turnover_ratio | double | The team's assist-to-turnover ratio (0 in every sample: not computed). |
| defensive_rating | double | The team's defensive rating (0 in every sample: not computed). |
| efficiency | integer | Team efficiency (PIR); -1 on 2015-16 team lines (not computed). |
| points | integer | The team's points. |
| efficiency_custom | double | The team's custom efficiency as the federation computes it (equal to `efficiency` on player rows; 0 on team lines). |
| efficiency_game_score | double | The team's game score (0 in every sample: not computed). |
| fast_break_points_attempted | integer | The team's fast-break attempts (0 in every sample: not computed). |
| fast_break_points_made | integer | The team's fast-break makes (0 in every sample: not computed). |
| usage_percentage | double | The team's usage percentage (0 in every sample: not computed). |
| m_vp_votes | integer | The team's MVP votes (0 in every sample). |
| minus | integer | The team's points allowed on court (0 in every sample: not computed). |
| offensive_rating | double | The team's offensive rating (0 in every sample: not computed). |
| p_er | double | The team's PER (0 in every sample: not computed). |
| plus | integer | The team's points scored on court (0 in every sample: not computed). |
| points_fast_break | integer | The team's fast-break points. |
| points_in_the_paint | integer | The team's points in the paint. |
| points_in_the_paint_attempted | integer | The team's paint attempts (0 in every sample: not computed). |
| points_in_the_paint_made | integer | The team's paint makes (0 in every sample: not computed). |
| points_second_chance | integer | The team's second-chance points. |
| second_chance_points_attempted | integer | The team's second-chance attempts (0 in every sample: not computed). |
| second_chance_points_made | integer | The team's second-chance makes (0 in every sample: not computed). |
| true_shooting_attempts | integer | The team's true-shooting attempts (0 in every sample: not computed). |
| true_shooting_percentage | double | The team's true-shooting percentage (0 in every sample: not computed). |
| bench_points | integer | Points by players who did not start. |
| biggest_lead | integer | Biggest lead, points. |
| biggest_scoring_run | integer | Biggest unanswered scoring run, points. |
| fouls_bench_technical | integer | Technical fouls charged to the bench (not the coach). |
| fouls_coach_disqualifying | integer | Disqualifying fouls charged to the head coach. |
| fouls_coach_technical | integer | Technical fouls charged to the head coach. |
| fouls_disqualifying | integer | Disqualifying fouls by players (ejections). |
| fouls_offensive | integer | Offensive (charging) fouls by players. |
| fouls_on | integer | Fouls drawn by the team. |
| fouls_personal | integer | Personal fouls by players, all kinds that count toward fouling out. |
| fouls_team | integer | Team fouls (0 in every sample). |
| fouls_technical | integer | Technical fouls by players. |
| fouls_technical_other | integer | Other technical fouls (0 in every sample). |
| fouls_throw_in | integer | Throw-in fouls (0 in every sample). |
| fouls_total | integer | All fouls committed. |
| fouls_unsportsmanlike | integer | Unsportsmanlike (flagrant) fouls by players. |
| fouled_out | integer | Players fouled out (0 in every sample). |
| lead_changes | integer | Lead changes in the game. |
| points_from_turnovers | integer | Points off opponent turnovers. |
| time_leading | double | Time the team led, decimal minutes. |
| times_scores_level | integer | Times the score was tied. |
| rebounds_team | integer | Team rebounds (not credited to a player). |
| rebounds_team_defensive | integer | Defensive rebounds credited to the team, not a player. |
| rebounds_team_offensive | integer | Offensive rebounds credited to the team, not a player. |
| turnovers_team | integer | Team turnovers (not credited to a player). |

## Details

- Unofficial and unsupported: these wrappers read the public read API
  (Java/Spring, built by OnixWeb) that the kzs.si site itself calls. No
  terms of use were located (unverified), api.kzs.si/robots.txt answers
  401 and www.kzs.si/robots.txt 404, so no policy or Crawl-delay is
  published. The runtime waits at least 1 s before every request,
  retries included. Payloads are not redistributed as release assets.

- Personal data: the API serves officials' and coaches' emails, phones
  and home towns, and clubs' bank accounts and addresses, publicly. The
  parsers never output them (officials appear by name only; club
  addresses, personnel and the commissioner report are dropped). Do not
  add them back.

- Seasons are END years (2027 = 2026/2027); KZS' own season ids are
  opaque (27 = 2026/2027) and the runtime maps them. Competition ids are
  per season. Three team keys are never interchangeable: the match-team
  id (per match and side), team_id (one club team in one season) and
  club_id (across seasons). player_id is the registry id, person_id the
  person behind it.

- Errors are HTTP 400 for everything (an unknown id and a bad parameter
  alike), so the runtime raises `hoopR_asset_fetch` for it, never
  `hoopR_bad_request` or an empty frame. List routes default to 150 rows
  with no truncation signal: every list wrapper asks for a large limit
  and refuses a full page. The play-by-play and box-score wrappers, the
  leaderboards, teams, rounds and playing days each make one extra,
  cached request (the match header or the competition) to prove the
  answer is the one asked for and the game is final.

- Coverage: scores from 2007/08; box scores and play-by-play from
  2015/16. Some 2020/21 men's games have a box score but no play-by-play
  (`hoopR_no_data`): the Genius data.json (genius_match_id in
  kzs_matches) is the fallback. Shot x/y are Genius court percent; side
  (LEFT/RIGHT) names the basket end and teams switch ends at half time,
  so normalise with side before stacking shots. Advanced box-score
  fields are 0 in every observed game.

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (an empty answer or list, a competition without
  standings, a final game with no play-by-play or box score, HTTP 404),
  `hoopR_asset_fetch` (HTTP 400, the API's only error status for an
  unknown id and a bad parameter alike; any other non-2xx; a non-JSON or
  empty body; an envelope whose status is not OK; a full list page; a
  game that is not final; a body for another competition, match, team,
  player or season than the one asked for) and `hoopR_bad_request` (a
  bad argument, before any request). HTTP 500 is retried. Wrappers
  raise; they never return an empty frame for a failed fetch.

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_player_leaderboard.md),
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_team_box_score(match_id = 101839))
#> ── KZS Team Box Score from api.kzs.si ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:24:56 UTC
#> # A tibble: 2 × 77
#>   match_id team_side team_id team_name minutes two_pm two_pa two_p_perc three_pm
#>      <int> <chr>       <int> <chr>       <dbl>  <int>  <int>      <dbl>    <int>
#> 1   101839 home        17551 Perspekt…     225     26     43       60.5        7
#> 2   101839 away        17555 Terme Ol…     225     23     45       51.1       12
#> # ℹ 68 more variables: three_pa <int>, three_p_perc <dbl>, f_tm <int>,
#> #   f_ta <int>, f_t_perc <dbl>, fg_m <int>, fg_a <int>, fg_perc <dbl>,
#> #   offensive_rebounds <int>, defensive_rebounds <int>, total_rebounds <int>,
#> #   assists <int>, steals <int>, turnovers <int>, blocks_in_favor <int>,
#> #   blocks_against <int>, foul_commited <int>, foul_received <int>, p_ir <int>,
#> #   plus_minus <int>, assists_turnover_ratio <dbl>, defensive_rating <dbl>,
#> #   efficiency <int>, points <int>, efficiency_custom <dbl>, …
# }
```
