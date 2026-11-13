# **Get KBL Game Header**

Game header of a final game: teams, final score, overtimes, venue,
attendance, officials and coaches.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}`

## Usage

``` r
kbl_game(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_game")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kbl_game(gmkey = "S47G01N49"))
#> ── KBL Game Header from api.kbl.or.kr ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:51:51 UTC
#> # A tibble: 1 × 40
#>   gmkey     glkey  season season_code season_name season_grade game_code game_no
#>   <chr>     <chr>   <int>       <int> <chr>              <int> <chr>       <int>
#> 1 S47G01N49 S47G01   2026          47 2025-2026              1 01             49
#> # ℹ 32 more variables: season_category_name <chr>, game_date <date>,
#> #   week_day <chr>, game_start <chr>, game_end <chr>, game_time <int>,
#> #   home_team_code <chr>, away_team_code <chr>, home_team_name <chr>,
#> #   away_team_name <chr>, home_team_name_full <chr>, away_team_name_full <chr>,
#> #   home_score <int>, away_score <int>, overtimes <int>, is_started <int>,
#> #   is_ended <int>, playing_quarter <chr>, stadium_name <chr>,
#> #   stadium_name_full <chr>, stadium_name_en <chr>, crowds <int>, tv <chr>, …
# }
```
