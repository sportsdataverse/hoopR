# **Get ESPN Women's College Basketball Team Schedule**

**Get ESPN Women's College Basketball Team Schedule**

**Get ESPN Women's College Basketball Team Schedule**

**Get ESPN NBA Team Schedule**

**Get ESPN NBA Team Schedule**

## Usage

``` r
espn_mbb_team_schedule(
  team_id,
  season = most_recent_mbb_season(),
  season_type = 2,
  ...
)

espn_nba_team_schedule(
  team_id,
  season = most_recent_nba_season(),
  season_type = 2,
  ...
)
```

## Arguments

- team_id:

  ESPN team identifier (character or numeric).

- season:

  Season year (numeric). Defaults to the most recent MBB season.

- season_type:

  Integer season type: 1 = preseason, 2 = regular (default), 3 =
  postseason.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_id | character | Unique event / game identifier (ESPN). |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| week | integer | Week number within the season. |
| date | character | Date in YYYY-MM-DD format. |
| name | character | Display name. |
| short_name | character | Short display name. |
| opponent_id | character | Unique identifier for opponent. |
| opponent_abbrev | character | Abbreviation for opponent. |
| home_away | character | Game venue label ('home' or 'away'). |
| neutral_site | logical | Neutral site. |
| conference_competition | logical | Conference competition. |
| venue_id | character | Unique venue identifier. |
| venue_name | character | Venue name. |
| venue_city | character | Venue city. |
| venue_state | character | Venue state / region. |
| broadcast | character | Broadcast information string. |
| result | character | Result. |
| team_score | character | Team's score / final score. |
| opponent_score | character | Opponent score. |
| winner | logical | Winner. |

A `hoopR_data` tibble with one row per event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_id | character | Unique event / game identifier (ESPN). |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| week | integer | Week number within the season. |
| date | character | Date in YYYY-MM-DD format. |
| name | character | Display name. |
| short_name | character | Short display name. |
| opponent_id | character | Unique identifier for opponent. |
| opponent_abbrev | character | Abbreviation for opponent. |
| home_away | character | Game venue label ('home' or 'away'). |
| neutral_site | logical | Neutral site. |
| conference_competition | logical | Conference competition. |
| venue_id | character | Unique venue identifier. |
| venue_name | character | Venue name. |
| venue_city | character | Venue city. |
| venue_state | character | Venue state / region. |
| broadcast | character | Broadcast information string. |
| result | character | Result. |
| team_score | character | Team's score / final score. |
| opponent_score | character | Opponent score. |
| winner | logical | Winner. |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_team_schedule(team_id = "150", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Schedule from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:12 UTC
#> # A tibble: 34 × 21
#>    event_id  season season_type  week date          name  short_name opponent_id
#>    <chr>      <int>       <int> <int> <chr>         <chr> <chr>      <chr>      
#>  1 401706881   2025          NA     1 2024-11-05T0… Main… ME @ DUKE  NA         
#>  2 401706882   2025          NA     1 2024-11-08T2… Army… ARMY @ DU… NA         
#>  3 401706883   2025          NA     2 2024-11-13T0… Duke… DUKE VS UK NA         
#>  4 401706884   2025          NA     2 2024-11-16T1… Woff… WOF @ DUKE NA         
#>  5 401706885   2025          NA     3 2024-11-23T0… Duke… DUKE @ AR… NA         
#>  6 401706886   2025          NA     4 2024-11-27T0… Kans… KU VS DUKE NA         
#>  7 401706887   2025          NA     4 2024-11-30T0… Seat… SEA @ DUKE NA         
#>  8 401706888   2025          NA     5 2024-12-05T0… Aubu… AUB @ DUKE NA         
#>  9 401724775   2025          NA     5 2024-12-08T2… Duke… DUKE @ LOU NA         
#> 10 401706889   2025          NA     6 2024-12-11T0… Inca… UIW @ DUKE NA         
#> # ℹ 24 more rows
#> # ℹ 13 more variables: opponent_abbrev <chr>, home_away <chr>,
#> #   neutral_site <lgl>, conference_competition <lgl>, venue_id <chr>,
#> #   venue_name <chr>, venue_city <chr>, venue_state <chr>, broadcast <chr>,
#> #   result <chr>, team_score <chr>, opponent_score <chr>, winner <lgl>
# }
# \donttest{
  espn_nba_team_schedule(team_id = "13", season = 2025)
#> ── ESPN NBA Team Schedule from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:12 UTC
#> # A tibble: 84 × 21
#>    event_id  season season_type  week date          name  short_name opponent_id
#>    <chr>      <int>       <int> <int> <chr>         <chr> <chr>      <chr>      
#>  1 401704628   2025          NA    NA 2024-10-23T0… Minn… MIN @ LAL  NA         
#>  2 401704651   2025          NA    NA 2024-10-26T0… Phoe… PHX @ LAL  NA         
#>  3 401704662   2025          NA    NA 2024-10-27T0… Sacr… SAC @ LAL  NA         
#>  4 401704677   2025          NA    NA 2024-10-29T0… Los … LAL @ PHX  NA         
#>  5 401704684   2025          NA    NA 2024-10-30T2… Los … LAL @ CLE  NA         
#>  6 401704703   2025          NA    NA 2024-11-01T2… Los … LAL @ TOR  NA         
#>  7 401704722   2025          NA    NA 2024-11-05T0… Los … LAL @ DET  NA         
#>  8 401704740   2025          NA    NA 2024-11-07T0… Los … LAL @ MEM  NA         
#>  9 401704761   2025          NA    NA 2024-11-09T0… Phil… PHI @ LAL  NA         
#> 10 401704777   2025          NA    NA 2024-11-11T0… Toro… TOR @ LAL  NA         
#> # ℹ 74 more rows
#> # ℹ 13 more variables: opponent_abbrev <chr>, home_away <chr>,
#> #   neutral_site <lgl>, conference_competition <lgl>, venue_id <chr>,
#> #   venue_name <chr>, venue_city <chr>, venue_state <chr>, broadcast <chr>,
#> #   result <chr>, team_score <chr>, opponent_score <chr>, winner <lgl>
# }
```
