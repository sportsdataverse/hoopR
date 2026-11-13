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

A `hoopR_data` tibble with one row per team and group. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_standings")`) and in the searchable
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
  try(tbf_standings(competition = "bsl", season = 2027))
#> ── TBF Standings ──────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:17:59 UTC
#> # A tibble: 16 × 18
#>    season competition group activity_id team_process_id team_name     week  rank
#>     <int> <chr>       <chr>       <int>           <int> <chr>        <int> <int>
#>  1   2027 bsl         NA          22214          266030 TÜRK TELEKOM     7     1
#>  2   2027 bsl         NA          22214          265991 BAHÇEŞEHİR …     7     2
#>  3   2027 bsl         NA          22214          266025 FENERBAHÇE …     7     3
#>  4   2027 bsl         NA          22214          265990 ANADOLU EFES     7     4
#>  5   2027 bsl         NA          22214          266026 GALATASARAY…     7     5
#>  6   2027 bsl         NA          22214          266048 ALİAĞA PETK…     7     6
#>  7   2027 bsl         NA          22214          266029 TRABZONSPOR      7     7
#>  8   2027 bsl         NA          22214          266027 KARŞIYAKA        7     8
#>  9   2027 bsl         NA          22214          266024 ESENLER ERO…     7     9
#> 10   2027 bsl         NA          22214          265992 BEŞİKTAŞ         7    10
#> 11   2027 bsl         NA          22214          265995 TOFAŞ            7    11
#> 12   2027 bsl         NA          22214          268222 BİOTEKNO KÖ…     7    12
#> 13   2027 bsl         NA          22214          265993 PİZZABULLS …     7    13
#> 14   2027 bsl         NA          22214          265994 GLİNT ÇAYIR…     7    14
#> 15   2027 bsl         NA          22214          266028 YUKATEL DEN…     7    15
#> 16   2027 bsl         NA          22214          266176 BURSASPOR B…     7    16
#> # ℹ 10 more variables: played <int>, won <int>, lost <int>, points_for <int>,
#> #   points_against <int>, points <int>, head_to_head_points <int>,
#> #   head_to_head_diff <int>, total_diff <int>, excluded <int>
# }
```
