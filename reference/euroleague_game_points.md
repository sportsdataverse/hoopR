# **EuroLeague Game Points (shot chart)**

**Get the shot chart of one game from the live API: one row per made /
missed field goal and per made free throw, with `coord_x` / `coord_y` in
centimeters from the hoop.**

Endpoint:
`GET https://live.euroleague.net/api/Points?gamecode={game_code}&seasoncode={season_code}`

`Points` is the shot-chart source: one row per field-goal attempt
(`id_action` `2FGM` / `2FGA` / `3FGM` / `3FGA`) and per made free throw
(`FTM`), with `coord_x` / `coord_y`, `zone`, the `fastbreak` /
`second_chance` / `points_off_turnover` flags, the running score
(`points_a` / `points_b`), `minute`, the game clock (`console`) and a
`utc` timestamp. Team A is the home side as measured on one game.

## Usage

``` r
euroleague_game_points(game_code, season_code)
```

## Arguments

- game_code:

  (*integer* required): Game number within the season (1-based; the
  `game_code` column of
  [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md)).

- season_code:

  (*character* required): Competition code + start year: `E2025`
  (EuroLeague 2025-26), `U2025` (EuroCup).

## Value

A `hoopR_data` tibble with one row per shot:

|  |  |  |
|----|----|----|
| col_name | types | description |
| num_anot | integer | Sequence number of the scoring annotation within the game. |
| team | character | EuroLeague club code of the team (Utf8 join key; space padding stripped). |
| id_player | character | EuroLeague player code (Utf8 join key; space padding stripped). |
| player | character | Player display name (SURNAME, GIVEN NAME). |
| id_action | character | Shot type code: 2FGM / 2FGA / 3FGM / 3FGA (made / attempted field goal) or FTM (made free throw). |
| action | character | Shot type label (Two Pointer, Three Pointer, Free Throw In, ...). |
| points | integer | Points the shot is worth (1, 2 or 3). |
| coord_x | integer | Shot x in integer centimeters from the hoop, signed left/right of it (-683 to 696 cm measured): both teams are mapped onto one basket; 3-point zone H is x \< 0 and I is x \> 0; which sideline is positive (from the shooter's view or from the scorer's table) is UNVERIFIED from the data alone. Made free throws (FTM) carry the -1 sentinel. |
| coord_y | integer | Shot y in integer centimeters from the hoop, growing away from the baseline toward the court (-6 to 865 cm measured; 3FG rows at 414-865): both teams are mapped onto one basket, negative y is behind the hoop. Made free throws (FTM) carry the -1 sentinel. |
| zone | character | Court zone letter: A rim, B/C close left/right, D/E mid, F/G long two, H/I three; blank on free throws. |
| fastbreak | character | Whether the shot came on a fast break (0 / 1 as a string). |
| second_chance | character | Whether the shot was a second-chance attempt (0 / 1 as a string). |
| points_off_turnover | character | Whether the shot came off a turnover (0 / 1 as a string). |
| minute | integer | Game minute of the event (1-based; 41+ in overtime). |
| console | character | Game clock at the event (mm:ss remaining in the period). |
| points_a | integer | Running score of team A (= the home side, measured on one game) after the event. |
| points_b | integer | Running score of team B (= the away side, measured on one game) after the event. |
| utc | character | UTC timestamp of the event (yyyymmddHHMMSS). |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors sdv-py's `euroleague_game_points()`: same
arguments, defaults and snake_case columns, one row per sdv-py row.

**Coordinate frame**, as measured in the reference capture (E2025 game
1, 158 rows; U2025 game 1, 176 rows):

- **Units: integer centimeters. Origin: the hoop.** 2FG radii run 8-512
  cm, 3FG radii 722-925 cm (the FIBA arc is 675 cm), zone `A` (rim) sits
  at radius 8-33 cm.

- **Both teams are mapped onto one basket; `coord_y` grows away from the
  baseline toward the court** (-6 to 865 cm for every team on the E
  game, -69 to 1028 on the U game; 3FG rows sit at y 414-865). Negative
  y is behind the hoop (the U game has a few rows up to 69 cm behind it,
  i.e. under or behind the backboard).

- `coord_x` is signed left / right of the hoop (-683 to 696 cm); 3-point
  zone `H` is x \< 0 and `I` is x \> 0. Which sideline is positive (from
  the shooter's view or from the scorer's table) is **UNVERIFIED** from
  the data alone.

- **Free throws are not located**: `FTM` rows carry
  `coord_x = coord_y = -1` and `zone = ""` (a sentinel, not a spot 1 cm
  from the hoop). Filter them out before plotting.

- `zone` letters A-I: A rim, B / C close left / right, D / E mid, F / G
  long two, H / I three.

The live API's codes are space-padded fixed-width strings
(`TEAM = "IST "`); every string cell is stripped. Its "no such game"
answer is an **empty 200 body**, returned as a zero-row tibble with the
documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 /
422 `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all
inherit `hoopR_error`).

## See also

Other Euroleague:
[`euroleague_clubs()`](https://hoopR.sportsdataverse.org/reference/euroleague_clubs.md),
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    shots <- euroleague_game_points(game_code = 1, season_code = "E2025")
    shots[shots$id_action != "FTM", c("team", "id_action", "coord_x", "coord_y", "zone")]
  })
#> ── EuroLeague game points (shot chart) from live.euroleague.net ────────────────
#> ℹ Data updated: 2026-10-09 03:48:56 UTC
#> # A tibble: 131 × 5
#>    team  id_action coord_x coord_y zone 
#>    <chr> <chr>       <int>   <int> <chr>
#>  1 IST   2FGM          -12      -6 A    
#>  2 IST   3FGA          414     602 I    
#>  3 IST   2FGM         -307       0 D    
#>  4 TEL   2FGM          -81     125 B    
#>  5 IST   3FGM          125     759 I    
#>  6 TEL   2FGM            0     351 D    
#>  7 IST   2FGM           31      94 C    
#>  8 TEL   2FGA         -382     319 F    
#>  9 TEL   2FGM         -119      87 B    
#> 10 IST   3FGA         -514     577 H    
#> # ℹ 121 more rows
# }
```
