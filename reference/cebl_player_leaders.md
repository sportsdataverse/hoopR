# **Get CEBL Player Leaders**

Top five players per requested statistic (long frame, one row per
statistic and leader).

Endpoint: `GET https://api.data.cebl.ca/players/statistics/leaders/`

## Usage

``` r
cebl_player_leaders(
  statistics = "POINTS,REBOUNDS,ASSISTS,TARGET_SCORES",
  mode = "PER_GAME",
  season = NULL,
  competition = NULL,
  team_id = NULL
)
```

## Arguments

- statistics:

  (default `"POINTS,REBOUNDS,ASSISTS,TARGET_SCORES"`) Comma-separated
  statistic names; the frame has one block per name. Names the Stats Hub
  sends: POINTS, REBOUNDS, ASSISTS, BLOCKS, STEALS, TARGET_SCORES,
  FIELD_GOAL_PERCENTAGE, THREE_POINTS_MADE, THREE_POINT_PERCENTAGE,
  FREE_THROW_PERCENTAGE, FOULS, TURNOVERS, MINUTES.

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

- team_id:

  (default `NULL`) CEBL team id (`team_id` in cebl_teams): limits the
  rows to that team; the rows echo it.

## Value

A `hoopR_data` tibble: Top five players per requested statistic (long
frame, one row per statistic and leader). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `cebl_player_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| statistic | character | Statistic this leader row ranks, the body's key for the list: POINTS, REBOUNDS, ASSISTS, TARGET_SCORES and the other names the request asked for. |
| ranking | integer | Rank in this statistic, 1 = best; ties share a rank and skip the next (1, 1, 1, 4). The list is the top 5 rows, no more. |
| season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
| mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
| competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
| player_id | integer | CEBL player id (its own key space). Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| full_name | character | Player's full name. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
| team_name_en | character | Full English name of the player's team. |
| team_short_name_en | character | Short English name (city) of the player's team. |
| team_name_fr | character | Full French name of the player's team. |
| team_short_name_fr | character | Short French name (city) of the player's team. |
| team_abbreviated_name | character | Three-letter code of the player's team ('OTT', 'VAN'). |
| team_logo_url | character | Logo URL (icon with the name) of the player's team. |
| value | double | The player's figure for the statistic this list is keyed by, in the requested mode (TOTALS sum or PER_GAME average; percentages 0-100). A decimal string ('25.9'). |
| photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_player_leaders(mode = "PER_GAME", season = 2025)

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
