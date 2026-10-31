# **TBF Play-by-Play**

Play-by-play of a finished game (2025-26 onward), in game order, with
the running score and an English gloss.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/game-flow`

## Usage

``` r
tbf_pbp(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble. One row per event. Games before 2025-26 raise
`hoopR_no_data`. The feed has no player id. Every column below is always
present (a zero-row tibble keeps them and their types); an answer with
nothing in it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| action_number | integer | Play sequence number (actionNumber); gaps are deleted or hidden actions. Rows are in the API's game order, and a period-end line can carry a LOWER number than the last play of the period (884 after 885 in the sample), so sort by period and clock, not by this number. |
| period | integer | Period number (quarterNumber): 1-4; overtime numbering is unverified. |
| period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
| clock | character | Game clock REMAINING in the period as 'mm:ss' (counts down from 10:00). |
| seconds_remaining | integer | Game clock remaining in the period, in seconds. |
| home_score | integer | Running home score after the play (the home half of the 'home-away' score text). |
| away_score | integer | Running away score after the play (the away half of the score text). |
| side | character | Side of the acting team (isHome); null on game events (period start / end, game end). |
| player_name | character | Acting player's name; null on game events. The feed carries no player id. |
| jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
| action | character | Play type in Turkish exactly as TBF sends it (77 values seen). |
| action_en | character | English gloss of the Turkish action, from the refs action vocabulary; null for an action not in it. |

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
[`tbf_period_scores()`](https://hoopR.sportsdataverse.org/reference/tbf_period_scores.md),
[`tbf_player_box()`](https://hoopR.sportsdataverse.org/reference/tbf_player_box.md),
[`tbf_player_career()`](https://hoopR.sportsdataverse.org/reference/tbf_player_career.md),
[`tbf_players()`](https://hoopR.sportsdataverse.org/reference/tbf_players.md),
[`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md),
[`tbf_seasons()`](https://hoopR.sportsdataverse.org/reference/tbf_seasons.md),
[`tbf_shots()`](https://hoopR.sportsdataverse.org/reference/tbf_shots.md),
[`tbf_standings()`](https://hoopR.sportsdataverse.org/reference/tbf_standings.md),
[`tbf_team_box()`](https://hoopR.sportsdataverse.org/reference/tbf_team_box.md),
[`tbf_team_games()`](https://hoopR.sportsdataverse.org/reference/tbf_team_games.md),
[`tbf_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/tbf_team_player_stats.md),
[`tbf_team_roster()`](https://hoopR.sportsdataverse.org/reference/tbf_team_roster.md),
[`tbf_team_staff()`](https://hoopR.sportsdataverse.org/reference/tbf_team_staff.md),
[`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md),
[`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md)

## Examples

``` r
# \donttest{
  try(tbf_pbp(match_id = 346279))
#> ── TBF Play-by-Play ───────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:34:50 UTC
#> # A tibble: 639 × 13
#>    match_id action_number period period_type clock seconds_remaining home_score
#>       <int>         <int>  <int>       <int> <chr>             <int>      <int>
#>  1   346279             1      1           1 10:00               600          0
#>  2   346279             2      1           1 10:00               600          0
#>  3   346279             5      1           1 09:59               599          0
#>  4   346279             6      1           1 09:59               599          0
#>  5   346279             7      1           1 09:43               583          0
#>  6   346279             8      1           1 09:43               583          0
#>  7   346279             9      1           1 09:32               572          0
#>  8   346279            10      1           1 09:29               569          0
#>  9   346279            11      1           1 09:21               561          2
#> 10   346279            13      1           1 08:54               534          2
#> # ℹ 629 more rows
#> # ℹ 6 more variables: away_score <int>, side <chr>, player_name <chr>,
#> #   jersey_number <chr>, action <chr>, action_en <chr>
# }
```
