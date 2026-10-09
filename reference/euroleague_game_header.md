# **EuroLeague Game Header**

**Get the header of one game from the live API: teams, codes, coaches,
score by quarter, venue, referees, one row.**

Endpoint:
`GET https://live.euroleague.net/api/Header?gamecode={game_code}&seasoncode={season_code}`

The header is a flat object: teams, codes, coaches, the score and the
**cumulative** score at the end of each quarter (`score_quarter1_a`
...), venue, capacity (as reported; its semantics are unverified) and
referees. Team A is the home side as measured on one game.

## Usage

``` r
euroleague_game_header(game_code, season_code)
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

A `hoopR_data` tibble with one row (the game):

|  |  |  |
|----|----|----|
| col_name | types | description |
| live | logical | Whether the game is in progress. |
| round | character | Round label (e.g. Round 1). |
| date | character | Game date (venue local, dd/mm/yyyy). |
| hour | character | Scheduled tip-off time (venue local, HH:MM). |
| stadium | character | Venue name. |
| capacity | character | Capacity as reported by the API (equals the box score's attendance on the captured game; semantics unverified). |
| team_a | character | Display name of team A (= the home side, measured on one game). |
| team_b | character | Display name of team B (= the away side, measured on one game). |
| code_team_a | character | EuroLeague club code of team A (= the home side, measured on one game); Utf8 join key. |
| tv_code_a | character | Three-letter broadcast abbreviation of team A. |
| code_team_b | character | EuroLeague club code of team B (= the away side, measured on one game); Utf8 join key. |
| tv_code_b | character | Three-letter broadcast abbreviation of team B. |
| im_a | character | Crest image file name of team A. |
| im_b | character | Crest image file name of team B. |
| score_a | character | Score of team A (= the home side, measured on one game). |
| score_b | character | Score of team B (= the away side, measured on one game). |
| coach_a | character | Head coach of team A. |
| coach_b | character | Head coach of team B. |
| game_time | character | Elapsed game time (mm:ss). |
| remaining_partial_time | character | Time remaining in the current period (mm:ss). |
| wid | character | Live-feed widget identifier of the game. |
| quarter | character | Current period of the game. |
| foults_a | character | Team fouls of team A in the current period (sic: the API spells it this way). |
| foults_b | character | Team fouls of team B in the current period (sic: the API spells it this way). |
| timeouts_a | character | Timeouts used by team A. |
| timeouts_b | character | Timeouts used by team B. |
| score_quarter1_a | integer | Score of team A at the end of quarter 1 (cumulative). |
| score_quarter2_a | integer | Score of team A at the end of quarter 2 (cumulative). |
| score_quarter3_a | integer | Score of team A at the end of quarter 3 (cumulative). |
| score_quarter4_a | integer | Score of team A at the end of quarter 4 (cumulative). |
| score_extra_time_a | integer | Points scored by team A in overtime (0 when none). |
| score_quarter1_b | integer | Score of team B at the end of quarter 1 (cumulative). |
| score_quarter2_b | integer | Score of team B at the end of quarter 2 (cumulative). |
| score_quarter3_b | integer | Score of team B at the end of quarter 3 (cumulative). |
| score_quarter4_b | integer | Score of team B at the end of quarter 4 (cumulative). |
| score_extra_time_b | integer | Points scored by team B in overtime (0 when none). |
| phase | character | Phase name (Regular Season, Playoffs, ...). |
| phase_reduced_name | character | Short phase name. |
| competition | character | Competition name. |
| competition_reduced_name | character | Short competition name. |
| pcom | character | Competition code of the live feed (E = EuroLeague, U = EuroCup). |
| referee1 | character | First referee. |
| referee2 | character | Second referee. |
| referee3 | character | Third referee. |

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
    euroleague_game_header(game_code = 1, season_code = "E2025")
  })
#> ── EuroLeague game header from live.euroleague.net ───────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 05:33:11 UTC
#> # A tibble: 1 × 44
#>   live  round date    hour  stadium capacity team_a team_b code_team_a tv_code_a
#>   <lgl> <chr> <chr>   <chr> <chr>   <chr>    <chr>  <chr>  <chr>       <chr>    
#> 1 FALSE 1     30/09/… 19:45 MORACA  2110     ANADO… MACCA… IST         EFS      
#> # ℹ 34 more variables: code_team_b <chr>, tv_code_b <chr>, im_a <chr>,
#> #   im_b <chr>, score_a <chr>, score_b <chr>, coach_a <chr>, coach_b <chr>,
#> #   game_time <chr>, remaining_partial_time <chr>, wid <chr>, quarter <chr>,
#> #   foults_a <chr>, foults_b <chr>, timeouts_a <chr>, timeouts_b <chr>,
#> #   score_quarter1_a <int>, score_quarter2_a <int>, score_quarter3_a <int>,
#> #   score_quarter4_a <int>, score_extra_time_a <int>, score_quarter1_b <int>,
#> #   score_quarter2_b <int>, score_quarter3_b <int>, score_quarter4_b <int>, …
# }
```
