# **EuroLeague Game Play-by-Play**

**Get the play-by-play of one game from the live API, one row per
play.**

Endpoint:
`GET https://live.euroleague.net/api/PlayByPlay?gamecode={game_code}&seasoncode={season_code}`

The body carries one array per period (`FirstQuarter`, `SecondQuarter`,
`ThirdQuarter`, `ForthQuarter` (sic), `ExtraTime`) beside the two team
names and codes. The arrays are unrolled in game order with a leading
`quarter` column (1-4; 5 for every overtime period, which the body does
not split further) and the `team_a` / `team_b` / `code_team_a` /
`code_team_b` header fields repeated on every row. Team A is the home
side as measured on one game.

## Usage

``` r
euroleague_game_pbp(game_code, season_code)
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

A `hoopR_data` tibble with one row per play:

|  |  |  |
|----|----|----|
| col_name | types | description |
| quarter | integer | Period of the play: 1-4, or 5 for every overtime period. |
| team_a | character | Display name of team A (= the home side, measured on one game). |
| team_b | character | Display name of team B (= the away side, measured on one game). |
| code_team_a | character | EuroLeague club code of team A (= the home side, measured on one game); Utf8 join key. |
| code_team_b | character | EuroLeague club code of team B (= the away side, measured on one game); Utf8 join key. |
| type | integer | Play type (engine integer). |
| numberofplay | integer | Sequence number of the play within the game. |
| codeteam | character | EuroLeague club code of the team on the play (Utf8 join key; blank on administrative plays). |
| player_id | character | EuroLeague player code (Utf8 join key; space padding stripped; blank on team rows). |
| playtype | character | Play type code (BP = begin period, 2FGM, 3FGA, FTM, AS = assist, TO, RV, CM, ...). |
| player | character | Player display name (SURNAME, GIVEN NAME). |
| team | character | Display name of the team on the play (null on administrative plays). |
| dorsal | character | Jersey number as displayed. |
| minute | integer | Game minute of the event (1-based; 41+ in overtime). |
| markertime | character | Game clock at the play (mm:ss remaining in the period). |
| points_a | integer | Running score of team A (= the home side, measured on one game) after the event. |
| points_b | integer | Running score of team B (= the away side, measured on one game) after the event. |
| comment | character | Free-text annotation of the play. |
| playinfo | character | Play description. |

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
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
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
    pbp <- euroleague_game_pbp(game_code = 1, season_code = "E2025")
    table(pbp$codeteam[pbp$playtype %in% c("2FGM", "3FGM", "FTM")])
  })
#> 
#> IST TEL 
#>  44  43 
# }
```
