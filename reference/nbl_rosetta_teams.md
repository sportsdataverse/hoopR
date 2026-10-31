# **NBL Rosetta Teams**

Every team record of an organisation: current, defunct, exhibition and
development sides.

Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/teams`

## Usage

``` r
nbl_rosetta_teams(org = "nbl", limit = NULL)
```

## Arguments

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble (one row per team record):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| team_id | character | DataCore team id (UUID v1); stable across seasons. |
| rosetta_team_id | character | Rosetta team id (UUID v4; v5 on NBL1); stable across seasons; accepted as `{team_id}`. |
| name | character | Team name as Rosetta spells it, e.g. Perth Wildcats. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| established | character | Year the club was founded; often null. |
| head_coach | character | Head coach; often null. |
| championships | character | Championships won; often null. |
| website | character | Club website URL. |
| external_media_competitor_id | character | Team id on the media/OTT service; often null. |
| conference | character | NBL1 conference of the team (name); null for NBL and WNBL teams. |
| division | character | NBL1 division of the team (name); null for NBL and WNBL teams. |
| venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
| venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_country | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
| venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
| conference_name | character | Name of the NBL1 conference the team plays in (e.g. North, South); null outside NBL1. |
| division_name | character | Division name (NBL1 conference + gender) |

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

Other NBL Rosetta Functions:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_next_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_matches.md),
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
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_teams(org = "nbl"))
#> ── NBL Rosetta teams from prod.rosetta.nbl.com.au ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:35:35 UTC
#> # A tibble: 86 × 22
#>    org   team_id          rosetta_team_id name  team_code established head_coach
#>    <chr> <chr>            <chr>           <chr> <chr>     <chr>       <chr>     
#>  1 nbl   bf0e988e-410c-1… 8d26bbf0-a2cf-… Adel… NA        NA          NA        
#>  2 nbl   bedd705b-410c-1… bbae77db-317d-… NZ B… NZL       2003        Gordon He…
#>  3 nbl   bfd26c1b-410c-1… b82a3f8a-b3d8-… Forr… NA        NA          NA        
#>  4 nbl   bf8c7fb4-410c-1… aa5dd82e-27f7-… St M… SMC       NA          NA        
#>  5 nbl   bee53184-410c-1… a898766e-bcf0-… Sout… STH       NA          NA        
#>  6 nbl   902cc282-5c76-1… a3a2db1e-315c-… Sunr… SSH       NA          NA        
#>  7 nbl   2bb351af-9a98-1… 9d3363a1-15d5-… Team… NA        NA          NA        
#>  8 nbl   c01759f4-410c-1… 9b904554-a3da-… Next… NG4       NA          NA        
#>  9 nbl   bfb698fa-410c-1… 9a4c1a5d-8eea-… Nago… NDD       NA          NA        
#> 10 nbl   c00b6850-410c-1… 9807b93f-8b98-… Next… NA        NA          NA        
#> # ℹ 76 more rows
#> # ℹ 15 more variables: championships <chr>, website <chr>,
#> #   external_media_competitor_id <chr>, conference <chr>, division <chr>,
#> #   venue_name <chr>, venue_address <chr>, venue_state <chr>,
#> #   venue_country <chr>, venue_timezone <chr>, venue_latitude <dbl>,
#> #   venue_longitude <dbl>, venue_capacity <int>, conference_name <chr>,
#> #   division_name <chr>
# }
```
