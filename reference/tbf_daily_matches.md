# **TBF Daily Matches**

Every TBF game played on one date, grouped by competition, optionally
for one league-season.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/get-daily-matches`

## Usage

``` r
tbf_daily_matches(match_date, season = NULL, competition = NULL)
```

## Arguments

- match_date:

  Required. Game date 'YYYY-MM-DD' (Turkey local date), e.g.
  '2026-10-11'.

- season:

  Optional, with competition: Season END year (2027 = the 2026-2027
  season). TBF keys a league-season by internal season and activity ids;
  the runtime reads them from the league's season list by the END year
  of the label. A year the list lacks raises `hoopR_no_data`. Default:
  games of every competition.

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl. Optional, with season. Default: every
  competition.

## Value

A `hoopR_data` tibble. One row per game with its `group_name` (the
competition group the app shows). Every column below is always present
(a zero-row tibble keeps them and their types); an answer with nothing
in it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| group_name | character | Competition group the app shows the game under (grup adi). |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| match_code | character | TBF short game code ('1EA4917'); unique per game, meaning of the letters unverified. |
| genius_id | integer | Genius Sports LiveStats match id (TBF spells it genuisId); joins the genius family. Null when TBF stored none: every game before 2018-19, many 2021-25 games and games not yet assigned one. |
| activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
| activity_name | character | Activity name ('BSL 2026-2027'). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
| season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (Europe/Istanbul, UTC+3); the API sends no offset. |
| match_date | Date | Tip-off date 'YYYY-MM-DD'; equals the MatchDate parameter (checked). |
| week | character | Week (hafta) label or number: 'N. Hafta' on schedule rows, the number on standings rows, a playoff round name later in the season. |
| phase | integer | Phase code as a string ('1' = first half of the regular season); see get-league-weeks devre_ID. |
| status_id | integer | Game status code: 1 = played (Oynandi), 4 = not played (Oynanmadi), 19 = fixture without a date and time. Cast to an integer from the 1 / 1.0 the API sends. |
| home_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
| home_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
| home_score | integer | Home points (null before the game). |
| away_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
| away_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
| away_score | integer | Away points (null before the game). |
| venue | character | Venue (salon) name. |
| province | character | Province (il) of the venue when sent, uppercase Turkish; null otherwise. |
| gender | character | Gender in Turkish when sent; empty on get-daily-matches, so null. |
| broadcast_channel | character | Broadcaster ('beINSports', 'HT SPOR', 'Youtube / TBF TV'), or ”. |
| has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |
| status | character | Game status text in Turkish: Oynandi = played, Oynanmadi = not played. |

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
[`tbf_team_roster()`](https://hoopR.sportsdataverse.org/reference/tbf_team_roster.md),
[`tbf_team_staff()`](https://hoopR.sportsdataverse.org/reference/tbf_team_staff.md),
[`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md),
[`tbf_weeks()`](https://hoopR.sportsdataverse.org/reference/tbf_weeks.md)

## Examples

``` r
# \donttest{
  try(tbf_daily_matches(match_date = "2026-10-11"))
#> ── TBF Daily Matches ──────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:49:55 UTC
#> # A tibble: 11 × 27
#>    group_name  match_id match_code genius_id activity_id activity_name 
#>    <chr>          <int> <chr>          <int>       <int> <chr>         
#>  1 Lig Maçları   346293 1EA4931      2934620       22214 BSL 2026-2027 
#>  2 Lig Maçları   345705 1BA3543      2934717       22209 KBSL 2026-2027
#>  3 Lig Maçları   345955 2EA5768      2934688       22215 TBL 2026-2027 
#>  4 Lig Maçları   346294 1EA4932      2934621       22214 BSL 2026-2027 
#>  5 Lig Maçları   345804 2BA5083      2935642       22210 TKBL 2026-2027
#>  6 Lig Maçları   345954 2EA5767      2934698       22215 TBL 2026-2027 
#>  7 Lig Maçları   346639 3EA3359      2935638       22223 TB2L 2026-2027
#>  8 Lig Maçları   346640 3EA3360      2935639       22223 TB2L 2026-2027
#>  9 Lig Maçları   345953 2EA5766      2934702       22215 TBL 2026-2027 
#> 10 Lig Maçları   345958 2EA5771      2934705       22215 TBL 2026-2027 
#> 11 Lig Maçları   346292 1EA4930      2934625       22214 BSL 2026-2027 
#> # ℹ 21 more variables: competition <chr>, season_id <int>, season_label <chr>,
#> #   season <int>, tipoff <dttm>, match_date <date>, week <chr>, phase <int>,
#> #   status_id <int>, home_team_process_id <int>, home_team <chr>,
#> #   home_score <int>, away_team_process_id <int>, away_team <chr>,
#> #   away_score <int>, venue <chr>, province <chr>, gender <chr>,
#> #   broadcast_channel <chr>, has_overtime <lgl>, status <chr>
# }
```
