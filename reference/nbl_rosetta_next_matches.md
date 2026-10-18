# **NBL Rosetta Next Matches**

Each team's next matches: opponent, venue and start time.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/next/matches/for/teams/in/{org}/{season}`

## Usage

``` r
nbl_rosetta_next_matches(season, org = "nbl")
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

## Value

A `hoopR_data` tibble (one row per team and upcoming match):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| match_slug | character | URL slug of the upcoming match, e.g. sydney-kings-v-nz-breakers-men-14-10-2026. |
| match_title | character | Title of the upcoming match, e.g. Sydney Kings v NZ Breakers men 14-10-2026. |
| start_time_datetime | character | Start of the upcoming match, UTC, ISO 8601 text without an offset. |
| is_home | logical | True when the row's team is the home team of the upcoming match. |
| opponent_name | character | Name of the opponent in the upcoming match. |
| venue | character | Name of the venue (arena) of the upcoming match. |
| match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
| rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
| rosetta_opponent_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the opponent; routes that take this entity accept it as well as the DataCore id. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order (sdv-py keeps
them too).

## Details

- Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL
  documents or supports). The terms of use were not reviewed; payloads
  are not redistributed as release assets.

- Gated by a referer, not a key: every request carries Origin / Referer
  set to nbl.com.au (the runtime sends them); without them the host
  answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.

- Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for
  the 2025-26 NBL season (the stats provider changed from Genius Sports
  to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full
  event log with shot x/y for 2025-26 and, in the same shape, back to
  2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.

- One host serves three organisations; pass org='nbl' (default), 'wnbl'
  or 'nbl1'. NBL1 is the second tier (men's and women's conferences,
  calendar-year seasons).

- Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year
  is the START year for the NBL and WNBL from 1998-99 and a calendar
  year for NBL1 and the 1979-1997 winter seasons; the runtime maps it.
  Year 1998 holds two seasons (calendar 1998 and 1998-99).

- Ids: `<entity>`*id columns are DataCore ids (UUID v1; join on them),
  rosetta*`<entity>`\_id Rosetta's own. match_id is the DataCore fixture
  id every match route is keyed on.

- Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`).
  Rosetta caches a body per path and serves it whatever the query
  string, so a page cut by someone else's limit is refused
  (`hoopR_asset_fetch`); retry after the cache entry expires.

Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown
match, team, player or season id, an org or season type with nothing, or
no season in progress); `hoopR_asset_fetch` for the 403 gate body, a
stub or error envelope, a page cut by Rosetta's path cache, a body for
another org, season or entity than the one asked for, or any other
failed fetch; `hoopR_bad_request` for an unknown `org` / `season_type`,
a malformed id, or HTTP 400 / 422.

## See also

Other NBL Rosetta:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_outcomes()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_outcomes.md),
[`nbl_rosetta_player_game_log()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_game_log.md),
[`nbl_rosetta_player_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_stats.md),
[`nbl_rosetta_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_players.md),
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md),
[`nbl_rosetta_seasons_current()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons_current.md),
[`nbl_rosetta_standings()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_standings.md),
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_next_matches(org = "nbl", season = 2027))
#> ── NBL Rosetta next_matches from prod.rosetta.nbl.com.au ─── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:00:55 UTC
#> # A tibble: 10 × 16
#>    org   rosetta_team_id      team_name team_code division conference match_slug
#>    <chr> <chr>                <chr>     <chr>     <chr>    <chr>      <chr>     
#>  1 nbl   0602b1bc-8dfb-488c-… Tasmania… TAS       NA       NA         tasmania-…
#>  2 nbl   f8185bc5-2674-4293-… Brisbane… BRI       NA       NA         tasmania-…
#>  3 nbl   105249a3-251d-4a9d-… Illawarr… ILL       NA       NA         illawarra…
#>  4 nbl   39fc4268-0cdf-455f-… Sydney K… SYD       NA       NA         illawarra…
#>  5 nbl   bc5327d5-322e-4796-… Perth Wi… PER       NA       NA         perth-wil…
#>  6 nbl   41c8f340-4d0a-4d68-… Melbourn… MEL       NA       NA         perth-wil…
#>  7 nbl   3bdb8ad6-7cf0-464d-… South Ea… SEM       NA       NA         south-eas…
#>  8 nbl   3164912c-7e74-463b-… Adelaide… ADL       NA       NA         south-eas…
#>  9 nbl   6bf2a6e3-2626-491d-… Cairns T… CNS       NA       NA         cairns-ta…
#> 10 nbl   bbae77db-317d-4c17-… NZ Break… NZL       NA       NA         cairns-ta…
#> # ℹ 9 more variables: match_title <chr>, start_time_datetime <chr>,
#> #   is_home <lgl>, opponent_name <chr>, venue <chr>, match_id <chr>,
#> #   rosetta_match_id <chr>, rosetta_opponent_id <chr>, season_end_year <int>
# }
```
