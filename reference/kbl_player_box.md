# **Get KBL Player Box Score**

Player box score of a final game with the vendor's advanced rates, one
row per player of both teams.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/player-stat`

## Usage

``` r
kbl_player_box(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per player of both teams. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_player_box")`) and in the searchable
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
  try(kbl_player_box(gmkey = "S47G01N49"))
#> ── KBL Player Box Score from api.kbl.or.kr ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:12:27 UTC
#> # A tibble: 24 × 71
#>    gmkey  season_code season game_code game_no team_code home_away started pcode
#>    <chr>        <int>  <int> <chr>       <int> <chr>     <chr>       <int> <chr>
#>  1 S47G0…          47   2026 01             49 50        2               0 2902…
#>  2 S47G0…          47   2026 01             49 50        2               0 2904…
#>  3 S47G0…          47   2026 01             49 50        2               0 2905…
#>  4 S47G0…          47   2026 01             49 50        2               0 2906…
#>  5 S47G0…          47   2026 01             49 50        2               1 2909…
#>  6 S47G0…          47   2026 01             49 50        2               1 2914…
#>  7 S47G0…          47   2026 01             49 50        2               1 2915…
#>  8 S47G0…          47   2026 01             49 50        2               1 2916…
#>  9 S47G0…          47   2026 01             49 50        2               0 2916…
#> 10 S47G0…          47   2026 01             49 50        2               1 2916…
#> # ℹ 14 more rows
#> # ℹ 62 more variables: player_name <chr>, player_name_en <chr>,
#> #   team_name <chr>, back_num <chr>, pos <chr>, player_flag <chr>, score <int>,
#> #   fg <int>, fg_a <int>, fgt <int>, fgt_a <int>, threep <int>, threep_a <int>,
#> #   ft <int>, ft_a <int>, dk <int>, dk_a <int>, rb <int>, offr <int>,
#> #   defr <int>, ast <int>, stl <int>, bs <int>, to <int>, foul <int>,
#> #   wft <int>, woft <int>, pp <int>, pp_a <int>, pscore <int>, sast <int>, …
# }
```
