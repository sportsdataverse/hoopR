# **Get VTB League Leagues**

The leagues served by the API: vtb, vtbyouth, wbc.

Endpoint: `GET https://api.vtb-league.com/v2/leagues`

## Usage

``` r
vtb_league_leagues()
```

## Value

A `hoopR_data` tibble: The leagues served by the API: vtb, vtbyouth,
wbc. The columns are always these, in this order (sportsdataverse-py
`vtb_league_leagues`); an empty valid answer raises `hoopR_no_data`, a
valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| league_id | integer | v2 league id (1 vtb, 2 vtbyouth, 3 wbc). Not an Infobasket id. |
| league | character | League slug used in the paths: 'vtb' (VTB United League), 'vtbyouth' (youth league), 'wbc' (WINLINE Basket Cup). |
| league_name_en | character | The league name in English. |
| league_name_ru | character | The league name in Russian. |
| league_abbrev_en | character | The league abbreviation in English. |
| league_abbrev_ru | character | The league abbreviation in Russian. |

## Details

- Source, access, seasons, ids and the error classes: see the notes of
  [`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

- v2 pages: meta.count is the rows returned (not a total), page is
  ignored and the default limit is 20, so the matches wrapper asks for
  1000 and refuses a body whose count reaches its limit. The API lists
  new seasons only (from 2024-25; vtb: 2025-2027, wbc: 2026-2027):
  earlier years answer no rows (`hoopR_no_data`).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_league_leagues())
#> ── VTB League Leagues from api.vtb-league.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:10:21 UTC
#> # A tibble: 3 × 6
#>   league_id league   league_name_en          league_name_ru     league_abbrev_en
#>       <int> <chr>    <chr>                   <chr>              <chr>           
#> 1         1 vtb      VTB United League       Единая Лига ВТБ    VTB UL          
#> 2         2 vtbyouth VTB Youth United League Молодежный чемпио… YCH             
#> 3         3 wbc      WINLINE Basket Cup      WINLINE Basket Cup WBC             
#> # ℹ 1 more variable: league_abbrev_ru <chr>
# }
```
