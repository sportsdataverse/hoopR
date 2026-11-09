# **TBF Team Games**

Games and results of one team-season, scheduled games included.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-matches-by-season-and-league`

## Usage

``` r
tbf_team_games(season, team_process_id, competition = "bsl")
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

A `hoopR_data` tibble. One row per game of the team (scheduled games
included). Every column below is always present (a zero-row tibble keeps
them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
| match_id | integer | TBF game id (key space: TBF games, one global sequence). |
| match_code | character | TBF short game code. |
| tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (tarih). |
| week | character | Week label (formattedWeek), e.g. '1. Hafta'. |
| city | character | City of the venue (sehir), uppercase Turkish. |
| venue | character | Venue name (salon). |
| home_team_process_id | integer | Home team-season id (takimAId; key space: TBF team registrations). |
| home_team | character | Home team name (takimA). |
| home_score | integer | Home points (skorA); null before the game. |
| away_team_process_id | integer | Away team-season id (takimBId). |
| away_team | character | Away team name (takimB). |
| away_score | integer | Away points (skorB); null before the game. |
| team_is_home | logical | True when the asked team was the home side (isHome). |
| team_won | logical | True when the asked team won (isWin); false for a loss or an unplayed game. |
| is_played | logical | True once the game has been played (isPlayed). |
| status | character | Game status text in Turkish: Oynandi = played, Oynanmadi = not played (durum). |
| status_id | integer | Game status code (durumId): 1 = played, 4 = not played. |
| has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |

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

     tbf_team_games(season = 2027, team_process_id = 265995)

## See also

[family_tbf](https://hoopR.sportsdataverse.org/reference/family_tbf.md)
lists every function in this family.
