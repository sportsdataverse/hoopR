# **TBF Seasons**

The 20 most recent TBF seasons, domestic and international (a server
cap), newest first.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Season/get-seasons`

## Usage

``` r
tbf_seasons()
```

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_seasons")`) and in the searchable
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
  try(tbf_seasons())
#> ── TBF Seasons ────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:29 UTC
#> # A tibble: 20 × 6
#>    season_id season_label season start_date end_date   international
#>        <int> <chr>         <int> <date>     <date>     <lgl>        
#>  1       175 UA-2026-2027   2027 2026-10-01 2027-09-30 TRUE         
#>  2       174 2026-2027      2027 2026-07-01 2027-06-30 FALSE        
#>  3       173 UA-2025-2026   2026 2025-10-01 2026-09-30 TRUE         
#>  4       172 2025-2026      2026 2025-07-01 2026-06-30 FALSE        
#>  5       171 UA-2024-2025   2025 2024-10-01 2025-09-30 TRUE         
#>  6       170 2024-2025      2025 2024-07-01 2025-06-30 FALSE        
#>  7       169 UA-2023-2024   2024 2023-10-01 2024-09-30 TRUE         
#>  8       168 2023-2024      2024 2023-07-01 2024-06-30 FALSE        
#>  9       167 UA-2022-2023   2023 2022-10-01 2023-09-30 TRUE         
#> 10       166 2022-2023      2023 2022-07-01 2023-06-30 FALSE        
#> 11       165 UA-2021-2022   2022 2021-10-01 2022-09-30 TRUE         
#> 12       164 2021-2022      2022 2021-07-01 2022-06-30 FALSE        
#> 13       163 UA-2020-2021   2021 2020-10-01 2021-09-30 TRUE         
#> 14       162 2020-2021      2021 2020-07-01 2021-06-30 FALSE        
#> 15       161 UA-2019-2020   2020 2019-10-01 2020-09-30 TRUE         
#> 16       160 2019-2020      2020 2019-07-01 2020-06-30 FALSE        
#> 17       159 UA-2018-2019   2019 2018-10-01 2019-09-30 TRUE         
#> 18       158 2018-2019      2019 2018-07-01 2019-06-30 FALSE        
#> 19       157 UA-2017-2018   2018 2017-10-01 2018-09-30 TRUE         
#> 20       156 2017-2018      2018 2017-07-01 2018-06-30 FALSE        
# }
```
