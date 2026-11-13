# **Get ESPN MBB Per-Week Ranking Detail**

Returns the long-format ranked teams for one (season x season-type x
week x ranking-source). Typically 25 rows for MBB (AP Top 25).

Returns the long-format ranked teams for one (season x season-type x
week x ranking-source). NBA typically returns an empty tibble.

## Usage

``` r
espn_mbb_week_ranking(
  ranking_id,
  week,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_nba_week_ranking(
  ranking_id,
  week,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- ranking_id:

  Ranking source id (1 = AP, 2 = Coaches, etc.).

- week:

  Week number.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per ranked team.

|                   |           |                                              |
|-------------------|-----------|----------------------------------------------|
| col_name          | types     | description                                  |
| league            | character | League slug.                                 |
| season            | integer   | Season year.                                 |
| season_type       | integer   | Season-type id.                              |
| week              | integer   | Week number.                                 |
| ranking_id        | character | ESPN ranking id.                             |
| name              | character | Ranking name (e.g. "AP Top 25").             |
| short_name        | character | Short name.                                  |
| type              | character | Ranking type code.                           |
| headline          | character | Full headline.                               |
| date              | character | Date of the ranking.                         |
| current           | integer   | Current rank.                                |
| previous          | integer   | Previous-week rank.                          |
| points            | numeric   | Voting points.                               |
| first_place_votes | integer   | First-place vote count.                      |
| trend             | character | Trend indicator (e.g. "+3", "-2", "-").      |
| record_summary    | character | Team's record at time of poll (e.g. "20-2"). |
| team_id           | character | ESPN team id.                                |
| team_ref          | character | `$ref` to the team-in-season resource.       |
| last_updated      | character | Last-updated timestamp.                      |

A `hoopR_data` tibble with one row per ranked team.

|                   |           |                                              |
|-------------------|-----------|----------------------------------------------|
| col_name          | types     | description                                  |
| league            | character | League slug.                                 |
| season            | integer   | Season year.                                 |
| season_type       | integer   | Season-type id.                              |
| week              | integer   | Week number.                                 |
| ranking_id        | character | ESPN ranking id.                             |
| name              | character | Ranking name (e.g. "AP Top 25").             |
| short_name        | character | Short name.                                  |
| type              | character | Ranking type code.                           |
| headline          | character | Full headline.                               |
| date              | character | Date of the ranking.                         |
| current           | integer   | Current rank.                                |
| previous          | integer   | Previous-week rank.                          |
| points            | numeric   | Voting points.                               |
| first_place_votes | integer   | First-place vote count.                      |
| trend             | character | Trend indicator (e.g. "+3", "-2", "-").      |
| record_summary    | character | Team's record at time of poll (e.g. "20-2"). |
| team_id           | character | ESPN team id.                                |
| team_ref          | character | `$ref` to the team-in-season resource.       |
| last_updated      | character | Last-updated timestamp.                      |

## Details

**Get ESPN MBB Per-Week Ranking Detail**

**Get ESPN NBA Per-Week Ranking Detail**

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
  espn_mbb_week_ranking(ranking_id = 1, week = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Week Ranking Detail ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:22 UTC
#> # A tibble: 25 × 19
#>    league    season season_type  week ranking_id name  short_name type  headline
#>    <chr>      <int>       <int> <int> <chr>      <chr> <chr>      <chr> <chr>   
#>  1 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  2 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  3 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  4 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  5 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  6 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  7 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  8 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#>  9 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#> 10 mens-col…   2025           2     5 1          AP T… AP Poll    ap    2025 NC…
#> # ℹ 15 more rows
#> # ℹ 10 more variables: date <chr>, current <int>, previous <int>, points <dbl>,
#> #   first_place_votes <int>, trend <chr>, record_summary <chr>, team_id <chr>,
#> #   team_ref <chr>, last_updated <chr>
# }
# \donttest{
  espn_nba_week_ranking(ranking_id = 1, week = 5, season = 2025)
#> ✖ 2026-11-13 17:35:22.88557: Failed to retrieve ESPN nba week-5 ranking 1 for season=2025
#> ✖ Args: league = "nba", season = 2025, season_type = 2L, week = 5, ranking_id = 1
#> ✖ Error: The API returned an error
#> ── ESPN NBA Week Ranking Detail ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:22 UTC
#> # A tibble: 0 × 0
# }
```
