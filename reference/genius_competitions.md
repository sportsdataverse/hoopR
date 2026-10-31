# **Genius Competitions**

Every competition of an org from the hosted WebStats chooser, with its
END-year season.

Endpoint:
`GET https://hosted.dcd.shared.geniussports.com/{org}/en/schedule`

One row per competition-season. `year` is the Genius year (START year
for a two-year org, the year itself for a calendar org) and `season` the
sdv END year: a two-year span in the label wins (`2019 - 20` is 2020),
else the Genius year plus one for a split org, else the year itself;
`season_rule` names the rule (NA season when none applies). `selected`
marks the competition the chooser pre-selects.

## Usage

``` r
genius_competitions(org, return_parsed = TRUE)
```

## Arguments

- org:

  Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see
  `genius_competitions()`.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the record parsed from an HTML page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | ORG code the request used (the hosted ORG, or the LiveStats ORG for the /u/ shell). |
| comp_id | integer | Genius competition id (compId): one per org competition-season; the {compId} of hosted and data/competition paths |
| label | character | Competition label as the org typed it, free text in any language: may or may not carry a season ('BASKET LEAGUE 2019 - 20', '1st division', 'Kypello Elladas' (in Greek script) = Greek Cup, 'Mavroskoufeia' (in Greek script) = Mavroskoufeia youth tournament) |
| league_id | integer | Genius league id of the org (ESAKE = 115; IBBA has two: 187 and 549) |
| year | integer | Genius season year of the competition: the START year of a two-year season (BNXT '2023-2024' = 2023), the year itself for a calendar season. null when the page gives none |
| season | integer | sdv END-year season of the competition (2026 = 2025-26) from the label span, else the Genius year; null when no rule applies. See season_rule. |
| season_rule | character | Which rule produced season: 'label span', 'genius year + 1 (split)', 'genius year (calendar)', 'label year (calendar)' or 'unknown'. |
| selected | logical | True for the competition the hosted chooser pre-selects (the org's default, not always the newest). |

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
id (`comp_id`): `genius_competitions()` lists an org's competitions with
the sdv END-year `season` (a START-year org lists 2025-26 as season
2026),
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
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_competitions(org = "ESAKE"))
#> ── Genius LiveStats competitions ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:36 UTC
#> # A tibble: 47 × 8
#>    org   comp_id label               league_id  year season season_rule selected
#>    <chr>   <int> <chr>                   <int> <int>  <int> <chr>       <lgl>   
#>  1 ESAKE   28572 1o SUPER CUP              115  2020   2021 genius yea… FALSE   
#>  2 ESAKE   30872 2o HNC COIN SUPER …       115  2021   2022 genius yea… FALSE   
#>  3 ESAKE   27218 ALL STAR                  115  2019   2020 genius yea… FALSE   
#>  4 ESAKE   28567 BASKET LEAGUE             115  2020   2021 genius yea… FALSE   
#>  5 ESAKE   25989 BASKET LEAGUE 2019…       115  2019   2020 label span  FALSE   
#>  6 ESAKE   34541 BASKET LEAGUE 2022…       115  2022   2023 label span  TRUE    
#>  7 ESAKE   22742 BETSHOP BASKET LEA…       115  2018   2019 label span  FALSE   
#>  8 ESAKE   29847 Esake Woman               115  2020   2021 genius yea… FALSE   
#>  9 ESAKE   29022 Monday’s Game Nigh…       115  2020   2021 genius yea… FALSE   
#> 10 ESAKE    5032 Nick Galis Cup            115  2014   2015 genius yea… FALSE   
#> # ℹ 37 more rows
# }
```
