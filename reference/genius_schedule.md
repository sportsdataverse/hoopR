# **Genius Schedule**

Every match of a competition (hosted WebStats): ids, status, venue,
teams and scores.

Endpoint:
`GET https://hosted.dcd.shared.geniussports.com/{org}/en/competition/{comp_id}/schedule?roundNumber={round_number}`

One row per match in page order. Scores are NA before tip-off and for
some completed games whose score the page does not print. `date_time` is
the page's text (local time, zone not stated). `link_match_id` is NA for
orgs that hide match pages (FFBB); `venue_id` is NA when the venue is
plain text. An unfilled play-off slot ('To be determined', no team or
match link) takes the scope the page's other blocks prove; a page of
nothing but such slots is refused.

## Usage

``` r
genius_schedule(org, comp_id, round_number = -1, return_parsed = TRUE)
```

## Arguments

- org:

  Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see
  [`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md).

- comp_id:

  Genius competition id: one per org competition-season (`comp_id` of
  [`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)),
  e.g. 49915.

- round_number:

  Round to list; -1 (default) lists every round of the competition.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the record parsed from an HTML page.

## Value

A `hoopR_data` tibble with one row per match in page order. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "genius_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source.

**Org and season.** Every competition is an ORG code plus a competition
id (`comp_id`):
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)
lists an org's competitions with the sdv END-year `season` (a START-year
org lists 2025-26 as season 2026),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md)
maps a game to its competition, and `data.json` itself names no date,
competition or season. The hosted ORG can differ from the LiveStats ORG
of `/u/` (NZNBL vs NZN). Match ids are one global sequence across every
Genius customer. `data.json` carries no global team or player id: `tno`
(1 or 2) and `pno` are in-game numbers; only finished games are read.

**Errors** (classed conditions, all inheriting `hoopR_error`):
`hoopR_no_data` when Genius has nothing for the request (HTTP 404, the
S3 `AccessDenied` 403, an empty 200 from the hosted host, an empty
recent-games window, a schedule or widget with no matches);
`hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius
route (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is
unknown: the CloudFront "Request blocked" 403, a rate limit or 5xx, the
intermittent HTTP 500 "A website error has occurred" page
(`transient = TRUE`: retry later), a dead connection, an error envelope,
a cut-off page, an unfinished game, or a body for another match,
competition or ORG.

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_schedule(org = "CEBL", comp_id = 47852))
#> ── Genius LiveStats schedule ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:13:49 UTC
#> # A tibble: 130 × 16
#>    match_id link_match_id comp_id org   status     date_time venue_id venue_name
#>       <int>         <int>   <int> <chr> <chr>      <chr>        <int> <chr>     
#>  1  2845983       2845983   47852 CEBL  IN_PROGRE… May 7, 2…    21669 Envision …
#>  2  2798717       2798717   47852 CEBL  COMPLETE   May 9, 2…    34313 Edmonton …
#>  3  2845984       2845984   47852 CEBL  COMPLETE   May 9, 2…    21669 Envision …
#>  4  2848269       2848269   47852 CEBL  SCHEDULED  May 12, …    32575 CAA Centre
#>  5  2798718       2798718   47852 CEBL  COMPLETE   May 12, …    26743 The Arena…
#>  6  2798720       2798720   47852 CEBL  COMPLETE   May 14, …    21667 SaskTel C…
#>  7  2798722       2798722   47852 CEBL  COMPLETE   May 15, …    31169 Verdun Au…
#>  8  2798724       2798724   47852 CEBL  COMPLETE   May 15, …    32575 CAA Centre
#>  9  2798727       2798727   47852 CEBL  COMPLETE   May 16, …    32579 Canada Li…
#> 10  2798728       2798728   47852 CEBL  COMPLETE   May 16, …    34313 Edmonton …
#> # ℹ 120 more rows
#> # ℹ 8 more variables: home_team_id <int>, home_team_name <chr>,
#> #   home_team_code <chr>, home_score <int>, away_team_id <int>,
#> #   away_team_name <chr>, away_team_code <chr>, away_score <int>
# }
```
