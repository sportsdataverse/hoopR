# **Get CBA Team Basic**

A team's per-game averages or totals, one row per season of the team.

Endpoint: `POST https://data-server.cbaleague.com/api/teams/basic-data`
(JSON body)

## Usage

``` r
cba_team_basic(
  team_id,
  match_type_id = 1,
  statistical_dimension = 1,
  self_or_other = 1
)
```

## Arguments

- team_id:

  (required) Required. CBA team id (clubs, stable across seasons and
  renames).

- match_type_id:

  (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3
  preseason, 4 all-star, 9 relegation play-off (cba_match_types).

- statistical_dimension:

  (default `1`) How counting columns are formatted: 1 per game
  (default), 2 season total, 3 and 4 per 100 possessions.

- self_or_other:

  (default `1`) Whose statistics: 1 the team's own (default), 2 its
  opponents'.

## Value

A `hoopR_data` tibble with one row per season of the team. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_team_basic")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_team_basic(team_id = 29128))
#> ── CBA Team Basic from data-server.cbaleague.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:35 UTC
#> # A tibble: 21 × 30
#>    assists blocked cba_rank field_goals field_goals_attempted
#>      <dbl>   <dbl> <chr>          <dbl>                 <dbl>
#>  1    22.6     4.4 NA              37.3                  81.1
#>  2    23.7     3.9 NA              37.7                  78.7
#>  3    19.9     3.2 NA              32.1                  68  
#>  4    21.1     2.2 NA              43.7                  87.4
#>  5    24.3     3.7 NA              40.4                  85.1
#>  6    26.1     4.4 NA              39                    76.7
#>  7    17.3     3.8 NA              41.3                  86.8
#>  8    20.3     4   NA              39.3                  83  
#>  9    25.8     3.7 NA              38.6                  79.4
#> 10    13.7     2.7 NA              41                    76.1
#> # ℹ 11 more rows
#> # ℹ 25 more variables: field_goals_percentage_rate <dbl>, fouls <dbl>,
#> #   free_throws <dbl>, free_throws_attempted <dbl>,
#> #   free_throws_percentage_rate <dbl>, losses_number <int>, points <dbl>,
#> #   real_player_times <int>, rebounds <dbl>, rebounds_defensive <dbl>,
#> #   rebounds_offensive <dbl>, round <dbl>, schedule_number <int>,
#> #   schedule_season <int>, season <chr>, steals <dbl>, team_id <int>, …
# }
```
