# **Get ESPN MBB Team Odds-Records (Long Format)**

Returns the long-format odds-records breakdown for a team in one season.
Each row is one (category x stat) - typical categories include Money
Line Overall, Money Line Home, Money Line Road, Against The Spread
Overall, Over/Under, etc. ESPN's coverage of this endpoint is sparse;
many (team x season-type) combinations return 404, in which case the
wrapper returns an empty tibble.

Returns the long-format odds-records breakdown for a team in one season.
Each row is one (category x stat) - typical categories include Money
Line Overall, Money Line Home, Money Line Road, Against The Spread
Overall, Over/Under, etc. ESPN's coverage of this endpoint is sparse;
many (team x season-type) combinations return 404, in which case the
wrapper returns an empty tibble.

## Usage

``` r
espn_mbb_team_odds_records(
  team_id,
  season = most_recent_mbb_season(),
  season_type = 0L,
  ...
)

espn_nba_team_odds_records(
  team_id,
  season = most_recent_nba_season(),
  season_type = 0L,
  ...
)
```

## Arguments

- team_id:

  ESPN team identifier.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id. ESPN populates odds-records mostly under
  `season_type = 0` (all-types aggregate), so that is the default.

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per category and statistic.

|                  |           |                                               |
|------------------|-----------|-----------------------------------------------|
| col_name         | types     | description                                   |
| league           | character | League slug.                                  |
| team_id          | character | ESPN team identifier.                         |
| season           | integer   | Season year.                                  |
| season_type      | integer   | Season-type id.                               |
| category_type    | character | Category type code (e.g. "moneyLineOverall"). |
| category_abbrev  | character | Category abbreviation (e.g. "ML").            |
| category_short   | character | Short display.                                |
| category_display | character | Full category name.                           |
| stat_type        | character | Stat type code (e.g. "win", "loss").          |
| stat_abbrev      | character | Stat abbreviation (e.g. "W", "L").            |
| stat_display     | character | Stat display name.                            |
| value            | numeric   | Numeric stat value.                           |
| display_value    | character | Display-formatted value.                      |

A `hoopR_data` tibble with one row per category and statistic.

|                  |           |                                               |
|------------------|-----------|-----------------------------------------------|
| col_name         | types     | description                                   |
| league           | character | League slug.                                  |
| team_id          | character | ESPN team identifier.                         |
| season           | integer   | Season year.                                  |
| season_type      | integer   | Season-type id.                               |
| category_type    | character | Category type code (e.g. "moneyLineOverall"). |
| category_abbrev  | character | Category abbreviation (e.g. "ML").            |
| category_short   | character | Short display.                                |
| category_display | character | Full category name.                           |
| stat_type        | character | Stat type code (e.g. "win", "loss").          |
| stat_abbrev      | character | Stat abbreviation (e.g. "W", "L").            |
| stat_display     | character | Stat display name.                            |
| value            | numeric   | Numeric stat value.                           |
| display_value    | character | Display-formatted value.                      |

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
  espn_mbb_team_odds_records(team_id = 150, season = 2026)
#> ✖ 2026-11-13 21:12:43.042506: Failed to retrieve ESPN mens-college-basketball team odds-records for team_id=150, season=2026
#> ✖ Args: league = "mens-college-basketball", team_id = 150, season = 2026, season_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Odds-Records ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:43 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_team_odds_records(team_id = 13, season = 2026)
#> ✖ 2026-11-13 21:12:43.109468: Failed to retrieve ESPN nba team odds-records for team_id=13, season=2026
#> ✖ Args: league = "nba", team_id = 13, season = 2026, season_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN NBA Team Odds-Records ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:12:43 UTC
#> # A tibble: 0 × 0
# }
```
