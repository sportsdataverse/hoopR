# **TBF Game Header**

Game header of a finished game: teams, coaches, final score, officials,
venue and the Genius LiveStats id.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-header`

## Usage

``` r
tbf_game_header(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_game_header")`) and in the
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
  try(tbf_game_header(match_id = 346279))
#> ── TBF Game Header ────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:25 UTC
#> # A tibble: 1 × 27
#>   match_id match_code genius_id activity_id activity_name season_id season_label
#>      <int> <chr>          <int>       <int> <chr>             <int> <chr>       
#> 1   346279 1EA4917      2913588       22214 BSL 2026-2027       174 2026-2027   
#> # ℹ 20 more variables: season <int>, tipoff <dttm>, status_id <int>,
#> #   status <chr>, venue <chr>, attendance <int>, has_overtime <lgl>,
#> #   broadcast_channel <chr>, home_team_process_id <int>, home_team <chr>,
#> #   home_coach <chr>, home_score <int>, away_team_process_id <int>,
#> #   away_team <chr>, away_coach <chr>, away_score <int>, referee <chr>,
#> #   first_assistant_referee <chr>, second_assistant_referee <chr>,
#> #   commissioner <chr>
# }
```
