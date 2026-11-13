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

A `hoopR_data` tibble with one row per player, plus two team rows per
side. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_game_boxscore")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

The live API's codes are space-padded fixed-width strings
(`TEAM = "IST "`); every string cell is stripped. Its "no such game"
answer is an **empty 200 body**, returned as a zero-row tibble with the
documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 /
422 `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all
inherit `hoopR_error`).

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    box <- euroleague_game_boxscore(game_code = 1, season_code = "E2025")
    box[box$row_type == "player", c("team", "player", "minutes", "points", "valuation")]
  })
#> ── EuroLeague game box score from live.euroleague.net ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:31 UTC
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
