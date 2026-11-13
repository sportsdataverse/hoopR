# **TBF Weeks**

The weeks (rounds) of one league-season, playoff rounds included.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-league-weeks`

## Usage

``` r
tbf_weeks(season, competition = "bsl")
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

A `hoopR_data` tibble with one row per week in play order. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_weeks")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(tbf_weeks(competition = "bsl", season = 2027))
#> ── TBF Weeks ──────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:59:43 UTC
#> # A tibble: 30 × 8
#>    activity_id season competition week  phase phase_name label    is_current
#>          <int>  <int> <chr>       <chr> <int> <chr>      <chr>    <lgl>     
#>  1       22214   2027 bsl         1         1 NA         Hafta 1  FALSE     
#>  2       22214   2027 bsl         2         1 NA         Hafta 2  FALSE     
#>  3       22214   2027 bsl         3         1 NA         Hafta 3  FALSE     
#>  4       22214   2027 bsl         4         1 NA         Hafta 4  FALSE     
#>  5       22214   2027 bsl         5         1 NA         Hafta 5  FALSE     
#>  6       22214   2027 bsl         6         1 NA         Hafta 6  FALSE     
#>  7       22214   2027 bsl         7         1 NA         Hafta 7  TRUE      
#>  8       22214   2027 bsl         8         1 NA         Hafta 8  FALSE     
#>  9       22214   2027 bsl         9         1 NA         Hafta 9  FALSE     
#> 10       22214   2027 bsl         10        1 NA         Hafta 10 FALSE     
#> # ℹ 20 more rows
# }
```
