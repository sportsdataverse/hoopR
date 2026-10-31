# **Get CEBL Team Statistics**

Team statistic table (totals or per game) with a league row; filter by
season, competition, segment, opponent team or opponent conference.

Endpoint: `GET https://api.data.cebl.ca/teams/statistics/aggregated/`

## Usage

``` r
cebl_team_stats(
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  segment = NULL,
  vs_team_id = NULL,
  vs_conference = NULL
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

- vs_team_id:

  (default `NULL`) CEBL team id of the opponent: only games against that
  team count.

- vs_conference:

  (default `NULL`) EAST or WEST: only games against that conference's
  teams count.

## Value

A `hoopR_data` tibble: Team statistic table (totals or per game) with a
league row; filter by season, competition, segment, opponent team or
opponent conference. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`cebl_team_stats`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
| mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
| competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
| segment | character | Game-subset filter of the request (HOME, AWAY, L5G, MAY ...); null for all games. The body does not echo it. |
| vs_conference | character | Opponent-conference filter of the request (EAST or WEST); null when not asked. The body does not echo it. |
| vs_team_id | integer | Opponent team filter of the request (CEBL team id); null when not asked. The body does not echo it. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). Null on the league row. |
| is_league_row | logical | True on the one league row of a team table (null team_id and names): the league's own figures, where played counts team-games and, in TOTALS, points equals points_against. |
| name_en | character | Team full name in English ('Niagara River Lions'). Null on the league row. |
| short_name_en | character | Team short name in English, usually the city ('Niagara'). Null on the league row. |
| name_fr | character | Team full name in French ('River Lions de Niagara'). Null on the league row. |
| short_name_fr | character | Team short name in French, usually the city. Null on the league row. |
| played | integer | Games played (a count in both modes). On the league row: team-games (twice the games). |
| wins | integer | Wins (a count in both modes). |
| win_percentage | double | Wins / games played, 0-1 with 3 decimals ('0.625'). A string. |
| losses | integer | Losses (a count in both modes). |
| points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| points_against | double | Points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| point_difference | double | Points scored minus points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
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
| fouls_drawn | double | Fouls drawn (committed by opponents). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| efficiency | double | Efficiency rating (EFF); CEBL does not publish its formula (unverified: the usual Genius / FIBA EFF is PTS + REB + AST + STL + BLK - missed FG - missed FT - TO). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
| logo_url | character | Team logo URL (icon with the team name) on Google Cloud Storage. Null on the league row. |
| icon_url | character | Team icon URL (without the team name) on Google Cloud Storage. Null on the league row. |
| stats_url_en | character | The team's stats page on cebl.ca (`https://cebl.ca/stats/{slug}`). Null on the league row. |
| stats_url_fr | character | The team's stats page on the French cebl.ca (`https://cebl.ca/fr-ca/stats/{slug}`). Null on the league row. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_team_stats(mode = "TOTALS", season = 2025, competition = "REGULAR")

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
