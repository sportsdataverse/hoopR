# **Get EASL Players**

Every EASL player of all seasons; with season and team_id a roster that
adds jersey number and position.

Endpoint: `GET https://easl.joshricha.com/api/v1/players`

## Usage

``` r
easl_players(season = NULL, team_id = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: no season filter.

- team_id:

  DataCore team (entity) UUID v1, e.g.
  '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the team_id
  of easl_teams, easl_standings and the box scores. easl_team resolves
  the 12 historical teams easl_teams does not list. Needs season for a
  roster (jersey number and position). Default `NULL`: no team filter.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_players")`) and in the searchable
[return
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
  try(easl_players(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#> ── EASL Players from easl.joshricha.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:53:03 UTC
#> # A tibble: 17 × 20
#>    season season_id    player_row_id player_id name  name_latin name_abbreviated
#>     <int> <chr>                <int> <chr>     <chr> <chr>      <chr>           
#>  1   2026 77441bb3-97…            42 177cdc17… MATS… NA         NA              
#>  2   2026 77441bb3-97…            81 2c03440a… Just… Justin HA… NA              
#>  3   2026 77441bb3-97…            87 2e016dfa… ISHI… ISHIKAWA … NA              
#>  4   2026 77441bb3-97…           159 57598895… HOSH… HOSHIKAWA… NA              
#>  5   2026 77441bb3-97…           233 85c99dab… D.J.… D.J. NEWB… NA              
#>  6   2026 77441bb3-97…           287 897d9aab… TABU… TABUSE Yu… NA              
#>  7   2026 77441bb3-97…           288 8983317f… HIEJ… HIEJIMA M… NA              
#>  8   2026 77441bb3-97…           289 8984fe11… OGAW… OGAWA Ats… NA              
#>  9   2026 77441bb3-97…           290 8986bf47… ENDO… ENDO Yusu… NA              
#> 10   2026 77441bb3-97…           291 89889819… TAKE… TAKEUCHI … NA              
#> 11   2026 77441bb3-97…           292 8a4180f3… TAKA… TAKASHIMA… NA              
#> 12   2026 77441bb3-97…           293 8a44d984… WATA… WATANABE … NA              
#> 13   2026 77441bb3-97…           294 8a4b82f4… IKAR… IKARUGA S… NA              
#> 14   2026 77441bb3-97…           295 8a4f5e97… Gran… Grant JER… NA              
#> 15   2026 77441bb3-97…           296 8a530bfe… Isaa… Isaac FOTU NA              
#> 16   2026 77441bb3-97…           508 e670b5bc… Gavi… Gavin EDW… NA              
#> 17   2026 77441bb3-97…           537 f8a930cf… Blak… Blake AOKI NA              
#> # ℹ 13 more variables: nationality <chr>, gender <chr>, dob <date>,
#> #   height_cm <int>, height_feet <chr>, weight_kg <int>, weight_lbs <int>,
#> #   status <chr>, jersey_number <chr>, position <chr>, organization_id <chr>,
#> #   created_at <chr>, updated_at <chr>
# }
```
