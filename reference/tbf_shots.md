# **TBF Shots**

Every field-goal attempt of a finished game (2025-26 onward) with its
court position.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/shot-chart`

## Usage

``` r
tbf_shots(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble. One row per attempt. `x` and `y` are percentages
of a horizontal full court. Every column below is always present (a
zero-row tibble keeps them and their types); an answer with nothing in
it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
| period | integer | Period number of the attempt: 1-4; overtime numbering is unverified. |
| period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
| side | character | Side of the shooting team (isHome). |
| shot_player_id | integer | Shooter id in the SHOT-CHART key space, which is NOT the TBF person id of the box score (Quentin Peterson = 2814324 here, 501076 as a TBF person): join shots to box rows on player_name + jersey_number + side. |
| player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
| jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
| x | integer | Court x position: integer percent (0-100) of the LENGTH of a horizontal full court from the LEFT baseline (baskets near 5 and 95); teams change ends at half-time. Metres (x / 100 x 28) are an inference. |
| y | integer | Court y position: integer percent (0-100) of the court WIDTH from the BOTTOM sideline (baskets near 50), verified from the app's drawing code (top = 100 - y). Metres (y / 100 x 15) are an inference. |
| made | logical | True when the attempt was made (isSucceed). |

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
  try(tbf_shots(match_id = 346279))
#> ── TBF Shots ──────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:09:40 UTC
#> # A tibble: 123 × 10
#>    match_id period period_type side  shot_player_id player_name    jersey_number
#>       <int>  <int>       <int> <chr>          <int> <chr>          <chr>        
#>  1   346279      1           1 away         2814324 Quentin Peter… 77           
#>  2   346279      1           1 home         2814314 Terrell Carte… 5            
#>  3   346279      1           1 away         2814324 Quentin Peter… 77           
#>  4   346279      1           1 away         2814322 Damien Jeffer… 23           
#>  5   346279      1           1 away         2814320 Boubacar Toure 21           
#>  6   346279      1           1 away         2814320 Boubacar Toure 21           
#>  7   346279      1           1 home         2511112 Yiğitcan Sayb… 3            
#>  8   346279      1           1 home         2511112 Yiğitcan Sayb… 3            
#>  9   346279      1           1 home         2814319 Gabe Brown     44           
#> 10   346279      1           1 home         2814317 Bryce Jones    32           
#> # ℹ 113 more rows
#> # ℹ 3 more variables: x <int>, y <int>, made <lgl>
# }
```
