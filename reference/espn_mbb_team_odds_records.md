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

A long tibble with one row per (category x stat).

Columns as documented in the shared
[espn_mbb_team_odds_records_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records_schema.md)
table.

A long tibble with one row per (category x stat).

Columns as documented in the shared
[espn_mbb_team_odds_records_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_odds_records_schema.md)
table.

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
#> ✖ 2026-11-09 17:04:52.560909: Failed to retrieve ESPN mens-college-basketball team odds-records for team_id=150, season=2026
#> ✖ Args: league = "mens-college-basketball", team_id = 150, season = 2026, season_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Odds-Records ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:52 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_team_odds_records(team_id = 13, season = 2026)
#> ✖ 2026-11-09 17:04:52.622392: Failed to retrieve ESPN nba team odds-records for team_id=13, season=2026
#> ✖ Args: league = "nba", team_id = 13, season = 2026, season_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN NBA Team Odds-Records ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:52 UTC
#> # A tibble: 0 × 0
# }
```
