# **Get LBA Players**

Players of a season, 50 per page (walk the pages with page).

Endpoint: `GET https://www.legabasket.it/api/players/get-players`
(`items=50&year=<season>&page=<page>`)

## Usage

``` r
lba_players(season = NULL, page = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- page:

  Page number, 1-based. Omitted = the first page.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_players")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_players(season = 2027))
#> ── LBA Players from legabasket.it ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:55:16 UTC
#> # A tibble: 50 × 8
#>    season player_id name     surname    code  team_name  year player_picture_key
#>     <int>     <int> <chr>    <chr>      <chr> <chr>     <int> <chr>             
#>  1   2027        45 Nicola   Akele      AKE-… Armani O…  2026 sgwgsNL364vhCY9a8…
#>  2   2027        75 Amar     Alibegovic ALI-… Bertram …  2026 pZpWxP6Z5UPXzXW79…
#>  3   2027        76 Mirza    Alibegovic ALI-… Maxima R…  2026 Cx9Jyg8zFa2WqE3fF…
#>  4   2027      9332 Gregorio Allinei    ALL-… Nutribul…  2026 vcEjLiSLXW6H3CKuN…
#>  5   2027      9004 Derrick  Alston     ALS-… Virtus C…  2026 aX7pjgftNWGb3T3gG…
#>  6   2027        97 Davide   Alviti     ALV-… Openjobm…  2026 CchJHtkhZVSmQAXmh…
#>  7   2027       106 Lorenzo  Ambrosin   AMB-… Tezenis …  2026 8dQgaTER6wxGYUrXM…
#>  8   2027      9341 Andrew   Andrews    AND-… Tezenis …  2026 mFs7xD6hFHPQfxx6i…
#>  9   2027      9042 Ike      Anigbogu   ANI-… Nutribul…  2026 eNePF3FEwau1vBLPU…
#> 10   2027      9380 Gerald   Ayayi      AYA-… BC Roma    2026 wdm9w7UexGb9zaSL8…
#> # ℹ 40 more rows
# }
```
