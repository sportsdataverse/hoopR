# **CBD Betting Lines**

**Get game betting lines from the CollegeBasketballData API.**

## Usage

``` r
cbbd_lines(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

- start_date_range:

  (*character* optional): ISO 8601 start of date range.

- end_date_range:

  (*character* optional): ISO 8601 end of date range.

## Value

A `hoopR_data` tibble with one row per game. The `lines` column is a
nested list of per-provider lines:

|                 |           |                                            |
|-----------------|-----------|--------------------------------------------|
| col_name        | types     | description                                |
| game_id         | integer   | CollegeBasketballData game id.             |
| season          | integer   | Season (4-digit ending-year).              |
| season_type     | character | Season type.                               |
| start_date      | character | Game start date (ISO 8601).                |
| home_team_id    | integer   | Home team id.                              |
| home_team       | character | Home team name.                            |
| home_conference | character | Home team conference.                      |
| home_score      | numeric   | Home team final score.                     |
| away_team_id    | integer   | Away team id.                              |
| away_team       | character | Away team name.                            |
| away_conference | character | Away team conference.                      |
| away_score      | numeric   | Away team final score.                     |
| lines           | list      | Nested list of per-provider betting lines. |

## See also

Other CBD Lines Functions:
[`cbbd_lines_providers()`](https://hoopR.sportsdataverse.org/reference/cbbd_lines_providers.md)

## Examples

``` r
# \donttest{
  try(cbbd_lines(season = 2024, team = "Duke"))
#> ✖ 2026-06-13 02:22:16.247452: Invalid arguments or no betting lines available!
#> ✖ Args: season = 2024, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
