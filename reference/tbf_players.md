# **TBF Players**

Every player registered in one league-season (birth dates are not
returned).

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-player-list`

## Usage

``` r
tbf_players(season, competition = "bsl")
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

A `hoopR_data` tibble with one row per registered player. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tbf_players")`) and in the searchable
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
  try(tbf_players(competition = "bsl", season = 2027))
#> ── TBF Players ────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:05:49 UTC
#> # A tibble: 262 × 11
#>    season competition person_id player_name nationality nationality_code club_id
#>     <int> <chr>           <int> <chr>       <chr>       <chr>              <int>
#>  1   2027 bsl            443749 Ahmet Aldi… TÜRKİYE     TUR               246239
#>  2   2027 bsl            159631 Akın Kande… TÜRKİYE     TUR               234077
#>  3   2027 bsl            512899 Akwasi Yeb… BÜYÜK BRİT… GB                 47153
#>  4   2027 bsl            776935 Aleksa Avr… SIRBİSTAN   SRB                55636
#>  5   2027 bsl            502492 Aleksej Ni… SLOVENYA    SVN                    4
#>  6   2027 bsl            779278 Alen Smail… SIRBİSTAN   SRB                    4
#>  7   2027 bsl            441857 Alex Perez  ABD         USA               234077
#>  8   2027 bsl            778182 Alex Reese  ABD         USA               246463
#>  9   2027 bsl            393217 Ali Yiğit … TÜRKİYE     TUR                    3
#> 10   2027 bsl            222914 Alican Gün… TÜRKİYE     TUR                47153
#> # ℹ 252 more rows
#> # ℹ 4 more variables: team_name <chr>, jersey_number <chr>, prefix <chr>,
#> #   season_id <int>
# }
```
