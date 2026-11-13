# **TBF Schedule**

Schedule and results of one league-season: the games of one week, or of
every week.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/get-all-matches-for-filter`

## Usage

``` r
tbf_schedule(season, competition = "bsl", week = NULL)
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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_schedule")`) and in the searchable
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
  try(tbf_schedule(competition = "bsl", season = 2027, week = 1))
#> ── TBF Schedule ───────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:57 UTC
#> # A tibble: 8 × 25
#>   match_id match_code genius_id activity_id activity_name competition season_id
#>      <int> <chr>          <int>       <int> <chr>         <chr>           <int>
#> 1   346279 1EA4917      2913588       22214 BSL 2026-2027 bsl               174
#> 2   346276 1EA4914      2913589       22214 BSL 2026-2027 bsl               174
#> 3   346280 1EA4918      2913590       22214 BSL 2026-2027 bsl               174
#> 4   346275 1EA4913      2913591       22214 BSL 2026-2027 bsl               174
#> 5   346277 1EA4915      2913592       22214 BSL 2026-2027 bsl               174
#> 6   346274 1EA4912      2913593       22214 BSL 2026-2027 bsl               174
#> 7   346278 1EA4916      2913594       22214 BSL 2026-2027 bsl               174
#> 8   346281 1EA4919      2913595       22214 BSL 2026-2027 bsl               174
#> # ℹ 18 more variables: season_label <chr>, season <int>, tipoff <dttm>,
#> #   match_date <date>, week <chr>, phase <int>, status_id <int>,
#> #   home_team_process_id <int>, home_team <chr>, home_score <int>,
#> #   away_team_process_id <int>, away_team <chr>, away_score <int>, venue <chr>,
#> #   province <chr>, gender <chr>, broadcast_channel <chr>, has_overtime <lgl>
# }
```
