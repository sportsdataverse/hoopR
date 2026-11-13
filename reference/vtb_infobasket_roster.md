# **Get VTB Infobasket Roster**

A club's player roster in one season.

Endpoint: `GET https://org.infobasket.su/Widget/TeamRoster/{team_id}`

## Usage

``` r
vtb_infobasket_roster(team_id, season, lang = "en", tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached). Required.

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_roster")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_roster(season = 2026, team_id = 2650))
#> ── VTB Infobasket Roster from org.infobasket.su ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:18:57 UTC
#> # A tibble: 19 × 25
#>    team_id season person_id player_number display_number is_captain birth_date
#>      <int>  <int>     <int>         <int> <chr>          <lgl>      <chr>     
#>  1    2650   2026    337028             0 0              FALSE      2004-03-21
#>  2    2650   2026    423011             2 2              FALSE      1992-05-22
#>  3    2650   2026    537998             4 4              FALSE      1994-05-30
#>  4    2650   2026    393326             5 5              FALSE      1996-06-19
#>  5    2650   2026     43256             7 7              FALSE      2002-02-01
#>  6    2650   2026     47609            12 12             FALSE      2002-07-12
#>  7    2650   2026    254536            14 14             FALSE      2006-05-25
#>  8    2650   2026     39197            16 16             FALSE      2000-11-03
#>  9    2650   2026     48680            23 23             FALSE      2005-02-10
#> 10    2650   2026     24712            27 27             FALSE      1995-04-04
#> 11    2650   2026    154368            32 32             FALSE      1994-08-05
#> 12    2650   2026     35822            33 33             FALSE      2000-07-09
#> 13    2650   2026     51909            37 37             FALSE      2003-10-21
#> 14    2650   2026     39489            38 38             FALSE      2000-12-06
#> 15    2650   2026    288451            44 44             FALSE      1999-03-19
#> 16    2650   2026     55701            99 99             FALSE      2003-08-23
#> 17    2650   2026    393167             1 1              FALSE      1995-12-21
#> 18    2650   2026    490452             3 3              FALSE      1994-04-20
#> 19    2650   2026    377837            17 17             FALSE      1999-03-17
#> # ℹ 18 more variables: pos_id <int>, position <chr>, nationality_code <chr>,
#> #   country_code <chr>, country_code_ioc <chr>, country_name <chr>, rank <int>,
#> #   height <int>, weight <int>, is_active <lgl>, active_status <chr>,
#> #   person_last_name_ru <chr>, person_last_name_en <chr>,
#> #   person_first_name_ru <chr>, person_first_name_en <chr>,
#> #   person_full_name_ru <chr>, person_full_name_en <chr>, person_gender <int>
# }
```
