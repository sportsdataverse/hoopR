# **TBF Team Roster**

Roster of one team-season with games, minutes and per-game points and
efficiency (birth dates dropped).

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-active-player-list-by-season-and-league`

## Usage

``` r
tbf_team_roster(season, team_process_id, competition = "bsl")
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

A `hoopR_data` tibble. One row per rostered person. Birth dates are not
returned. Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
| person_id | integer | TBF person id (personId; key space: TBF persons). |
| first_name | character | Given name as registered with TBF, mixed case ('Yigitcan'). |
| last_name | character | Family name as registered with TBF, mixed case ('Saybir'). |
| nationality | character | Nationality as a TURKISH country name (country); there is no code on this route. |
| height_cm | integer | Height in centimetres; null when TBF has none. |
| jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
| games | integer | Games played (macSayisi = game count). |
| seconds_played | integer | Season time on court in seconds (sure 'hh:mm:ss'). |
| points_per_game | double | Points per game (sayi). |
| efficiency_per_game | double | Efficiency rating per game (verimlilikPuani). |

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
[`tbf_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/tbf_team_player_stats.md),
[`tbf_team_staff()`](https://hoopR.sportsdataverse.org/reference/tbf_team_staff.md),
[`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md),
[`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md)

## Examples

``` r
# \donttest{
  try(tbf_team_roster(season = 2027, team_process_id = 265995))
#> ── TBF Team Roster ────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:46:41 UTC
#> # A tibble: 17 × 13
#>    season competition team_process_id person_id first_name last_name nationality
#>     <int> <chr>                 <int>     <int> <chr>      <chr>     <chr>      
#>  1   2027 bsl                  265995    395705 Berkay     Gönül     TÜRKİYE    
#>  2   2027 bsl                  265995    778401 Bryce      Jones     ABD        
#>  3   2027 bsl                  265995    389934 Efe        Postel    TÜRKİYE    
#>  4   2027 bsl                  265995    434482 Emirhan    Serbest   TÜRKİYE    
#>  5   2027 bsl                  265995    778398 Gabe       Brown     ABD        
#>  6   2027 bsl                  265995    508900 Jamuni     McNeace   ABD        
#>  7   2027 bsl                  265995    381976 Karahan    Efeoğlu   TÜRKİYE    
#>  8   2027 bsl                  265995    452216 Kerem      Çorumlul… TÜRKİYE    
#>  9   2027 bsl                  265995    197570 Leon       Apaydın   TÜRKİYE    
#> 10   2027 bsl                  265995    450092 Poyraz     Paşaoğlu  TÜRKİYE    
#> 11   2027 bsl                  265995    227173 Sadık      Kabaca    TÜRKİYE    
#> 12   2027 bsl                  265995    778399 Shavar     Reynolds… ABD        
#> 13   2027 bsl                  265995    450651 Soykan     Bağadır   TÜRKİYE    
#> 14   2027 bsl                  265995    485299 Terrell    Carter II ABD        
#> 15   2027 bsl                  265995    736069 Tre'shawn  Thurman   ABD        
#> 16   2027 bsl                  265995    196413 Yiğitcan   Saybir    TÜRKİYE    
#> 17   2027 bsl                  265995    778402 Zach       Nutall    ABD        
#> # ℹ 6 more variables: height_cm <int>, jersey_number <chr>, games <int>,
#> #   seconds_played <int>, points_per_game <dbl>, efficiency_per_game <dbl>
# }
```
