# **IBBA Box Score**

**Box score of a finished game: player lines, a team-credited line per
side and the TOTAL line per side.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Boxscore`

## Usage

``` r
ibba_box_score(game_id, season)
```

## Arguments

- game_id:

  (*integer* required): IBBA game id (e.g. 26392): `game_id` in
  ibba_games.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

## Value

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_box_score")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

[family_ibba](https://hoopR.sportsdataverse.org/reference/family_ibba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(ibba_box_score(game_id = 26392, season = 2026))
#> ── IBBA box score ─────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:12:14 UTC
#> # A tibble: 27 × 33
#>    player_id jersey team_id game_id board_id season round starter minutes   pts
#>        <int> <chr>    <int>   <int>    <int>  <int> <int> <lgl>     <int> <int>
#>  1        NA _TEAM     1109   26392        5   2026     1 FALSE         0     0
#>  2     21917 02        1109   26392        5   2026     1 FALSE        21     8
#>  3     21903 03        1109   26392        5   2026     1 FALSE        21    17
#>  4     21911 04        1109   26392        5   2026     1 TRUE         18     2
#>  5     24797 07        1109   26392        5   2026     1 FALSE         1     0
#>  6     21906 08        1109   26392        5   2026     1 TRUE         18     6
#>  7     21913 09        1109   26392        5   2026     1 TRUE         18     9
#>  8     21901 10        1109   26392        5   2026     1 TRUE         16    11
#>  9     21919 11        1109   26392        5   2026     1 FALSE        11     0
#> 10     21915 12        1109   26392        5   2026     1 FALSE        23    18
#> # ℹ 17 more rows
#> # ℹ 23 more variables: fg2m <int>, fg2a <int>, fg2_pct <dbl>, fg3m <int>,
#> #   fg3a <int>, fg3_pct <dbl>, ftm <int>, fta <int>, ft_pct <dbl>, dreb <int>,
#> #   oreb <int>, reb <int>, fouls_drawn <int>, fouls <int>, steals <int>,
#> #   turnovers <int>, assists <int>, blocks <int>, blocks_against <int>,
#> #   val <int>, plus_minus <int>, dunks <int>, row_type <chr>
# }
```
