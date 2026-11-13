# **Get KBL Play-by-Play**

Play-by-play (the site's text cast) of a final game, one row per event,
from 1997-98 on.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/text-cast`

## Usage

``` r
kbl_pbp(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per event. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_pbp")`) and in the searchable
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
  try(kbl_pbp(gmkey = "S47G01N49"))
#> ── KBL Play-by-Play from api.kbl.or.kr ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:16:26 UTC
#> # A tibble: 603 × 23
#>    gmkey  season_code season game_code game_no action_number event_number period
#>    <chr>        <int>  <int> <chr>       <int>         <int>        <int>  <int>
#>  1 S47G0…          47   2026 01             49             1            1      1
#>  2 S47G0…          47   2026 01             49             2            2      1
#>  3 S47G0…          47   2026 01             49             3            3      1
#>  4 S47G0…          47   2026 01             49             4            4      1
#>  5 S47G0…          47   2026 01             49             5            5      1
#>  6 S47G0…          47   2026 01             49             6            6      1
#>  7 S47G0…          47   2026 01             49             7            7      1
#>  8 S47G0…          47   2026 01             49             8            8      1
#>  9 S47G0…          47   2026 01             49             9            9      1
#> 10 S47G0…          47   2026 01             49            10           10      1
#> # ℹ 593 more rows
#> # ℹ 15 more variables: period_label <chr>, minutes_left <int>,
#> #   seconds_left <int>, clock_seconds_left <int>, team_code <chr>,
#> #   player_name <chr>, player_name_en <chr>, action_code <chr>, action <chr>,
#> #   action_ko <chr>, points <int>, substitution_code <chr>, substitution <chr>,
#> #   foul_code <chr>, foul <chr>
# }
```
