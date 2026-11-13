# **TBF Leagues**

The featured leagues (league-season activities) of one TBF season: BSL,
TBL, KBSL and the others.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-leagues-for-filter`

## Usage

``` r
tbf_leagues(season)
```

## Arguments

- season:

  Required. Season END year (2027 = the 2026-2027 season). TBF keys a
  league-season by internal season and activity ids; the runtime reads
  them from the league's season list by the END year of the label. A
  year the list lacks raises `hoopR_no_data`.

## Value

A `hoopR_data` tibble with one row per league. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_leagues")`) and in the searchable
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
  try(tbf_leagues(season = 2027))
#> ── TBF Leagues ────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:17:51 UTC
#> # A tibble: 8 × 9
#>   activity_id name        display_name competition gender season_id season_label
#>         <int> <chr>       <chr>        <chr>       <chr>      <int> <chr>       
#> 1       22214 BSL 2026-2… BSL          BSL         Erkek        174 2026-2027   
#> 2       22209 KBSL 2026-… KBSL         KBSL        Kadın        174 2026-2027   
#> 3       22215 TBL 2026-2… TBL          TBL         Erkek        174 2026-2027   
#> 4       22210 TKBL 2026-… TKBL         TKBL        Kadın        174 2026-2027   
#> 5       22223 TB2L 2026-… TB2L         TB2L        Erkek        174 2026-2027   
#> 6       23540 BGL 2026-2… BGL          BGL         Erkek        174 2026-2027   
#> 7       23541 BGLK 2026-… BGLK         BGLK        Kadın        174 2026-2027   
#> 8       23539 KBBL 2026-… KBBL         KBBL        Kadın        174 2026-2027   
#> # ℹ 2 more variables: season <int>, sort <int>
# }
```
