# **EuroLeague Game Box Score (live API)**

**Get the box score of one game from the live API: one row per player
plus each side's team-only and totals rows, with by-quarter scores,
referees and attendance repeated on every row.**

Endpoint:
`GET https://live.euroleague.net/api/Boxscore?gamecode={game_code}&seasoncode={season_code}`

`Stats` holds one object per side (`Team`, `Coach`, `PlayersStats`,
`tmr` = team-only rebounds, `totr` = totals). Each side's players become
rows tagged `row_type = "player"`, followed by the side's `"team"` and
`"total"` rows. Every row also carries the game's `attendance` and
`referees` and, for the row's side, `team_name`, `coach`, the points
scored per quarter (`by_quarter_q1` ...) and the cumulative score at the
end of each quarter (`end_of_quarter_q1` ...).

## Usage

``` r
euroleague_game_boxscore(game_code, season_code)
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

A `hoopR_data` tibble with one row per player plus two per side:

|  |  |  |
|----|----|----|
| col_name | types | description |
| row_type | character | Row kind: player, team (team-only rebounds) or total (side totals). |
| team_name | character | Club display name. |
| coach | character | Head coach name. |
| attendance | character | Attendance, as reported by the box score (repeated on every row). |
| referees | character | Referees of the game, comma-separated SURNAME, GIVEN NAME (repeated on every row). |
| by_quarter_q1 | integer | Points the row's team scored in quarter 1 (from the box score's ByQuarter block). |
| by_quarter_q2 | integer | Points the row's team scored in quarter 2 (from the box score's ByQuarter block). |
| by_quarter_q3 | integer | Points the row's team scored in quarter 3 (from the box score's ByQuarter block). |
| by_quarter_q4 | integer | Points the row's team scored in quarter 4 (from the box score's ByQuarter block). |
| end_of_quarter_q1 | integer | Score of the row's team at the end of quarter 1 (cumulative; from the box score's EndOfQuarter block). |
| end_of_quarter_q2 | integer | Score of the row's team at the end of quarter 2 (cumulative; from the box score's EndOfQuarter block). |
| end_of_quarter_q3 | integer | Score of the row's team at the end of quarter 3 (cumulative; from the box score's EndOfQuarter block). |
| end_of_quarter_q4 | integer | Score of the row's team at the end of quarter 4 (cumulative; from the box score's EndOfQuarter block). |
| player_id | character | EuroLeague player code (Utf8 join key; space padding stripped; blank on team rows). |
| is_starter | integer | Whether the player started (1 / 0). |
| is_playing | integer | Whether the player appeared in the game (1 / 0). |
| team | character | EuroLeague club code of the team (Utf8 join key; space padding stripped). |
| dorsal | character | Jersey number as displayed. |
| player | character | Player display name (SURNAME, GIVEN NAME). |
| minutes | character | Minutes played (mm:ss). |
| points | integer | Points. |
| field_goals_made2 | integer | Two-point field goals made. |
| field_goals_attempted2 | integer | Two-point field goals attempted. |
| field_goals_made3 | integer | Three-point field goals made. |
| field_goals_attempted3 | integer | Three-point field goals attempted. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throws attempted. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| total_rebounds | integer | Total rebounds. |
| assistances | integer | Assists. |
| steals | integer | Steals. |
| turnovers | integer | Turnovers. |
| blocks_favour | integer | Blocks made. |
| blocks_against | integer | Shots blocked by the opponent. |
| fouls_commited | integer | Personal fouls committed. |
| fouls_received | integer | Fouls drawn. |
| valuation | integer | Performance index rating (PIR). |
| plusminus | numeric | Plus/minus. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

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
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    box <- euroleague_game_boxscore(game_code = 1, season_code = "E2025")
    box[box$row_type == "player", c("team", "player", "minutes", "points", "valuation")]
  })
#> ── EuroLeague game box score from live.euroleague.net ────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-10 23:07:36 UTC
#> # A tibble: 24 × 5
#>    team  player                minutes points valuation
#>    <chr> <chr>                 <chr>    <int>     <int>
#>  1 IST   LARKIN, SHANE         33:21       14        12
#>  2 IST   BEAUBOIS, RODRIGUE    DNP          0         0
#>  3 IST   HAZER, SEHMUS         07:41        0        -4
#>  4 IST   LOYD, JORDAN          24:15       16        15
#>  5 IST   WEILER-BABB, NICK     22:53       12        19
#>  6 IST   PAPAGIANNIS, GEORGIOS 13:20        2         9
#>  7 IST   CORDINIER, ISAIA      30:50        7         3
#>  8 IST   SMITS, ROLANDS        15:50       16        17
#>  9 IST   SWIDER, COLE          01:47        0        -1
#> 10 IST   OSMANI, ERCAN         31:41       12        11
#> # ℹ 14 more rows
# }
```
