# **TBF Team Box Score**

Team totals of a finished game with the team-credited rebounds,
turnovers and fouls.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`

## Usage

``` r
tbf_team_box(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_team_box")`) and in the searchable
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
  try(tbf_team_box(match_id = 346279))
#> ── TBF Team Box Score ─────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:20:10 UTC
#> # A tibble: 2 × 33
#>   match_id side  team_process_id seconds_played points fg_made fg_attempted
#>      <int> <chr>           <int>          <int>  <int>   <int>        <int>
#> 1   346279 home           265995          12000     90      30           64
#> 2   346279 away           265993          12000     89      29           59
#> # ℹ 26 more variables: fg_pct <int>, fg2_made <int>, fg2_attempted <int>,
#> #   fg2_pct <int>, fg3_made <int>, fg3_attempted <int>, fg3_pct <int>,
#> #   ft_made <int>, ft_attempted <int>, ft_pct <int>, off_rebounds <int>,
#> #   def_rebounds <int>, rebounds <int>, assists <int>, steals <int>,
#> #   blocks <int>, turnovers <int>, fouls <int>, fouls_drawn <int>,
#> #   blocks_received <int>, efficiency <int>, team_off_rebounds <int>,
#> #   team_def_rebounds <int>, team_rebounds <int>, team_turnovers <int>, …
# }
```
