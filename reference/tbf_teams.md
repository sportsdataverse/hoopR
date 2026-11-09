# **TBF Teams**

Every team registered in one league-season with its team-season id
(team_process_id) and club id.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-teams-by-leauge`

## Usage

``` r
tbf_teams(season, competition = "bsl")
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

A `hoopR_data` tibble with one row per team registration. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_teams")`) and in the searchable
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
  try(tbf_teams(competition = "bsl", season = 2027))
#> ── TBF Teams ──────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:40 UTC
#> # A tibble: 16 × 9
#>    season competition team_process_id club_id team_name    city  code  season_id
#>     <int> <chr>                 <int>   <int> <chr>        <chr> <chr>     <int>
#>  1   2027 bsl                  266048    2195 ALİAĞA PETK… İZMİR PTK         174
#>  2   2027 bsl                  265990       2 ANADOLU EFES İSTA… EFS         174
#>  3   2027 bsl                  265991   55636 BAHÇEŞEHİR … İSTA… BSK         174
#>  4   2027 bsl                  265992       1 BEŞİKTAŞ     İSTA… BJK         174
#>  5   2027 bsl                  268222  246463 BİOTEKNO KÖ… KOCA… KÖR         174
#>  6   2027 bsl                  266176  246239 BURSASPOR B… BURSA BUR         174
#>  7   2027 bsl                  266024  184811 ESENLER ERO… İSTA… ERK         174
#>  8   2027 bsl                  266025       3 FENERBAHÇE … İSTA… FBT         174
#>  9   2027 bsl                  266026       4 GALATASARAY… İSTA… GSM         174
#> 10   2027 bsl                  265994  180700 GLİNT ÇAYIR… KOCA… ÇBK         174
#> 11   2027 bsl                  266027       6 KARŞIYAKA    İZMİR KSK         174
#> 12   2027 bsl                  265993  234077 PİZZABULLS … BALI… PBB         174
#> 13   2027 bsl                  265995      13 TOFAŞ        BURSA TOF         174
#> 14   2027 bsl                  266029   47153 TRABZONSPOR  TRAB… TS          174
#> 15   2027 bsl                  266030      12 TÜRK TELEKOM ANKA… TTK         174
#> 16   2027 bsl                  266028  171967 YUKATEL DEN… DENİ… YDB         174
#> # ℹ 1 more variable: season_label <chr>
# }
```
