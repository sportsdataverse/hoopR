# **Get EASL Player Box Score**

Player box score of a finished game, one row per rostered player
(non-players have null counting stats).

Endpoint:
`GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/boxscore`

## Usage

``` r
easl_player_box(fixture_id)
```

## Arguments

- fixture_id:

  (required) DataCore fixture (game) UUID v1, e.g.
  '10af8fd4-106e-11f1-960b-5798087c7aa3' (the 2025-26 EASL
  Championship): the 'id' of easl_schedule rows. Only finished
  (CONFIRMED) games are served; a malformed id is `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per rostered player. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_player_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_player_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#> ── EASL Player Box Score from easl.joshricha.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:57:21 UTC
#> # A tibble: 24 × 94
#>    fixture_id           team_id team_name team_name_native player_id player_name
#>    <chr>                <chr>   <chr>     <chr>            <chr>     <chr>      
#>  1 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 26d8f5c8… LU Chun-Hs…
#>  2 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 5d009383… William AR…
#>  3 10af8fd4-106e-11f1-… f17004… Taoyuan … Taoyuan Pauian … 689dc46e… Alec BROWN 
#>  4 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 85c99dab… D.J. NEWBI…
#>  5 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 897d9aab… TABUSE Yuta
#>  6 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8983317f… HIEJIMA Ma…
#>  7 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8984fe11… OGAWA Atsu…
#>  8 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8986bf47… ENDO Yusuke
#>  9 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 89889819… TAKEUCHI K…
#> 10 10af8fd4-106e-11f1-… 865489… Utsunomi… 宇都宮ブレックス 8a4180f3… TAKASHIMA …
#> # ℹ 14 more rows
#> # ℹ 88 more variables: player_name_latin <chr>, bib <chr>, position <chr>,
#> #   starter <lgl>, is_player <lgl>, is_team_official <lgl>, played <lgl>,
#> #   minutes_played <dbl>, assists <int>, assists_defensive <int>,
#> #   assists_turnover_ratio <dbl>, blocks <int>, blocks_received <int>,
#> #   double_double <int>, dunks <int>, efficiency <int>,
#> #   efficiency_custom <int>, field_goals_attempted <int>, …
# }
```
