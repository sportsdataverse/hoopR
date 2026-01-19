# **Get men's college basketball AP and Coaches Poll rankings from ESPN**

**Get men's college basketball AP and Coaches Poll rankings from ESPN**

## Usage

``` r
espn_mbb_rankings()
```

## Value

Returns a tibble

|                          |           |
|--------------------------|-----------|
| col_name                 | types     |
| id                       | integer   |
| name                     | character |
| short_name               | character |
| type                     | character |
| headline                 | character |
| short_headline           | character |
| current                  | integer   |
| previous                 | integer   |
| points                   | numeric   |
| first_place_votes        | integer   |
| trend                    | character |
| date                     | character |
| last_updated             | character |
| record_summary           | character |
| team_id                  | integer   |
| team_uid                 | character |
| team_location            | character |
| team_name                | character |
| team_nickname            | character |
| team_abbreviation        | character |
| team_color               | character |
| team_logo                | character |
| occurrence_number        | integer   |
| occurrence_type          | character |
| occurrence_last          | logical   |
| occurrence_value         | character |
| occurrence_display_value | character |
| season_year              | integer   |
| season_start_date        | character |
| season_end_date          | character |
| season_display_name      | character |
| season_type_type         | integer   |
| season_type_name         | character |
| season_type_abbreviation | character |
| season_futures_ref       | character |
| first_occurrence_type    | character |
| first_occurrence_value   | character |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# Get current AP and Coaches Poll rankings
# \donttest{
  try(espn_mbb_rankings())
#> ── ESPN MBB Rankings Information from ESPN.com ────────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:28:14 UTC
#> # A tibble: 88 × 38
#>       id name   short_name type  headline short_headline current previous points
#>    <int> <chr>  <chr>      <chr> <chr>    <chr>            <int>    <int>  <dbl>
#>  1     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       1        1   1524
#>  2     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       2        3   1448
#>  3     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       3        4   1358
#>  4     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       4        2   1300
#>  5     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       5        5   1253
#>  6     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       6        6   1237
#>  7     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       7        7   1130
#>  8     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       8       10   1056
#>  9     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11       9        8   1050
#> 10     1 AP To… AP Poll    ap    2026 NC… 2026 : Week 11      10       11   1035
#> # ℹ 78 more rows
#> # ℹ 29 more variables: first_place_votes <int>, trend <chr>, date <chr>,
#> #   last_updated <chr>, record_summary <chr>, team_id <int>, team_uid <chr>,
#> #   team_location <chr>, team_name <chr>, team_nickname <chr>,
#> #   team_abbreviation <chr>, team_color <chr>, team_logos <list>,
#> #   team_logo <chr>, occurrence_number <int>, occurrence_type <chr>,
#> #   occurrence_last <lgl>, occurrence_value <chr>, …
# }
```
