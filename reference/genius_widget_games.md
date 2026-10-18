# **Genius Widget Games**

The latest games a league site's results widget shows (needs no proxy).

Endpoint: `GET https://widget.wh.geniussports.com/widget/?{widget_key}`

About 5 to 50 games, newest competition first. `webcast_org` is the
LiveStats ORG of the webcast link (`NZN` for the hosted `NZNBL`); a
known widget key must return its own ORG's games.

## Usage

``` r
genius_widget_games(widget_key, return_parsed = TRUE)
```

## Arguments

- widget_key:

  The league site's public widget key (the bare query string of
  `widget.wh.geniussports.com/widget/`), e.g.
  `"RFJIN037I07QV520B7WEXKV1GYNA31"` (ESAKE).

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the sdv-internal-refs capture shape of a page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | From the webcast link. Genius match id: the {matchId} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
| webcast_org | character | ORG code of the webcast link; can differ from the hosted ORG (NZNBL games link /webcast/NZN/) |
| competition_name | character | Competition label, free text |
| status | character | Status text as shown ('Final', 'Live', a tip-off time) |
| date | character | Date as shown, 'DD/MM/YYYY' in samples (format follows the widget locale; unverified for others) |
| home_team_id | integer | Home team from the `tid<N>` class. Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| home_team_code | character | Home team short code from the widget, in the local script when the org enters one. |
| home_score | integer | Home points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
| away_team_id | integer | Away team from the `tid<N>` class. Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| away_team_code | character | Away team short code from the widget, in the local script when the org enters one. |
| away_score | integer | Away points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source: payloads are not redistributed as release assets.

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

Other Genius:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_widget_games(widget_key = "RFJIN037I07QV520B7WEXKV1GYNA31"))
#> ── Genius LiveStats widget games ─────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:40:59 UTC
#> # A tibble: 7 × 11
#>   match_id webcast_org competition_name status date  home_team_id home_team_code
#>      <int> <chr>       <chr>            <chr>  <chr>        <int> <chr>         
#> 1  2902704 ESAKE       Stoiximan GBL 2… Final  17/1…        23948 ΑΕΚ           
#> 2  2902687 ESAKE       Stoiximan GBL 2… Final  17/1…        23952 KOL           
#> 3  2902689 ESAKE       Stoiximan GBL 2… Final  17/1…       203424 LEF           
#> 4  2902691 ESAKE       Stoiximan GBL 2… Final  17/1…        26336 IRA           
#> 5  2902693 ESAKE       Stoiximan GBL 2… Final  17/1…        23960 ARI           
#> 6  2902695 ESAKE       Stoiximan GBL 2… Final  18/1…       203423 FAL           
#> 7  2902697 ESAKE       Stoiximan GBL 2… Final  18/1…        23961 PAO           
#> # ℹ 4 more variables: home_score <int>, away_team_id <int>,
#> #   away_team_code <chr>, away_score <int>
# }
```
