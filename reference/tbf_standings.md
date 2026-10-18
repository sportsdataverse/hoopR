# **TBF Standings**

League table of one league-season after a week (default the latest), one
row per team and group.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-standings-table`

## Usage

``` r
tbf_standings(season, competition = "bsl", week = NULL)
```

## Arguments

- season:

  Required. Season END year (2027 = the 2026-2027 season). TBF keys a
  league-season by internal season and activity ids; the runtime reads
  them from the league's season list by the END year of the label. A
  year the list lacks raises `hoopR_no_data`.

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl.

- week:

  Week (hafta) number as returned by
  [`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md),
  e.g. 1; playoff rounds continue the numbering (31-33 in 2025-26).
  Default: the latest week for standings, every week for the schedule.

## Value

A `hoopR_data` tibble. One row per team and group. Tie-break detail rows
(`tiedRows`) are not included. Every column below is always present (a
zero-row tibble keeps them and their types); an answer with nothing in
it raises `hoopR_no_data`, as in sdv-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| group | character | Group name (grup); empty for a single-group league. |
| activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
| team_process_id | integer | Team-season id (teamProcessId = takimIslemId, a team REGISTRATION; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The team_process_id argument of the team wrappers; not the stable club_id. |
| team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
| week | integer | The week the table is computed after (hafta); equals the week argument, else the latest. |
| rank | integer | League rank (sira) after that week. |
| played | integer | Games played (o = oynanan). |
| won | integer | Games won (g = galibiyet). |
| lost | integer | Games lost (m = maglubiyet). |
| points_for | integer | Points scored (a = atilan). |
| points_against | integer | Points conceded (y = yenilen). |
| points | integer | League points (puan): 2 for a win, 1 for a loss. |
| head_to_head_points | integer | Head-to-head league points among teams tied on points (icP = ic puan). |
| head_to_head_diff | integer | Head-to-head point difference among teams tied on points (icA = ic averaj). |
| total_diff | integer | Total point difference over all games (toA = toplam averaj). |
| excluded | integer | Exclusion marker (ihrac = expulsion); 0 for teams still in the league. |

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
  try(tbf_standings(competition = "bsl", season = 2027))
#> ── TBF Standings ─────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:43:56 UTC
#> # A tibble: 16 × 18
#>    season competition group activity_id team_process_id team_name     week  rank
#>     <int> <chr>       <chr>       <int>           <int> <chr>        <int> <int>
#>  1   2027 bsl         NA          22214          265991 BAHÇEŞEHİR …     4     1
#>  2   2027 bsl         NA          22214          266030 TÜRK TELEKOM     4     2
#>  3   2027 bsl         NA          22214          266029 TRABZONSPOR      4     3
#>  4   2027 bsl         NA          22214          265990 ANADOLU EFES     4     4
#>  5   2027 bsl         NA          22214          266027 KARŞIYAKA        4     5
#>  6   2027 bsl         NA          22214          268222 BİOTEKNO KÖ…     4     6
#>  7   2027 bsl         NA          22214          266048 ALİAĞA PETK…     4     7
#>  8   2027 bsl         NA          22214          266025 FENERBAHÇE …     4     8
#>  9   2027 bsl         NA          22214          265995 TOFAŞ            4     9
#> 10   2027 bsl         NA          22214          266024 ESENLER ERO…     4    10
#> 11   2027 bsl         NA          22214          265993 PİZZABULLS …     4    11
#> 12   2027 bsl         NA          22214          266028 YUKATEL DEN…     4    12
#> 13   2027 bsl         NA          22214          266176 BURSASPOR B…     4    13
#> 14   2027 bsl         NA          22214          266026 GALATASARAY…     4    14
#> 15   2027 bsl         NA          22214          265992 BEŞİKTAŞ         4    15
#> 16   2027 bsl         NA          22214          265994 GLİNT ÇAYIR…     4    16
#> # ℹ 10 more variables: played <int>, won <int>, lost <int>, points_for <int>,
#> #   points_against <int>, points <int>, head_to_head_points <int>,
#> #   head_to_head_diff <int>, total_diff <int>, excluded <int>
# }
```
