# **TBF Player Box Score**

Player box score of a finished game: minutes, shooting splits, rebounds,
assists, +/- and efficiency.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`

## Usage

``` r
tbf_player_box(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble. One row per player who is on the sheet;
`is_starter` marks the starting five (none flagged in 2006-07). Every
column below is always present (a zero-row tibble keeps them and their
types); an answer with nothing in it raises `hoopR_no_data`, as in
sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| side | character | Side of the game the row belongs to: home or away (from the route's isHome flag or home / away block). |
| team_process_id | integer | Team-season id of the player's side (from the game header; key space: TBF team registrations). |
| player_id | integer | TBF person id (key space: TBF persons, stable across seasons and clubs: 196413). The same value as person_id in the player and team tables and the player_id argument of tbf_player_career. |
| player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
| jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
| is_starter | logical | True for the starting five (homeTopFive / awayTopFive block); none are flagged in 2006-07. |
| seconds_played | integer | Time on court in seconds, parsed from the 'mm:ss' or 'hh:mm:ss' text the API sends (team totals sum their players, so 200:00 = 12000). |
| points | integer | Points scored in the game (or season) the row covers. |
| fg_made | integer | Field goals made, 2PT + 3PT (successfulShots). |
| fg_attempted | integer | Field goals attempted, 2PT + 3PT (shotAttempts). |
| fg_pct | integer | Field-goal percentage 0-100, rounded to an integer by the API. |
| fg2_made | integer | Two-point field goals MADE (the API calls it twoPointShots; attempts are fg2_attempted). |
| fg2_attempted | integer | Two-point field goals attempted (twoPointShotAttempts). |
| fg2_pct | integer | Two-point percentage 0-100, an integer. |
| fg3_made | integer | Three-point field goals MADE (the API calls it threePointShots). |
| fg3_attempted | integer | Three-point field goals attempted (threePointShotAttempts). |
| fg3_pct | integer | Three-point percentage 0-100, an integer. |
| ft_made | integer | Free throws MADE (serbest atis; the API calls it freeThrows). |
| ft_attempted | integer | Free throws attempted (freeThrowAttempts). |
| ft_pct | integer | Free-throw percentage 0-100, an integer. |
| off_rebounds | integer | Offensive rebounds (hucum ribaundu). |
| def_rebounds | integer | Defensive rebounds (savunma ribaundu). |
| rebounds | integer | Total rebounds (toplam ribaund). |
| assists | integer | Assists in this game (asist). |
| steals | integer | Steals in this game (top calma). |
| blocks | integer | Shots this player blocked in this game (blok). |
| turnovers | integer | Turnovers committed in this game (top kaybi). |
| fouls | integer | Personal fouls committed (faul). |
| fouls_drawn | integer | Fouls drawn (rivalFoul = foul committed by the opponent). |
| blocks_received | integer | Own shots blocked by an opponent (blocksReceived). |
| plus_minus | integer | Plus/minus while on court (plusMinus); null when the API sends ”. |
| efficiency | integer | Efficiency rating (verimlilik puani, PIR): points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - fouls. An integer on player rows. |

## Details

Official TBF app API, unofficial for SportsDataverse: the backend of the
Turkish Basketball Federation's mobile app (miniappapi.tbf.org.tr),
which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
robots.txt answers 404 on the host, and the runtime spaces requests at
least 1 s apart. SportsDataverse has not ruled on TBF's terms, so
payloads are not redistributed as release assets. The vendor's origin
hosts (nikayazilim.com) serve the same data without Cloudflare but are
deliberately not used, redirects are never followed, and
www.tbf.org.tr's interactive Turnstile is neither used nor automated.

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

Other TBF:
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
  try(tbf_player_box(match_id = 346279))
#> ── TBF Player Box Score ──────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:03:58 UTC
#> # A tibble: 24 × 33
#>    match_id side  team_process_id player_id player_name jersey_number is_starter
#>       <int> <chr>           <int>     <int> <chr>       <chr>         <lgl>     
#>  1   346279 home           265995    196413 Yiğitcan S… 3             TRUE      
#>  2   346279 home           265995    485299 Terrell Ca… 5             TRUE      
#>  3   346279 home           265995    389934 Efe Postel  22            TRUE      
#>  4   346279 home           265995    778401 Bryce Jones 32            TRUE      
#>  5   346279 home           265995    778398 Gabe Brown  44            TRUE      
#>  6   346279 home           265995    227173 Sadık Kaba… 6             FALSE     
#>  7   346279 home           265995    508900 Jamuni McN… 8             FALSE     
#>  8   346279 home           265995    778402 Zach Nutall 10            FALSE     
#>  9   346279 home           265995    736069 Tre'shawn … 15            FALSE     
#> 10   346279 home           265995    434482 Emirhan Se… 24            FALSE     
#> # ℹ 14 more rows
#> # ℹ 26 more variables: seconds_played <int>, points <int>, fg_made <int>,
#> #   fg_attempted <int>, fg_pct <int>, fg2_made <int>, fg2_attempted <int>,
#> #   fg2_pct <int>, fg3_made <int>, fg3_attempted <int>, fg3_pct <int>,
#> #   ft_made <int>, ft_attempted <int>, ft_pct <int>, off_rebounds <int>,
#> #   def_rebounds <int>, rebounds <int>, assists <int>, steals <int>,
#> #   blocks <int>, turnovers <int>, fouls <int>, fouls_drawn <int>, …
# }
```
