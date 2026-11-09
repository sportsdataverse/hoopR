# **Get TPBL Roster**

The registered roster of one team in one division (birth dates omitted).

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/players`

## Usage

``` r
tpbl_roster(division_id, team_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- team_id:

  Required. TPBL team id (the franchise, 2-8, stable across seasons);
  `team_id` in tpbl_teams. Not the GoHoops id.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_roster")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(tpbl_roster(division_id = 2, team_id = 4))
#> ── TPBL Roster from api.tpbl.basketball ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:49 UTC
#> # A tibble: 13 × 20
#>    division_id team_id team        player_id gohoops_person_id gohoops_roster_id
#>          <int>   <int> <chr>           <int>             <int>             <int>
#>  1           2       4 新竹御嵿攻城獅……        71             70828            126991
#>  2           2       4 新竹御嵿攻城獅……        75             70832            126997
#>  3           2       4 新竹御嵿攻城獅……        76             70833            126998
#>  4           2       4 新竹御嵿攻城獅……        78             70835            127000
#>  5           2       4 新竹御嵿攻城獅……        82             70839            127005
#>  6           2       4 新竹御嵿攻城獅……        87             70845            127011
#>  7           2       4 新竹御嵿攻城獅……        88             70846            127013
#>  8           2       4 新竹御嵿攻城獅……        93             70851            127019
#>  9           2       4 新竹御嵿攻城獅……        96             70854            127023
#> 10           2       4 新竹御嵿攻城獅……       100             70859            127030
#> 11           2       4 新竹御嵿攻城獅……      4182             79430            144851
#> 12           2       4 新竹御嵿攻城獅……      7894             80361            148576
#> 13           2       4 新竹御嵿攻城獅……      9034             82278            150660
#> # ℹ 14 more variables: gohoops_squad_id <int>, gohoops_event_id <int>,
#> #   gohoops_season_id <int>, player <chr>, alt_name <chr>, number <chr>,
#> #   position <chr>, height_cm <int>, weight_kg <dbl>, nationality <chr>,
#> #   national_identity <chr>, national_identity_detail <chr>, registered <lgl>,
#> #   is_listing <lgl>
# }
```
