# **Get CEBL Player Seasons**

One player's per-season rows and career row (totals or per game).

Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/statistics/`

## Usage

``` r
cebl_player_seasons(
  player_id,
  mode = "PER_GAME",
  career_only = FALSE,
  competition = NULL
)
```

## Arguments

- player_id:

  (required) CEBL player id (global across seasons and teams), e.g.
  570965 (Javonte Smart); `player_id` in cebl_player_stats.

- mode:

  (default `"PER_GAME"`) TOTALS (sums over the selected games) or
  PER_GAME (per-game averages); the API requires one.

- career_only:

  (default `FALSE`) `TRUE` returns the career row alone; `FALSE` the
  per-season rows and the career row.

- competition:

  (default `NULL`) REGULAR (regular season) or FINALS (the playoffs).
  `NULL` = both.

## Value

A `hoopR_data` tibble: One player's per-season rows and career row
(totals or per game). An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`cebl_player_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
| competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
| player_id | integer | CEBL player id: the `player_id` of the request, on every row. Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| season | integer | Season (calendar year = sdv END year); null on the career row. |
| is_career | logical | True on the career row (null season): the sum or average over every season and team; false on a per-season row. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The player's team that season (on the career row, his latest). |
| team_name_en | character | Full English name of the player's team. |
| team_short_name_en | character | Short English name (city) of the player's team. |
| team_name_fr | character | Full French name of the player's team. |
| team_short_name_fr | character | Short French name (city) of the player's team. |
| team_logo_url | character | Logo URL (icon with the name) of the player's team. |
| played | integer | Games played (a count in both modes). |
| started | integer | Games started (a count in both modes). |
| minutes | double | Minutes played, decimal minutes (not mm:ss). TOTALS: the sum ('1281.7'); PER_GAME: the per-game average ('29.5'). A string. |
| points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goals_made | double | Field goals made (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goals_attempted | double | Field goals attempted (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| three_points_made | double | Three-pointers made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| three_points_attempted | double | Three-pointers attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| free_throws_made | double | Free throws made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| free_throws_attempted | double | Free throws attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
| offensive_rebounds | double | Offensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| defensive_rebounds | double | Defensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| rebounds | double | Total rebounds (offensive + defensive). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| assists | double | Assists. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| turn_overs | double | Turnovers. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| steals | double | Steals. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| blocks | double | Shots blocked. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| fouls | double | Personal fouls committed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| double_doubles | double | Double-doubles: games with 10 or more in two of points, rebounds, assists, steals, blocks. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| triple_doubles | double | Triple-doubles: games with 10 or more in three of those. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| target_scores | double | Target-score baskets: games in which the player made the basket that reached the Elam Ending target score and ended the game (CEBL has used the Elam Ending since 2020, so 2019 is 0). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_player_seasons(player_id = 570965, mode = "PER_GAME")

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
