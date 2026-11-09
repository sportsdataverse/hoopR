# **IBBA Games**

**Games (schedule and results) of a season filtered by board, round,
team and game; 0 means any.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/Games`

## Usage

``` r
ibba_games(
  season,
  board_id = 0,
  board_round = 0,
  team_id = 0,
  team_uid = 0,
  game_id = 0
)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `0`): Competition (board) id: 5 league, 10 cup, 16
  / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34
  Supercup. 0 (default) for every board.

- board_round:

  (*integer*, default `0`): Round (game number) within the board; 0
  (default) for every round.

- team_id:

  (*integer*, default `0`): Team-season id; 0 (default) for every team.

- team_uid:

  (*integer*, default `0`): IBBA club id; 0 (default) for every club.

- game_id:

  (*integer*, default `0`): IBBA game id; 0 (default) for every game.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_games")`) and in the searchable
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
  try(ibba_games(board_id = 5, board_round = 1, season = 2026))
#> ── IBBA games ─────────────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:49 UTC
#> # A tibble: 7 × 30
#>   game_id game_date  season home_team_id away_team_id home_team_he  away_team_he
#>     <int> <date>      <int>        <int>        <int> <chr>         <chr>       
#> 1   26391 2025-10-12   2026         1110         1114 "הפועל IBI ת… עירוני לאטי…
#> 2   26392 2025-10-12   2026         1120         1109 "הפועל אלטשו… מכבי Rapyd …
#> 3   26394 2025-10-12   2026         1119         1122 "הפועל Rivul… הפועל גילת …
#> 4   26393 2025-10-12   2026         1112         1116 "הפועל מידטא… עירוני חי מ…
#> 5   26390 2025-10-12   2026         1111         1123 "מכבי קבוצת … מכבי תפוזינ…
#> 6   26395 2025-10-13   2026         1124         2109 "מכבי אב־גד … אליצור נתניה
#> 7   26389 2025-12-24   2026         1118         1113 "בני Penlink… הפועל נתנאל…
#> # ℹ 23 more variables: home_team <chr>, away_team <chr>, home_logo_url <chr>,
#> #   away_logo_url <chr>, home_score <int>, away_score <int>, board_id <int>,
#> #   board_name_he <chr>, board_name <chr>, round <int>, tip_off <chr>,
#> #   venue_he <chr>, venue <chr>, referees_he <chr>, attendance <int>,
#> #   overtime <lgl>, overtimes <int>, home_score_by_period <chr>,
#> #   away_score_by_period <chr>, tickets_url <chr>, external_id <chr>,
#> #   segev_game_id <int>, is_external <lgl>
# }
```
