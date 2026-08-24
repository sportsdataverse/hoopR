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
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`mbb_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_schedule_crosswalk.md),
[`mbb_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/mbb_team_crosswalk.md)

## Examples

``` r
# \donttest{
  try(mbb_player_crosswalk(season = 2025))
#> ✖ 2026-08-24 20:42:52.706144: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:53.69799: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:54.297928: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:54.477068: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:54.776259: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:55.21279: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:55.449944: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:55.705247: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:56.200661: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:56.370784: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:56.781249: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:56.957881: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:57.402589: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:57.952679: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:58.310988: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:58.686843: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:59.077591: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:59.25489: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:59.472039: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:42:59.658436: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:00.052589: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:00.258523: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:00.447183: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:00.956453: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:01.225924: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:01.834314: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:02.0054: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ✖ 2026-08-24 20:43:02.383702: no Fox CBK teams data available!
#> ✖ Error: The API returned an error
#> ── MBB player crosswalk (ESPN / Fox) ──────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-24 20:43:48 UTC
#> # A tibble: 5,509 × 17
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
#> # ℹ 5,499 more rows
#> # ℹ 12 more variables: espn_full_name <chr>, espn_jersey <chr>,
#> #   espn_position <chr>, fox_athlete_id <chr>, fox_player <chr>,
#> #   fox_jersey <chr>, fox_position_group <chr>, yahoo_player_id <chr>,
#> #   yahoo_player_name <chr>, match_method <chr>, match_confidence <dbl>,
#> #   match_keys <chr>
# }
```
