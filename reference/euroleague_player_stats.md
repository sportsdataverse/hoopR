# **EuroLeague Player Stats (season)**

**Get season player stats, traditional (box-score totals or per-game
averages) or advanced (eFG%, TS%, rebound / assist / turnover rates),
one row per player.**

Endpoint:
`GET https://api-live.euroleague.net/v3/competitions/{competition_code}/statistics/players/{mode}`

## Usage

``` r
euroleague_player_stats(
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

A `hoopR_data` tibble with one row per player. The columns depend on
`mode`:

**`mode = "traditional"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_ranking | integer | Rank of the player on the requested statistic mode. |
| games_played | numeric | Games played. |
| games_started | numeric | Games started. |
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
| player_code | character | Player: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| player_name | character | Player: display name. |
| player_age | integer | Age of the player in years. |
| player_image_url | character | Player: URL of the image. |
| player_team_code | character | Player: euroLeague club code (Utf8 join key). |
| player_team_tv_codes | character | Player: three-letter broadcast abbreviation(s) of the club. |
| player_team_name | character | Player: club display name. |
| player_team_image_url | character | Player: URL of the club crest image. |

**`mode = "advanced"`**

|  |  |  |
|----|----|----|
| col_name | types | description |
| player_ranking | integer | Rank of the player on the requested statistic mode. |
| games_played | numeric | Games played. |
| minutes_played | numeric | Minutes played. |
| effective_field_goal_percentage | character | Effective field-goal percentage, formatted. |
| true_shooting_percentage | character | True shooting percentage, formatted. |
| offensive_rebounds_percentage | character | Offensive rebound percentage, formatted. |
| defensive_rebounds_percentage | character | Defensive rebound percentage, formatted. |
| rebounds_percentage | character | Total rebound percentage, formatted. |
| assists_to_turnovers_ratio | numeric | Assist-to-turnover ratio. |
| assists_ratio | character | Assist ratio (assists per 100 possessions used), formatted. |
| turnovers_ratio | character | Turnover ratio (turnovers per 100 possessions used), formatted. |
| two_point_attempts_ratio | character | Share of field-goal attempts that are two-pointers, formatted. |
| three_point_attempts_ratio | character | Share of field-goal attempts that are three-pointers, formatted. |
| free_throws_rate | character | Free-throw rate (free-throw attempts per field-goal attempt), formatted. |
| possesions | numeric | Possessions (sic: the API spells it this way). |
| player_code | character | Player: euroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| player_name | character | Player: display name. |
| player_age | integer | Age of the player in years. |
| player_image_url | character | Player: URL of the image. |
| player_team_code | character | Player: euroLeague club code (Utf8 join key). |
| player_team_tv_codes | character | Player: three-letter broadcast abbreviation(s) of the club. |
| player_team_name | character | Player: club display name. |
| player_team_image_url | character | Player: URL of the club crest image. |

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
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_player_stats(competition_code = "E", season_code = "E2025", limit = 25)
    euroleague_player_stats(competition_code = "E", season_code = "E2025", mode = "advanced")
  })
#> ── EuroLeague advanced player stats from api-live.euroleague.net ───────────────
#> ℹ Data updated: 2026-10-09 05:33:15 UTC
#> # A tibble: 100 × 23
#>    player_ranking games_played minutes_played effective_field_goal_percentage
#>             <int>        <dbl>          <dbl> <chr>                          
#>  1              1           27           6.23 47.1%                          
#>  2              2           26           5.11 50%                            
#>  3              3           26          10.1  44.5%                          
#>  4              4           31           8.59 43.7%                          
#>  5              5           25          10.8  30.2%                          
#>  6              6           40          10.7  38.8%                          
#>  7              7           36          14.3  49%                            
#>  8              8           31          16.4  51.7%                          
#>  9              9           29          10.6  60.3%                          
#> 10             10           24          16.4  47.9%                          
#> # ℹ 90 more rows
#> # ℹ 19 more variables: true_shooting_percentage <chr>,
#> #   offensive_rebounds_percentage <chr>, defensive_rebounds_percentage <chr>,
#> #   rebounds_percentage <chr>, assists_to_turnovers_ratio <dbl>,
#> #   assists_ratio <chr>, turnovers_ratio <chr>, two_point_attempts_ratio <chr>,
#> #   three_point_attempts_ratio <chr>, free_throws_rate <chr>, possesions <dbl>,
#> #   player_code <chr>, player_name <chr>, player_age <int>, …
# }
```
