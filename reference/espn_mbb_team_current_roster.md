# **Get ESPN men's college basketball current team roster**

**Get ESPN men's college basketball current team roster**

**Get ESPN NBA current team roster**

## Usage

``` r
espn_mbb_team_current_roster(team_id)

espn_nba_team_current_roster(team_id)
```

## Arguments

- team_id:

  Either numeric or character (YYYY)

## Value

A teams data frame

A teams data frame

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_team_current_roster(team_id = 150))
#> ── ESPN MBB Team Current Roster Information from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:08 UTC
#> # A tibble: 15 × 47
#>    team_abbreviation team_alternate_color team_color team_display_name team_id
#>    <chr>             <chr>                <chr>      <chr>               <int>
#>  1 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  2 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  3 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  4 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  5 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  6 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  7 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  8 DUKE              ffffff               00539b     Duke Blue Devils      150
#>  9 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 10 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 11 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 12 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 13 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 14 DUKE              ffffff               00539b     Duke Blue Devils      150
#> 15 DUKE              ffffff               00539b     Duke Blue Devils      150
#> # ℹ 42 more variables: team_is_active <lgl>, team_location <chr>,
#> #   team_name <chr>, team_nickname <chr>, team_short_name <chr>,
#> #   team_slug <chr>, standingSummary <chr>, team_uid <chr>, logo <chr>,
#> #   logo_dark <chr>, group_id <int>, group_is_conference <lgl>,
#> #   parent_group_id <int>, conference_id <int>, athlete_active <lgl>,
#> #   athlete_display_height <chr>, athlete_display_name <chr>,
#> #   athlete_display_weight <chr>, athlete_first_name <chr>, …
# }
# \donttest{
try(espn_nba_team_current_roster(team_id = 13))
#> ── ESPN NBA Team Current Roster Information from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:11:08 UTC
#> # A tibble: 0 × 0
# }
```
