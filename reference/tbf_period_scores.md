# **TBF Period Scores**

Points each side scored in each period of a finished game, overtime
included.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-ozet`

## Usage

``` r
tbf_period_scores(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble. One row per side and period (home first). Every
column below is always present (a zero-row tibble keeps them and their
types); an answer with nothing in it raises `hoopR_no_data`, as in
sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| side | character | Side of the score: home (homeTeamScore) or away (awayTeamScore). |
| period | integer | Period number (quarter): 1-4 regulation; overtime numbering is unverified. |
| period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
| points | integer | Points the side scored IN the period (not cumulative). |

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

[family_tbf](https://hoopR.sportsdataverse.org/reference/family_tbf.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tbf_period_scores(match_id = 346279))
#> ── TBF Period Scores ──────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:24 UTC
#> # A tibble: 8 × 5
#>   match_id side  period period_type points
#>      <int> <chr>  <int>       <int>  <int>
#> 1   346279 home       1           1     27
#> 2   346279 home       2           1     21
#> 3   346279 home       3           1     27
#> 4   346279 home       4           1     15
#> 5   346279 away       1           1     16
#> 6   346279 away       2           1     31
#> 7   346279 away       3           1     21
#> 8   346279 away       4           1     21
# }
```
