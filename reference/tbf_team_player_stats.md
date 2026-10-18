# **TBF Team Player Stats**

Season player statistics of one team-season: totals, percentages and
per-game averages.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-statistic`

## Usage

``` r
tbf_team_player_stats(season, team_process_id, competition = "bsl")
```

## Arguments

- season:

  Required. Season END year (2027 = the 2026-2027 season). TBF keys a
  league-season by internal season and activity ids; the runtime reads
  them from the league's season list by the END year of the label. A
  year the list lacks raises `hoopR_no_data`.

- team_process_id:

  Required. Team-season id (team registration), e.g. 265995 = Tofas in
  BSL 2026-27; team_process_id in
  [`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md)
  and
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  New for every club in every league-season; not the stable club_id.

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl.

## Value

A `hoopR_data` tibble. One row per player. Every column below is always
present (a zero-row tibble keeps them and their types); an answer with
nothing in it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
| person_id | integer | TBF person id (code; key space: TBF persons, stable across seasons and clubs). |
| jersey_number | character | Shirt number (oyuncuNo) as a string. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| games | integer | Games played (macSayisi). |
| seconds_played | integer | Season total time on court in seconds (sureToplam 'hh:mm:ss'). |
| points | integer | Season total points (sayiToplam; the API sends it as a string). |
| fg_made | integer | Season field goals made (agBasarili; sent as a string). |
| fg_attempted | integer | Season field goals attempted (agDeneme). |
| fg2_made | integer | Season two-point field goals made (puan20Toplam). |
| fg2_attempted | integer | Season two-point field goals attempted (puan21Toplam). |
| fg3_made | integer | Season three-point field goals made (puan30Toplam). |
| fg3_attempted | integer | Season three-point field goals attempted (puan31Toplam). |
| ft_made | integer | Season free throws made (sA0Toplam). |
| ft_attempted | integer | Season free throws attempted (sA1Toplam). |
| def_rebounds | integer | Season defensive rebounds (drToplam). |
| off_rebounds | integer | Season offensive rebounds (hrToplam). |
| rebounds | integer | Season total rebounds (trToplam). |
| assists | integer | Season assists (asistToplam). |
| blocks | integer | Season blocks (blokToplam). |
| steals | integer | Season steals (topCalmaToplam). |
| turnovers | integer | Season turnovers (topKaybiToplam). |
| fouls | integer | Season personal fouls (faulToplam). |
| plus_minus | double | Season plus/minus contribution (oyunaKatki = contribution to the game), a decimal string. |
| efficiency | integer | Season efficiency rating total (vpToplam, verimlilik puani). |
| fg_pct | double | Field-goal percentage 0-100 with two decimals (agYuzdesi). |
| fg2_pct | double | Two-point percentage 0-100 with two decimals (ikilikYuzdesi). |
| fg3_pct | double | Three-point percentage 0-100 with two decimals (uclukYuzdesi). |
| ft_pct | double | Free-throw percentage 0-100 with two decimals (serbestAtisYuzdesi). |
| seconds_per_game | integer | Average time on court per game in seconds (sureOrtalama 'hh:mm:ss'). |
| points_per_game | double | Points per game (sayiOrtalama). |
| rebounds_per_game | double | Rebounds per game (trOrtalama). |
| assists_per_game | double | Assists per game (asistOrtalama). |
| steals_per_game | double | Steals per game (topCalmaOrtalama). |
| blocks_per_game | double | Blocks per game (blokOrtalama). |
| turnovers_per_game | double | Turnovers per game (topKaybiOrtalama). |
| efficiency_per_game | double | Efficiency rating per game (vpOrtalama). |

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
[`tbf_player_box()`](https://hoopR.sportsdataverse.org/reference/tbf_player_box.md),
[`tbf_player_career()`](https://hoopR.sportsdataverse.org/reference/tbf_player_career.md),
[`tbf_players()`](https://hoopR.sportsdataverse.org/reference/tbf_players.md),
[`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md),
[`tbf_seasons()`](https://hoopR.sportsdataverse.org/reference/tbf_seasons.md),
[`tbf_shots()`](https://hoopR.sportsdataverse.org/reference/tbf_shots.md),
[`tbf_standings()`](https://hoopR.sportsdataverse.org/reference/tbf_standings.md),
[`tbf_team_box()`](https://hoopR.sportsdataverse.org/reference/tbf_team_box.md),
[`tbf_team_games()`](https://hoopR.sportsdataverse.org/reference/tbf_team_games.md),
[`tbf_team_roster()`](https://hoopR.sportsdataverse.org/reference/tbf_team_roster.md),
[`tbf_team_staff()`](https://hoopR.sportsdataverse.org/reference/tbf_team_staff.md),
[`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md),
[`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md)

## Examples

``` r
# \donttest{
  try(tbf_team_player_stats(season = 2027, team_process_id = 265995))
#> ── TBF Team Player Stats ─────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:04:07 UTC
#> # A tibble: 11 × 40
#>    season competition team_process_id person_id jersey_number first_name
#>     <int> <chr>                 <int>     <int> <chr>         <chr>     
#>  1   2027 bsl                  265995    196413 3             Yiğitcan  
#>  2   2027 bsl                  265995    485299 5             Terrell   
#>  3   2027 bsl                  265995    227173 6             Sadık     
#>  4   2027 bsl                  265995    508900 8             Jamuni    
#>  5   2027 bsl                  265995    778402 10            Zach      
#>  6   2027 bsl                  265995    736069 15            Tre'shawn 
#>  7   2027 bsl                  265995    389934 22            Efe       
#>  8   2027 bsl                  265995    778401 32            Bryce     
#>  9   2027 bsl                  265995    778399 33            Shavar    
#> 10   2027 bsl                  265995    778398 44            Gabe      
#> 11   2027 bsl                  265995    197570 55            Leon      
#> # ℹ 34 more variables: last_name <chr>, games <int>, seconds_played <int>,
#> #   points <int>, fg_made <int>, fg_attempted <int>, fg2_made <int>,
#> #   fg2_attempted <int>, fg3_made <int>, fg3_attempted <int>, ft_made <int>,
#> #   ft_attempted <int>, def_rebounds <int>, off_rebounds <int>, rebounds <int>,
#> #   assists <int>, blocks <int>, steals <int>, turnovers <int>, fouls <int>,
#> #   plus_minus <dbl>, efficiency <int>, fg_pct <dbl>, fg2_pct <dbl>,
#> #   fg3_pct <dbl>, ft_pct <dbl>, seconds_per_game <int>, …
# }
```
