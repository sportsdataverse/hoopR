# **TBF Leaders: Minutes**

Season leaders in minutes played: the server's top 20 by season total
and by per-game average.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-duration-leaders`

## Usage

``` r
tbf_leaders_minutes(season, competition = "bsl")
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

## Value

A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`),
best first. Every column below is always present (a zero-row tibble
keeps them and their types); an answer with nothing in it raises
`hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
| kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
| rank | integer | Rank in the list, 1 = best (the API's order). |
| person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
| player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
| team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
| team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
| games | integer | Games played (macSayisi, sent as a string). |
| value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |

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

     tbf_leaders_minutes(competition = "bsl", season = 2027)

## See also

[family_tbf](https://hoopR.sportsdataverse.org/reference/family_tbf.md)
lists every function in this family.
