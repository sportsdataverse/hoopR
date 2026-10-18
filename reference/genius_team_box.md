# **Genius Team Box Score**

Team box score of a finished game: score by period, fouls, timeouts and
the team totals.

Endpoint:
`GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`

One row per team (`tno` 1 and 2; the feed has no team id). Percentages
are numeric 0-100. `ot_score` is the points in overtime (NA without
overtime).

## Usage

``` r
genius_team_box(match_id, return_parsed = TRUE)
```

## Arguments

- match_id:

  Genius match id (`match_id` of
  [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
  [`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md)
  or
  [`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md)),
  e.g. 2902690.

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
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
| name | character | Team name as the org enters it |
| name_international | character | Team name in Latin script |
| short_name | character | Short team name (shortName in the feed), in the competition's own script when the org enters one. |
| code | character | Team code, three letters as entered (may be in the local script, e.g. Greek 'AEK' in Greek script) |
| code_international | character | Team code in Latin script |
| coach | character | Head coach display name |
| score | integer | Team points (current or final); a numeric string in the 2014-15 era sample (WBBL 12248), an integer since |
| full_score | integer | Team points including overtime; equal to score in every sample (a numeric string in the 2014-15 era) |
| p1_score | integer | Points scored in period 1 (a numeric string in the 2014-15 era) |
| p2_score | integer | Points scored in period 2 (a numeric string in the 2014-15 era) |
| p3_score | integer | Points scored in period 3 (a numeric string in the 2014-15 era) |
| p4_score | integer | Points scored in period 4 (a numeric string in the 2014-15 era) |
| ot_score | integer | Points the team scored in overtime; null without overtime. Whether several overtimes are summed is unverified. |
| fouls | integer | Team fouls in the current (last) period |
| timeouts | integer | Timeouts counter of the current period (unverified: remaining vs taken); 0 in every sampled (finished) game |
| minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
| seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes \* 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
| field_goals_made | integer | Team total: field goals made |
| field_goals_attempted | integer | Team total: field goals attempted |
| field_goals_percentage | numeric | Team total: field-goal percentage, 0-100, rounded to an integer by the feed |
| three_pointers_made | integer | Team total: three-pointers made |
| three_pointers_attempted | integer | Team total: three-pointers attempted |
| three_pointers_percentage | numeric | Team total: three-point percentage, 0-100, rounded to an integer |
| two_pointers_made | integer | Team total: two-pointers made |
| two_pointers_attempted | integer | Team total: two-pointers attempted |
| two_pointers_percentage | numeric | Team total: two-point percentage, 0-100, rounded to an integer |
| free_throws_made | integer | Team total: free throws made |
| free_throws_attempted | integer | Team total: free throws attempted |
| free_throws_percentage | numeric | Team total: free-throw percentage, 0-100, rounded to an integer |
| rebounds_defensive | integer | Team total: defensive rebounds |
| rebounds_offensive | integer | Team total: offensive rebounds |
| rebounds_total | integer | Team total: total rebounds |
| assists | integer | Team total: assists |
| turnovers | integer | Team total: turnovers |
| steals | integer | Team total: steals |
| blocks | integer | Team total: blocks made |
| blocks_received | integer | Team total: own shots blocked by an opponent |
| fouls_personal | integer | Team total: personal fouls committed |
| fouls_on | integer | Team total: fouls drawn |
| points | integer | Team total: points |
| points_from_turnovers | integer | Team total: points off turnovers |
| points_second_chance | integer | Team total: second-chance points |
| points_fast_break | integer | Team total: fast-break points |
| points_in_the_paint | integer | Team total: points in the paint |
| eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Team tot_eff_2 is 2 in every 2016+ sample (a constant, not a stat). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_3 | numeric | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_4 | numeric | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff\_\* |
| bench_points | integer | Team total: points scored by non-starters |
| biggest_lead | integer | Team total: biggest lead, points |
| biggest_scoring_run | integer | Team total: biggest unanswered scoring run, points |
| lead_changes | integer | Team total: lead changes in the game (same value on both teams) |
| times_scores_level | integer | Team total: times the score was tied (same value on both teams) |
| time_leading | numeric | Team total: minutes the team led, decimal minutes (33.58 = 33 min 35 s) |
| fouls_team | integer | Team total: team (bench) fouls |
| fouls_total | integer | Team total: all fouls committed (personal + technical + team bench) |
| rebounds_team | integer | Team total: team rebounds (credited to no player) |
| rebounds_team_defensive | integer | Team total: team defensive rebounds |
| rebounds_team_offensive | integer | Team total: team offensive rebounds |
| turnovers_team | integer | Team total: team turnovers (credited to no player, e.g. shot clock) |

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
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_team_box(match_id = 2902690))
#> ── Genius LiveStats team box score ───────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:40:58 UTC
#> # A tibble: 2 × 65
#>   match_id   tno name     name_international short_name code  code_international
#>      <int> <int> <chr>    <chr>              <chr>      <chr> <chr>             
#> 1  2902690     1 Periste… Peristeri Betsson  PER        PER   PER               
#> 2  2902690     2 Iraklis… Iraklis BC         IRA        IRA   IRA               
#> # ℹ 58 more variables: coach <chr>, score <int>, full_score <int>,
#> #   p1_score <int>, p2_score <int>, p3_score <int>, p4_score <int>,
#> #   ot_score <int>, fouls <int>, timeouts <int>, minutes <chr>,
#> #   seconds_played <int>, field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_percentage <dbl>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   two_pointers_made <int>, two_pointers_attempted <int>, …
# }
```
