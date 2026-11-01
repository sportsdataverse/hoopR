# **TBF Team Box Score**

Team totals of a finished game with the team-credited rebounds,
turnovers and fouls.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`

## Usage

``` r
tbf_team_box(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble. Two rows: home, then away. Minutes are the
players' summed seconds. Every column below is always present (a
zero-row tibble keeps them and their types); an answer with nothing in
it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| side | character | Side of the game the row belongs to: home or away (from the route's isHome flag or home / away block). |
| team_process_id | integer | Team-season id of the side (from the game header; key space: TBF team registrations). |
| seconds_played | integer | Time on court in seconds, parsed from the 'mm:ss' or 'hh:mm:ss' text the API sends (team totals sum their players, so 200:00 = 12000). |
| points | integer | Points scored in the game (or season) the row covers. |
| fg_made | integer | Team field goals made, 2PT + 3PT. |
| fg_attempted | integer | Team field goals attempted, 2PT + 3PT. |
| fg_pct | integer | Team field-goal percentage 0-100, rounded to an integer by the API. |
| fg2_made | integer | Team two-point field goals MADE (the API calls it twoPointShots). |
| fg2_attempted | integer | Team two-point field goals attempted. |
| fg2_pct | integer | Team two-point percentage 0-100, an integer. |
| fg3_made | integer | Team three-point field goals MADE (the API calls it threePointShots). |
| fg3_attempted | integer | Team three-point field goals attempted. |
| fg3_pct | integer | Team three-point percentage 0-100, an integer. |
| ft_made | integer | Team free throws MADE. |
| ft_attempted | integer | Team free throws attempted. |
| ft_pct | integer | Team free-throw percentage 0-100, an integer. |
| off_rebounds | integer | Offensive rebounds (hucum ribaundu). |
| def_rebounds | integer | Defensive rebounds (savunma ribaundu). |
| rebounds | integer | Total rebounds (toplam ribaund). |
| assists | integer | Assists in this game (asist). |
| steals | integer | Steals in this game (top calma). |
| blocks | integer | Shots this player blocked in this game (blok). |
| turnovers | integer | Turnovers committed in this game (top kaybi). |
| fouls | integer | Personal fouls committed (faul). |
| fouls_drawn | integer | Fouls drawn by the team (rivalFoul). |
| blocks_received | integer | Team shots blocked by the opponent. |
| efficiency | integer | Team efficiency rating (verimlilik puani): the players' ratings summed; a number on team rows. |
| team_off_rebounds | integer | Team offensive rebounds not credited to a player (homeTeamStats). |
| team_def_rebounds | integer | Team defensive rebounds not credited to a player. |
| team_rebounds | integer | Team rebounds not credited to a player (offensive + defensive). |
| team_turnovers | integer | Team turnovers not credited to a player. |
| team_fouls | integer | Team fouls not credited to a player (bench / coach technicals); 0 in the samples. |

## Details

Official TBF app API, unofficial for SportsDataverse: the backend of the
Turkish Basketball Federation's mobile app (miniappapi.tbf.org.tr),
which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
robots.txt answers 404 on the host, and the runtime spaces requests at
least 1 s apart. TBF's terms were not reviewed; check them before you
republish the data. The vendor's origin hosts (nikayazilim.com) serve
the same data without Cloudflare but are deliberately not used,
redirects are never followed, and www.tbf.org.tr's interactive Turnstile
is neither used nor automated.

Coverage: season and competition are parameters (`bsl` Basketbol Super
Ligi, back to 1966-67 in the league list; `tbl` second tier; `kbsl`
women, both from 2015-16). Game wrappers serve FINISHED games only (an
unfinished game raises `hoopR_asset_fetch`). Box scores exist from
2006-07 (no starters flagged that season); play-by-play and shots from
2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
game carries a Genius LiveStats id (`genius_id`, joins the `genius`
family) from 2018-19 on some seasons and on every game of 2025-26 and
later. Birth dates, contact details, photos and logos are dropped. Names
and category labels are Turkish; the column descriptions give the
English gloss.

Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404,
an unknown game or player, a season the league list lacks, an empty
list, a finished game before 2025-26 asked for play-by-play or shots);
`hoopR_bad_request` for an invalid argument or HTTP 400 / 422;
`hoopR_asset_fetch` when the fetch failed or the answer is not the one
asked for (an unfinished game, a body for another game, season, league
or team, an error envelope, a redirect, a partial page or a changed
capped list). All inherit `hoopR_error`. Timestamps are Turkey local
time (`Europe/Istanbul`).

