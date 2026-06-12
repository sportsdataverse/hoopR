# **Get the MBB cross-source player crosswalk**

Build a wide, one-row-per-player-per-team crosswalk linking ESPN and Fox
Sports (Bifrost) MBB player identities for a season. ESPN is the anchor
source; Fox is matched by normalized name (exact first, then
Jaro-Winkler fuzzy with jersey tiebreaker) within each team block. Yahoo
columns are NA placeholders. KenPom and Torvik have no per-player data
for MBB, so neither source is joined.

## Usage

``` r
mbb_player_crosswalk(season = most_recent_mbb_season(), min_confidence = 0.92)
```

## Arguments

- season:

  Season year (4-digit, e.g. `2025`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- min_confidence:

  Jaro-Winkler similarity floor for fuzzy matches (default 0.92).

## Value

A `hoopR_data` tibble, one row per player per team (ESPN-anchored):

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season year. |
| espn_team_id | integer | ESPN team id (canonical key). |
| team_abbreviation | character | ESPN team abbreviation. |
| player_name | character | Normalized player name (matching key). |
| espn_athlete_id | character | ESPN athlete id. |
| espn_full_name | character | ESPN full name. |
| espn_jersey | character | ESPN jersey number. |
| espn_position | character | ESPN position abbreviation. |
| fox_athlete_id | character | Fox athlete id (NA if unmatched). |
| fox_player | character | Fox player name (NA if unmatched). |
| fox_jersey | character | Fox jersey number (NA if unmatched). |
| fox_position_group | character | Fox position group label (NA if unmatched). |
| yahoo_player_id | character | Yahoo player id (NA placeholder). |
| yahoo_player_name | character | Yahoo player name (NA placeholder). |
| match_method | character | "exact_name"/"fuzzy_jw"/"unmatched". |
| match_confidence | numeric | Jaro-Winkler score or 1 for exact (NA if none). |
| match_keys | character | NA (reserved for future use). |

## See also

Other MBB Crosswalk Functions:
[`load_mbb_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_player_crosswalk.md),
[`load_mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_schedule_crosswalk.md),
[`load_mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_mbb_team_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(mbb_player_crosswalk(season = 2025))
#> ✖ 2026-06-12 23:33:43.382596: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:44.085351: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:44.588765: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:44.736813: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:44.932468: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:45.173721: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:45.616638: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:45.775934: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:45.964562: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:46.372803: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:46.538535: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:46.70155: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:47.124955: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:47.459434: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:47.811845: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:48.031145: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:48.326936: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:48.720464: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:49.094758: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:49.29685: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:49.900411: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:50.091522: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:50.271669: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:50.605111: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:50.762564: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:50.949383: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:51.102577: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:51.490465: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:33:51.66825: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-06-12 23:34:02.597838: No roster data available for team_id=2272, season=2025
#> ✖ Args: league = "mens-college-basketball", team_id = 2272L, season = 2025
#> ✖ Error: The API returned an error
#> ── MBB player crosswalk (ESPN / Fox) ──────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 23:35:19 UTC
#> # A tibble: 5,656 × 17
#>    season espn_team_id team_abbreviation player_name      espn_athlete_id
#>     <int>        <int> <chr>             <chr>            <chr>          
#>  1   2025         2000 ACU               christian alston 5241312        
#>  2   2025         2000 ACU               isaiah carrillo  5314819        
#>  3   2025         2000 ACU               isaac dye        5314820        
#>  4   2025         2000 ACU               mashy hill       5177705        
#>  5   2025         2000 ACU               cade hornecker   5107885        
#>  6   2025         2000 ACU               bradyn hubbard   5241314        
#>  7   2025         2000 ACU               tylan lewis      5314817        
#>  8   2025         2000 ACU               cbo newton       5177575        
#>  9   2025         2000 ACU               yaniel rivera    5177702        
#> 10   2025         2000 ACU               joseph scott     5314818        
#> # ℹ 5,646 more rows
#> # ℹ 12 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, fox_athlete_id <chr>, fox_player <chr>,
#> #   fox_jersey <chr>, fox_position_group <chr>, yahoo_player_id <chr>,
#> #   yahoo_player_name <chr>, match_method <chr>, match_confidence <dbl>,
#> #   match_keys <chr>
# }
```
