# **NBL Rosetta Matches**

Matches of a season: ids, teams, venue, status, scores and start time
(UTC).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/matches/in/season/{season}/{season_type}`

## Usage

``` r
nbl_rosetta_matches(
  season,
  org = "nbl",
  season_type = "all",
  limit = NULL,
  offset = NULL
)
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

- season_type:

  (*character* default `"all"`): Season type: all (every type of the
  year), regular (includes finals), preseason, in_season (cups, Blitz,
  NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`,
  `"preseason"`, `"in_season"`, `"test"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

- offset:

  (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer
  one large limit.

## Value

A `hoopR_data` tibble (one row per match):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
| external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
| date_updated | character | Record last-edit time, ISO 8601 UTC. |
| start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
| start_time_datetime | character | Tip-off, UTC; same value as start_time. |
| round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
| match_type | character | Match type: regular, final (FINAL upper case seen) |
| match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
| status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
| home_score | integer | Home final score, a STRING; null before tip-off. |
| away_score | integer | Away final score, a STRING; null before tip-off. |
| attendance | integer | Attendance, a STRING; null when not recorded. |
| match_slug | character | URL slug of the match page on nbl.com.au. |
| match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
| venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
| rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
| venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
| venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_country | character | Country; often null. |
| venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
| venue_code | character | Venue code; often null. |
| venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
| home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
| rosetta_home_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the home team; routes that take this entity accept it as well as the DataCore id. |
| home_team_name | character | Display name of the team. |
| home_team_external_team_name | character | Team name as DataCore spells it. |
| home_team_code | character | Team code of the home team, e.g. PER or SYD. |
| home_team_division_abbreviation | character | Division code, e.g. EM (East Men) |
| home_team_division_name | character | Division name (NBL1 conference + gender) |
| home_team_conference_name | character | Name of the NBL1 conference of the home team; null outside NBL1. |
| away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
| rosetta_away_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the away team; routes that take this entity accept it as well as the DataCore id. |
| away_team_name | character | Display name of the team. |
| away_team_external_team_name | character | Team name as DataCore spells it. |
| away_team_code | character | Team code of the away team, e.g. PER or SYD. |
| away_team_division_abbreviation | character | Division code, e.g. EM (East Men) |
| away_team_division_name | character | Division name (NBL1 conference + gender) |
| away_team_conference_name | character | Name of the NBL1 conference of the away team; null outside NBL1. |
| season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
| rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
| season_name | character | Season name (NBL26, WNBL 2024/25, 2025 South Men) |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
| season_competition_id | character | Rosetta competition id (UUID v4) |
| season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
| season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
| season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
| home_team_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| home_team_conference | character | Conference of the division. |
| away_team_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| away_team_conference | character | Conference of the division. |

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
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_matches(org = "nbl", season = 2026, season_type = "regular"))
#> ── NBL Rosetta matches from prod.rosetta.nbl.com.au ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:37:23 UTC
#> # A tibble: 179 × 59
#>    org   match_id  external_media_id date_updated start_time start_time_datetime
#>    <chr> <chr>     <chr>             <chr>        <chr>      <chr>              
#>  1 nbl   24d0eebf… 05042026          2026-09-22T… 2026-04-0… 2026-04-05T04:30:00
#>  2 nbl   bd142077… 70344324          2026-09-22T… 2026-04-0… 2026-04-01T08:30:00
#>  3 nbl   9c76716d… 70006744          2026-09-22T… 2026-03-2… 2026-03-29T03:30:00
#>  4 nbl   796d28c2… 70006742          2026-09-22T… 2026-03-2… 2026-03-27T08:30:00
#>  5 nbl   63d262c8… 70006740          2026-09-22T… 2026-03-2… 2026-03-21T08:00:00
#>  6 nbl   0d86ffcb… 69901490          2026-09-22T… 2026-03-1… 2026-03-17T08:30:00
#>  7 nbl   2f781bb9… 69708408          2026-09-22T… 2026-03-1… 2026-03-14T09:00:00
#>  8 nbl   a657ddb1… 69614230          2026-09-22T… 2026-03-1… 2026-03-14T06:30:00
#>  9 nbl   07aa3ed0… 69708256          2026-09-22T… 2026-03-1… 2026-03-11T08:30:00
#> 10 nbl   e63caa04… 69614226          2026-09-22T… 2026-03-1… 2026-03-10T08:30:00
#> # ℹ 169 more rows
#> # ℹ 53 more variables: round <chr>, match_type <chr>, match_status <chr>,
#> #   status <chr>, home_score <int>, away_score <int>, attendance <int>,
#> #   match_slug <chr>, match_title <chr>, venue_id <chr>,
#> #   rosetta_venue_id <chr>, venue_name <chr>, venue_address <chr>,
#> #   venue_suburb <chr>, venue_state <chr>, venue_country <chr>,
#> #   venue_capacity <int>, venue_timezone <chr>, venue_code <chr>, …
# }
```
