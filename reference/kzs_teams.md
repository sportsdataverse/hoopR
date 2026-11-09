# **Get KZS Teams**

Teams entered in a competition.

Endpoint: `GET https://api.kzs.si/api/v1/public/teams/`

## Usage

``` r
kzs_teams(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (competition_id in kzs_competitions): one
  per competition per season, e.g. 579 (men's first league 2025/26).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_teams(competition_id = 579))
#> ── KZS Teams from api.kzs.si ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:14:28 UTC
#> # A tibble: 11 × 19
#>    competition_id team_id team_application_id club_id club_member
#>             <int>   <int>               <int>   <int> <lgl>      
#>  1            579   17548               45427     254 FALSE      
#>  2            579   17549               45359      55 FALSE      
#>  3            579   17550               45131      46 FALSE      
#>  4            579   17551               45242      16 FALSE      
#>  5            579   17552               45065      26 FALSE      
#>  6            579   17553               45218      49 FALSE      
#>  7            579   17554               45208      56 FALSE      
#>  8            579   17555               45018      45 FALSE      
#>  9            579   17556               45647      44 FALSE      
#> 10            579   17557               45625      59 FALSE      
#> 11            579   17558               45576       9 FALSE      
#> # ℹ 14 more variables: team_internal_ranking <chr>, category <chr>, rank <chr>,
#> #   gender <chr>, sport_hall_id <int>, sport_hall_name <chr>, name <chr>,
#> #   code <chr>, home_jersey_color <chr>, guest_jersey_color <chr>,
#> #   logo_uuid <chr>, home_team_color <chr>, guest_team_color <chr>,
#> #   short_name <chr>
# }
```
