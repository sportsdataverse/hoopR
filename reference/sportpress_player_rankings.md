# **Get BNXT League Player Rankings**

Qualified-player per-game leaders in nine categories (one row per player
and category).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/player/average-rankings/{competition_id}`

## Usage

``` r
sportpress_player_rankings(
  competition_id,
  phase_id = NULL,
  limit = NULL,
  type = NULL
)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

- limit:

  (default `NULL`) Cap each ranking list at this many rows. Omitted =
  the complete lists.

- type:

  (default `NULL`) Return one ranking category only (e.g. `points`);
  `all` or omitted = the nine categories.

## Value

A `hoopR_data` tibble with one row per player and category. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_player_rankings")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_player_rankings(competition_id = 24, limit = 5))
#> ── BNXT League Player Rankings from Sportpress ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:17 UTC
#> # A tibble: 45 × 15
#>    competition_id category    rank roster_id player_id first_name last_name
#>             <int> <chr>      <int>     <int>     <int> <chr>      <chr>    
#>  1             24 efficiency     1     10885      5403 Dante      Maddox Jr
#>  2             24 efficiency     2     10361      3002 Zaba       Bangala  
#>  3             24 efficiency     3     10681      5287 Maks       Klanjscek
#>  4             24 efficiency     4     10917      5417 Shakael    Pryce    
#>  5             24 efficiency     5     10753      5317 Noam       Yaacov   
#>  6             24 points         1     10885      5403 Dante      Maddox Jr
#>  7             24 points         2     10663      5277 Jalen      Blackmon 
#>  8             24 points         3     10681      5287 Maks       Klanjscek
#>  9             24 points         4     10917      5417 Shakael    Pryce    
#> 10             24 points         5     10825      5361 Reginald   Mesidor  
#> # ℹ 35 more rows
#> # ℹ 8 more variables: nationality_code <chr>, birth_date <date>,
#> #   competition_team_id <int>, team <chr>, team_short_name <chr>, value <dbl>,
#> #   throw_made <dbl>, throw_attempted <dbl>
# }
```
