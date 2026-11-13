# **TBF Player Box Score**

Player box score of a finished game: minutes, shooting splits, rebounds,
assists, +/- and efficiency.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`

## Usage

``` r
tbf_player_box(match_id)
```

## Arguments

- match_id:

  Required. TBF game id (integer), e.g. 346279; match_id in
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  One global sequence across leagues and seasons. Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per player who is on the sheet. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_player_box")`) and in the searchable
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
  try(tbf_player_box(match_id = 346279))
#> ── TBF Player Box Score ───────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:55 UTC
#> # A tibble: 24 × 33
#>    match_id side  team_process_id player_id player_name jersey_number is_starter
#>       <int> <chr>           <int>     <int> <chr>       <chr>         <lgl>     
#>  1   346279 home           265995    196413 Yiğitcan S… 3             TRUE      
#>  2   346279 home           265995    485299 Terrell Ca… 5             TRUE      
#>  3   346279 home           265995    389934 Efe Postel  22            TRUE      
#>  4   346279 home           265995    778401 Bryce Jones 32            TRUE      
#>  5   346279 home           265995    778398 Gabe Brown  44            TRUE      
#>  6   346279 home           265995    227173 Sadık Kaba… 6             FALSE     
#>  7   346279 home           265995    508900 Jamuni McN… 8             FALSE     
#>  8   346279 home           265995    778402 Zach Nutall 10            FALSE     
#>  9   346279 home           265995    736069 Tre'shawn … 15            FALSE     
#> 10   346279 home           265995    434482 Emirhan Se… 24            FALSE     
#> # ℹ 14 more rows
#> # ℹ 26 more variables: seconds_played <int>, points <int>, fg_made <int>,
#> #   fg_attempted <int>, fg_pct <int>, fg2_made <int>, fg2_attempted <int>,
#> #   fg2_pct <int>, fg3_made <int>, fg3_attempted <int>, fg3_pct <int>,
#> #   ft_made <int>, ft_attempted <int>, ft_pct <int>, off_rebounds <int>,
#> #   def_rebounds <int>, rebounds <int>, assists <int>, steals <int>,
#> #   blocks <int>, turnovers <int>, fouls <int>, fouls_drawn <int>, …
# }
```
