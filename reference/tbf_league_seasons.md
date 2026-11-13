# **TBF League Seasons**

Every season of one TBF league (bsl back to 1966-67) with its activity
and season ids.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-leagues-and-seasons-by-prefix`

## Usage

``` r
tbf_league_seasons(competition = "bsl")
```

## Arguments

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl.

## Value

A `hoopR_data` tibble with one row per season of the league. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_league_seasons")`) and in the
searchable [return
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
  try(tbf_league_seasons(competition = "bsl"))
#> ── TBF League Seasons ─────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:17:50 UTC
#> # A tibble: 61 × 7
#>    activity_id activity_name     url   season_id season_label season competition
#>          <int> <chr>             <chr>     <int> <chr>         <int> <chr>      
#>  1       22214 BSL 2026-2027     bsl-…       174 2026-2027      2027 bsl        
#>  2       20728 BSL 2025-2026     bsl-…       172 2025-2026      2026 bsl        
#>  3       19284 BSL 2024-2025     bsl-…       170 2024-2025      2025 bsl        
#>  4       17820 Türkiye Sigorta … bsl-…       168 2023-2024      2024 bsl        
#>  5       16354 BSL 2022-2023     bsl-…       166 2022-2023      2023 bsl        
#>  6       14919 ING BSL 2021-2022 bsl-…       164 2021-2022      2022 bsl        
#>  7       13559 ING BSL 2020-2021 bsl-…       162 2020-2021      2021 bsl        
#>  8       13310 ING BSL 2019-2020 bsl-…       160 2019-2020      2020 bsl        
#>  9       10986 TAHİNCİOĞLU BSL … bsl-…       158 2018-2019      2019 bsl        
#> 10        8791 TAHİNCİOĞLU BSL … bsl-…       156 2017-2018      2018 bsl        
#> # ℹ 51 more rows
# }
```
