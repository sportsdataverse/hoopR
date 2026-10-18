# **Get CEBL Team Roster**

One team's roster in one season: player, nationality, birth date,
position and jersey.

Endpoint:
`GET https://api.data.cebl.ca/teams/{team_id}/roster/{season}/`

## Usage

``` r
cebl_roster(team_id, season)
```

## Arguments

- team_id:

  (required) CEBL team id of that season (`team_id` in cebl_standings),
  e.g. 20 (Ottawa BlackJacks).

- season:

  (required) Season: the calendar year it is played in (May to August) =
  the sdv END year (2025 = the 2025 season). The CEBL's first season
  is 2019. A season with no data answers `hoopR_no_data`.

## Value

A `hoopR_data` tibble: One team's roster in one season: player,
nationality, birth date, position and jersey. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `cebl_roster`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season of the roster asked for (from the request; the body does not echo it). |
| team_id | integer | CEBL team id of the roster asked for (from the request; the body does not echo it). |
| player_id | integer | CEBL player id (its own key space). Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| full_name | character | Player's full name. |
| nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
| birth_date | Date | Date of birth, YYYY-MM-DD (players' public bio field); null when unknown. |
| position | character | Playing position: G (guard), F (forward), C (center), or a combination such as 'C/F'; null when unknown. |
| jersey_number | character | Jersey number, as a string of up to 2 characters ('0', '00' and '1' are distinct); null when unknown. |
| photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |

## Details

- CEBL own API, owner-approved gray area: these wrappers read the
  league's own FastAPI service (api.data.cebl.ca, the backend of the
  CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle
  ships to every browser. The key is not issued to third parties and no
  developer terms were found; cebl.ca's terms of use were not reviewed.
  The runtime reads the key from the bundle at run time, falls back to a
  documented constant, never prints it, and raises `hoopR_asset_fetch`
  with a 'key rotated?' hint on a persistent 401. www.cebl.ca/robots.txt
  disallows nothing. Payloads are not redistributed as release assets;
  requests are spaced at least 1 s apart.

- Season is the calendar year (May to August) = the sdv END year: no
  mapping. The first season is 2019. An unknown season, team or player
  answers an empty list, which the runtime raises as `hoopR_no_data`.
  Ids are CEBL's own; a relocated franchise has two team ids (cebl_teams
  lists all 15).

- This API has no box-score, play-by-play or shot route. They live in
  Genius LiveStats (organisation CEBL, see the genius family):
  cebl_games and cebl_player_gamelog carry the Genius match id as
  genius_match_id, parsed from the stats URLs (derived, not fetched; the
  match of a cancelled game may have no data). home_team_id is Genius
  team 1 and away_team_id team 2 (checked on match 2600563).

- Some completed schedule rows have null scores (2026), and a cancelled
  game has status CANELLED (the API's spelling) with null or zero
  scores. The schedule lists unplayed games too, so no wrapper refuses
  an unfinished game. Aggregates are decimal strings upstream and double
  here. Players' names, nationality and birth date are the public bio;
  no contact data is served.

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty
  list, an all-null profile: an unknown season, team or player),
  `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and
  `hoopR_asset_fetch` (a key the API still refuses after one re-read,
  any other non-200, a non-JSON body, an error envelope, a body for
  another season, team or player), all inheriting `hoopR_error`. HTTP
  500 is the API's answer to a bad id and is not retried. Wrappers
  raise; they never return an empty frame.

- Deliberate divergence: a string column that the API sends as an
  object, or a list of objects, carries compact JSON here
  (`{"name":"TSN"}`), where sdv-py's String cast writes Python's
  `str(dict)` repr (`{'name': 'TSN'}`). No string column of the
  committed fixtures carries an object.

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_roster(team_id = 14, season = 2025))
#> ── CEBL Team Roster from the CEBL Stats API ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 22:13:02 UTC
#> # A tibble: 14 × 9
#>    season team_id player_id full_name         nationality   birth_date position
#>     <int>   <int>     <int> <chr>             <chr>         <date>     <chr>   
#>  1   2025      14     64732 Curtis Hollis     UNITED STATES 1998-04-25 F       
#>  2   2025      14       150 Kimbal Mackenzie  CANADA        1996-09-16 G       
#>  3   2025      14       158 Antonio Davis Jr. UNITED STATES 1995-03-15 F       
#>  4   2025      14       155 Khalil Ahmad      UNITED STATES 1996-12-24 G       
#>  5   2025      14        25 Ahmed Hill        UNITED STATES 1996-03-21 G       
#>  6   2025      14       164 Edward Ekiyor     CANADA        1997-05-03 F       
#>  7   2025      14    410754 Ron Curry         UNITED STATES 1993-07-12 G       
#>  8   2025      14     43599 Nathan Cayo       CANADA        1997-10-27 F       
#>  9   2025      14    422565 Connor Vreeken    CANADA        2000-09-25 G       
#> 10   2025      14     16088 Gatluak James     CANADA        2001-04-12 G       
#> 11   2025      14        79 Meshack Lufile    CANADA        1992-10-21 F       
#> 12   2025      14        14 Elijah Lufile     CANADA        1997-11-07 F       
#> 13   2025      14       444 Guillaume Boucard CANADA        1990-03-16 F       
#> 14   2025      14      3719 Jahvon Blair      CANADA        1998-03-27 G       
#> # ℹ 2 more variables: jersey_number <chr>, photo_url <chr>
# }
```
