# **Get CEBL Player Statistics**

Player statistic table (totals or per game) for a season or all-time;
filter by competition, segment or team.

Endpoint: `GET https://api.data.cebl.ca/players/statistics/aggregated/`

## Usage

``` r
cebl_player_stats(
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  segment = NULL,
  team_id = NULL
)
```

## Arguments

- mode:

  (default `"PER_GAME"`) TOTALS (sums over the selected games) or
  PER_GAME (per-game averages); the API requires one.

- season:

  (default `NULL`) Season: the calendar year (May to August) = the sdv
  END year. `NULL` = every season combined (the Stats Hub's All-Time).
  An unknown year answers `hoopR_no_data`.

- competition:

  (default `NULL`) REGULAR (regular season) or FINALS (the playoffs).
  `NULL` = both.

- segment:

  (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last
  5 games), L10G (last 10 games), MAY, JUNE, JULY or AUGUST. `NULL` =
  all games. Values from the CEBL Stats Hub bundle.

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cebl_player_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_player_stats(mode = "PER_GAME", season = 2025))
#> ── CEBL Player Statistics from the CEBL Stats API ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:59:15 UTC
#> # A tibble: 175 × 37
#>    season mode     competition segment player_id full_name   nationality team_id
#>     <int> <chr>    <chr>       <chr>       <int> <chr>       <chr>         <int>
#>  1   2025 PER_GAME NA          NA              7 Cat Barber  UNITED STA…      22
#>  2   2025 PER_GAME NA          NA              8 Jalen Harr… UNITED STA…      24
#>  3   2025 PER_GAME NA          NA             11 Danilo Dju… CANADA           22
#>  4   2025 PER_GAME NA          NA             14 Elijah Luf… CANADA           14
#>  5   2025 PER_GAME NA          NA             15 David Walk… CANADA           20
#>  6   2025 PER_GAME NA          NA             24 Alain Louis CANADA           21
#>  7   2025 PER_GAME NA          NA             25 Ahmed Hill  UNITED STA…      14
#>  8   2025 PER_GAME NA          NA             27 Christian … CANADA           20
#>  9   2025 PER_GAME NA          NA             29 Elijah Ife… CANADA           15
#> 10   2025 PER_GAME NA          NA             44 Deng Adel   SOUTH SUDAN      20
#> # ℹ 165 more rows
#> # ℹ 29 more variables: team_name_en <chr>, team_short_name_en <chr>,
#> #   team_name_fr <chr>, team_short_name_fr <chr>, team_logo_url <chr>,
#> #   played <int>, started <int>, minutes <dbl>, points <dbl>,
#> #   field_goals_made <dbl>, field_goals_attempted <dbl>,
#> #   field_goal_percentage <dbl>, three_points_made <dbl>,
#> #   three_points_attempted <dbl>, three_point_percentage <dbl>, …
# }
```
