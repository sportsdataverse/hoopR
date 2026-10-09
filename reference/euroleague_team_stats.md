# **EuroLeague Team Stats (season)**

**Get season team stats, traditional (box-score totals or per-game
averages) or advanced (eFG%, TS%, four-factor style rates), one row per
team.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/teams/{mode}`

## Usage

``` r
euroleague_team_stats(
  competition_code,
  mode = c("traditional", "advanced"),
  season_mode = "Single",
  season_code = NULL,
  statistic_mode = "PerGame",
  limit = NULL,
  offset = NULL
)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- mode:

  (*character* default `"traditional"`): `"traditional"` or
  `"advanced"`, matched exactly (no prefixes, as in sdv-py); the columns
  depend on it (see Returns).

- season_mode:

  (*character* default `"Single"`): Season mode; `Single` as captured
  (other values unverified).

- season_code:

  (*character* required by the API): Competition code + start year, e.g.
  `E2025` for 2025-26 (the `SeasonCode` query parameter).

- statistic_mode:

  (*character* default `"PerGame"`): `PerGame` as captured (other values
  unverified).

- limit:

  (*integer* optional): Page size.

- offset:

  (*integer* optional): Row offset into the full list.

## Value

A `hoopR_data` tibble with one row per team. The columns depend on
`mode`:

**`mode = "traditional"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_ranking | integer | Rank of the team on the requested statistic mode. |
| games_played | numeric | Games played. |
| minutes_played | numeric | Minutes played. |
| points_scored | numeric | Points scored. |
| two_pointers_made | numeric | Two-point field goals made. |
| two_pointers_attempted | numeric | Two-point field goals attempted. |
| two_pointers_percentage | character | Two-point field-goal percentage, formatted. |
| three_pointers_made | numeric | Three-point field goals made. |
| three_pointers_attempted | numeric | Three-point field goals attempted. |
| three_pointers_percentage | character | Three-point field-goal percentage, formatted. |
| free_throws_made | numeric | Free throws made. |
| free_throws_attempted | numeric | Free throws attempted. |
| free_throws_percentage | character | Free-throw percentage, formatted. |
| offensive_rebounds | numeric | Offensive rebounds. |
| defensive_rebounds | numeric | Defensive rebounds. |
| total_rebounds | numeric | Total rebounds. |
| assists | numeric | Assists. |
| steals | numeric | Steals. |
| turnovers | numeric | Turnovers. |
| blocks | numeric | Blocks made. |
| blocks_against | numeric | Shots blocked by the opponent. |
| fouls_commited | numeric | Personal fouls committed. |
| fouls_drawn | numeric | Fouls drawn. |
| pir | numeric | Performance index rating (PIR). |
| team_code | character | EuroLeague club code (Utf8 join key). |
| team_tv_codes | character | Three-letter broadcast abbreviation(s) of the club. |
| team_name | character | Club display name. |
| team_image_url | character | URL of the club crest image. |

**`mode = "advanced"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_ranking | integer | Rank of the team on the requested statistic mode. |
| games_played | numeric | Games played. |
| effective_field_goal_percentage | character | Effective field-goal percentage, formatted. |
| true_shooting_percentage | character | True shooting percentage, formatted. |
| offensive_rebounds_percentage | character | Offensive rebound percentage, formatted. |
| defensive_rebounds_percentage | character | Defensive rebound percentage, formatted. |
| rebounds_percentage | character | Total rebound percentage, formatted. |
| assists_to_turnovers_ratio | numeric | Assist-to-turnover ratio. |
| assists_ratio | character | Assist ratio (assists per 100 possessions used), formatted. |
| turnovers_ratio | character | Turnover ratio (turnovers per 100 possessions used), formatted. |
| two_point_rate | character | Share of field-goal attempts that are two-pointers, formatted. |
| three_point_rate | character | Share of field-goal attempts that are three-pointers, formatted. |
| free_throws_rate | character | Free-throw rate (free-throw attempts per field-goal attempt), formatted. |
| points_from_two_pointers_percentage | character | Share of points from two-pointers, formatted. |
| points_from_three_pointers_percentage | character | Share of points from three-pointers, formatted. |
| points_from_free_throws_percentage | character | Share of points from free throws, formatted. |
| team_code | character | EuroLeague club code (Utf8 join key). |
| team_tv_codes | character | Three-letter broadcast abbreviation(s) of the club. |
| team_name | character | Club display name. |
| team_image_url | character | URL of the club crest image. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sdv-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

Other Euroleague:
[`euroleague_clubs()`](https://hoopR.sportsdataverse.org/reference/euroleague_clubs.md),
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md),
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_team_stats(competition_code = "E", season_code = "E2025")
    euroleague_team_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
  })
#> ── EuroLeague advanced team stats from api-live.euroleague.net ─────────────────
#> ℹ Data updated: 2026-10-09 04:32:41 UTC
#> # A tibble: 20 × 20
#>    team_ranking games_played effective_field_goal_perce…¹ true_shooting_percen…²
#>           <int>        <dbl> <chr>                        <chr>                 
#>  1            1           38 50.7%                        54.6%                 
#>  2            2           38 53.9%                        57.9%                 
#>  3            3           38 54.1%                        57.5%                 
#>  4            4           38 53%                          56.9%                 
#>  5            5           43 54.2%                        58.4%                 
#>  6            6           38 54.4%                        58.5%                 
#>  7            7           38 53.8%                        57.6%                 
#>  8            8           40 55.4%                        58.8%                 
#>  9            9           38 55.1%                        59.9%                 
#> 10           10           38 56.5%                        60.7%                 
#> 11           11           39 54.5%                        58.3%                 
#> 12           12           42 57.6%                        61.2%                 
#> 13           13           44 55%                          59%                   
#> 14           14           42 56.1%                        59.6%                 
#> 15           15           38 54.1%                        59.5%                 
#> 16           16           38 53.4%                        58.2%                 
#> 17           17           43 54.6%                        59.4%                 
#> 18           18           44 56%                          58.8%                 
#> 19           19           44 56.2%                        60.4%                 
#> 20           20           43 57.1%                        61.5%                 
#> # ℹ abbreviated names: ¹​effective_field_goal_percentage,
#> #   ²​true_shooting_percentage
#> # ℹ 16 more variables: offensive_rebounds_percentage <chr>,
#> #   defensive_rebounds_percentage <chr>, rebounds_percentage <chr>,
#> #   assists_to_turnovers_ratio <dbl>, assists_ratio <chr>,
#> #   turnovers_ratio <chr>, two_point_rate <chr>, three_point_rate <chr>,
#> #   free_throws_rate <chr>, points_from_two_pointers_percentage <chr>, …
# }
```
