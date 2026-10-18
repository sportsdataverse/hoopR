# **NBL Rosetta Players**

Roster rows of every team in a season: player bio, jersey, position and
team.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/players/in/season/{season}`

## Usage

``` r
nbl_rosetta_players(season, org = "nbl", limit = NULL, offset = NULL)
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

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

- offset:

  (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer
  one large limit.

## Value

A `hoopR_data` tibble (one row per roster entry):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| jersey_number | character | Jersey number, a STRING. |
| playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
| player_date_updated | character | Record last-edit time, ISO 8601 UTC. |
| player_first_name | character | The player's given name, e.g. Elijah. |
| player_last_name | character | The player's family name, e.g. Pepper. |
| player_date_of_birth | character | Date of birth, ISO date. |
| player_height | double | Height in centimetres. |
| player_weight | double | Weight in kilograms. |
| player_dominant_hand | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
| player_nationality | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_nationality_code | character | Nationality, ISO 3166-1 alpha-3 code. |
| player_dominant_foot | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_jersey_number | character | Jersey number, a STRING. |
| player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
| player_active | logical | Player record is active. |
| player_league | character | Rosetta league record id, UUID v4. |
| player_birthplace | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_rookie_year | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_person | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_latest_jersey_number | character | Player's most recent jersey number, a STRING. |
| player_full_name | character | Given and family name. |
| player_source_updated_at | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| player_source_provider | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
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
  try(nbl_rosetta_players(org = "nbl", season = 2026))
#> ── NBL Rosetta players from prod.rosetta.nbl.com.au ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:48:39 UTC
#> # A tibble: 195 × 33
#>    org   jersey_number playing_position player_id              rosetta_player_id
#>    <chr> <chr>         <chr>            <chr>                  <chr>            
#>  1 nbl   22            F                5c7bbb0f-410d-11f0-ab… fc35a1fb-d6b9-40…
#>  2 nbl   30            F                75e19259-410d-11f0-b4… 4afa66cc-d497-43…
#>  3 nbl   13            G                5085c036-410d-11f0-8c… a793b9cb-fb83-45…
#>  4 nbl   21            G                6b8e8e38-410d-11f0-95… 874f02e8-a2f5-4d…
#>  5 nbl   0             G                2fdd43ef-530b-11f0-93… 3ffb3584-1aba-48…
#>  6 nbl   8             G                2bb2e532-410d-11f0-9e… 2e2291aa-36b6-49…
#>  7 nbl   6             G                6aec0708-410d-11f0-83… cf991943-7063-46…
#>  8 nbl   11            G                504369dc-410d-11f0-95… 27ab462f-634a-48…
#>  9 nbl   2             F                506a8485-410d-11f0-8b… 2337cf0e-9ee7-43…
#> 10 nbl   14            F                7862645a-410d-11f0-a8… 8431bed8-a6fe-42…
#> # ℹ 185 more rows
#> # ℹ 28 more variables: player_date_updated <chr>, player_first_name <chr>,
#> #   player_last_name <chr>, player_date_of_birth <chr>, player_height <dbl>,
#> #   player_weight <dbl>, player_dominant_hand <chr>, player_gender <chr>,
#> #   player_nationality <chr>, player_nationality_code <chr>,
#> #   player_dominant_foot <chr>, player_jersey_number <chr>,
#> #   player_playing_position <chr>, player_active <lgl>, player_league <chr>, …
# }
```
