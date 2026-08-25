# **CBD Draft Teams**

**Get NBA draft teams from the CollegeBasketballData API.**

**Get NBA draft positions from the CollegeBasketballData API.**

**Get NBA draft picks from the CollegeBasketballData API.**

## Usage

``` r
cbbd_draft_teams()

cbbd_draft_positions()

cbbd_draft_picks(
  year = NULL,
  draft_team = NULL,
  source_team = NULL,
  position = NULL
)
```

## Arguments

- year:

  (*integer* optional): Draft year (e.g. `2024`).

- draft_team:

  (*character* optional): NBA team filter.

- source_team:

  (*character* optional): College team filter.

- position:

  (*character* optional): Position filter.

## Value

A `hoopR_data` tibble with one row per NBA team:

|              |           |                         |
|--------------|-----------|-------------------------|
| col_name     | types     | description             |
| id           | integer   | NBA team id.            |
| source_id    | character | Source (ESPN) team id.  |
| location     | character | Team location (city).   |
| name         | character | Team name.              |
| display_name | character | Full team display name. |
| abbreviation | character | Team abbreviation.      |

A `hoopR_data` tibble with one row per draft position:

|              |           |                        |
|--------------|-----------|------------------------|
| col_name     | types     | description            |
| name         | character | Position name.         |
| abbreviation | character | Position abbreviation. |

A `hoopR_data` tibble with one row per draft pick:

|                                |           |                                  |
|--------------------------------|-----------|----------------------------------|
| col_name                       | types     | description                      |
| athlete_id                     | integer   | Athlete id.                      |
| source_team_id                 | integer   | College team id.                 |
| source_team_location           | character | College team location.           |
| source_team_name               | character | College team name.               |
| source_team_league_affiliation | character | College team league affiliation. |
| source_team_college_id         | numeric   | College id.                      |
| draft_team_id                  | numeric   | NBA team id.                     |
| draft_team                     | character | NBA team name.                   |
| year                           | integer   | Draft year.                      |
| overall                        | integer   | Overall pick number.             |
| round                          | integer   | Draft round.                     |
| pick                           | integer   | Pick number within the round.    |
| name                           | character | Player name.                     |
| overall_rank                   | integer   | Pre-draft overall rank.          |
| position_rank                  | integer   | Pre-draft position rank.         |
| height                         | numeric   | Player height.                   |
| weight                         | integer   | Player weight (lbs).             |

## Examples

``` r
# \donttest{
  try(cbbd_draft_teams())
#> ✖ 2026-08-25 02:46:49.002933: Invalid arguments or no draft teams available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_draft_positions())
#> ✖ 2026-08-25 02:46:49.010749: Invalid arguments or no draft positions available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_draft_picks(year = 2024))
#> ✖ 2026-08-25 02:46:49.018215: Invalid arguments or no draft picks available!
#> ✖ Args: year = 2024, draft_team = NULL, source_team = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