## See also

Other TBF Functions:
[`tbf_daily_matches()`](https://hoopR.sportsdataverse.org/reference/tbf_daily_matches.md),
[`tbf_game_header()`](https://hoopR.sportsdataverse.org/reference/tbf_game_header.md),
[`tbf_game_leaders()`](https://hoopR.sportsdataverse.org/reference/tbf_game_leaders.md),
[`tbf_game_players()`](https://hoopR.sportsdataverse.org/reference/tbf_game_players.md),
[`tbf_highlights()`](https://hoopR.sportsdataverse.org/reference/tbf_highlights.md),
[`tbf_leaders_assists()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_assists.md),
[`tbf_leaders_blocks()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_blocks.md),
[`tbf_leaders_efficiency()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_efficiency.md),
[`tbf_leaders_minutes()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_minutes.md),
[`tbf_leaders_points()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_points.md),
[`tbf_leaders_rebounds()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_rebounds.md),
[`tbf_leaders_steals()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_steals.md),
[`tbf_leaders_threes()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_threes.md),
[`tbf_leaders_turnovers()`](https://hoopR.sportsdataverse.org/reference/tbf_leaders_turnovers.md),
[`tbf_league_seasons()`](https://hoopR.sportsdataverse.org/reference/tbf_league_seasons.md),
[`tbf_leagues()`](https://hoopR.sportsdataverse.org/reference/tbf_leagues.md),
[`tbf_pbp()`](https://hoopR.sportsdataverse.org/reference/tbf_pbp.md),
[`tbf_period_scores()`](https://hoopR.sportsdataverse.org/reference/tbf_period_scores.md),
[`tbf_player_box()`](https://hoopR.sportsdataverse.org/reference/tbf_player_box.md),
[`tbf_player_career()`](https://hoopR.sportsdataverse.org/reference/tbf_player_career.md),
[`tbf_players()`](https://hoopR.sportsdataverse.org/reference/tbf_players.md),
[`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md),
[`tbf_seasons()`](https://hoopR.sportsdataverse.org/reference/tbf_seasons.md),
[`tbf_shots()`](https://hoopR.sportsdataverse.org/reference/tbf_shots.md),
[`tbf_standings()`](https://hoopR.sportsdataverse.org/reference/tbf_standings.md),
[`tbf_team_games()`](https://hoopR.sportsdataverse.org/reference/tbf_team_games.md),
[`tbf_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/tbf_team_player_stats.md),
[`tbf_team_roster()`](https://hoopR.sportsdataverse.org/reference/tbf_team_roster.md),
[`tbf_team_staff()`](https://hoopR.sportsdataverse.org/reference/tbf_team_staff.md),
[`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md),
[`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md)

## Examples

``` r
# \donttest{
  try(tbf_team_box(match_id = 346279))
#> ── TBF Team Box Score ─────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:50:08 UTC
#> # A tibble: 2 × 33
#>   match_id side  team_process_id seconds_played points fg_made fg_attempted
#>      <int> <chr>           <int>          <int>  <int>   <int>        <int>
#> 1   346279 home           265995          12000     90      30           64
#> 2   346279 away           265993          12000     89      29           59
#> # ℹ 26 more variables: fg_pct <int>, fg2_made <int>, fg2_attempted <int>,
#> #   fg2_pct <int>, fg3_made <int>, fg3_attempted <int>, fg3_pct <int>,
#> #   ft_made <int>, ft_attempted <int>, ft_pct <int>, off_rebounds <int>,
#> #   def_rebounds <int>, rebounds <int>, assists <int>, steals <int>,
#> #   blocks <int>, turnovers <int>, fouls <int>, fouls_drawn <int>,
#> #   blocks_received <int>, efficiency <int>, team_off_rebounds <int>,
#> #   team_def_rebounds <int>, team_rebounds <int>, team_turnovers <int>, …
# }
```
