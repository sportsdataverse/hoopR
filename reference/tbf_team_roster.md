# **TBF Team Roster**

Roster of one team-season with games, minutes and per-game points and
efficiency (birth dates dropped).

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-active-player-list-by-season-and-league`

## Usage

``` r
tbf_team_roster(season, team_process_id, competition = "bsl")
```

## Arguments

- season:

  Required. Season END year (2027 = the 2026-2027 season). TBF keys a
  league-season by internal season and activity ids; the runtime reads
  them from the league's season list by the END year of the label. A
  year the list lacks raises `hoopR_no_data`.

- team_process_id:

  Required. Team-season id (team registration), e.g. 265995 = Tofas in
  BSL 2026-27; team_process_id in
  [`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md)
  and
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  New for every club in every league-season; not the stable club_id.

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl.

## Value

A `hoopR_data` tibble with one row per rostered person. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_team_roster")`) and in the
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
  try(tbf_team_roster(season = 2027, team_process_id = 265995))
#> ── TBF Team Roster ────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:05:55 UTC
#> # A tibble: 18 × 13
#>    season competition team_process_id person_id first_name last_name nationality
#>     <int> <chr>                 <int>     <int> <chr>      <chr>     <chr>      
#>  1   2027 bsl                  265995    395705 Berkay     Gönül     TÜRKİYE    
#>  2   2027 bsl                  265995    778401 Bryce      Jones     ABD        
#>  3   2027 bsl                  265995    389934 Efe        Postel    TÜRKİYE    
#>  4   2027 bsl                  265995    434482 Emirhan    Serbest   TÜRKİYE    
#>  5   2027 bsl                  265995    778398 Gabe       Brown     ABD        
#>  6   2027 bsl                  265995    508900 Jamuni     McNeace   ABD        
#>  7   2027 bsl                  265995    381976 Karahan    Efeoğlu   TÜRKİYE    
#>  8   2027 bsl                  265995    452216 Kerem      Çorumlul… TÜRKİYE    
#>  9   2027 bsl                  265995    197570 Leon       Apaydın   TÜRKİYE    
#> 10   2027 bsl                  265995    732657 MANTAS     RUBSTAVI… LİTVANYA   
#> 11   2027 bsl                  265995    450092 Poyraz     Paşaoğlu  TÜRKİYE    
#> 12   2027 bsl                  265995    227173 Sadık      Kabaca    TÜRKİYE    
#> 13   2027 bsl                  265995    778399 Shavar     Reynolds… ABD        
#> 14   2027 bsl                  265995    450651 Soykan     Bağadır   TÜRKİYE    
#> 15   2027 bsl                  265995    485299 Terrell    Carter II ABD        
#> 16   2027 bsl                  265995    736069 Tre'shawn  Thurman   ABD        
#> 17   2027 bsl                  265995    196413 Yiğitcan   Saybir    TÜRKİYE    
#> 18   2027 bsl                  265995    778402 Zach       Nutall    ABD        
#> # ℹ 6 more variables: height_cm <int>, jersey_number <chr>, games <int>,
#> #   seconds_played <int>, points_per_game <dbl>, efficiency_per_game <dbl>
# }
```
