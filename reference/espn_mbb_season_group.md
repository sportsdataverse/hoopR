# **Get ESPN MBB Season Group Detail**

Returns metadata for one group (conference or division) in one (MBB
season x season-type), plus `$ref` URLs to its parent group, children
groups, member teams, and standings.

Returns the list of child groups (e.g. divisions within a conference)
for one (MBB season x season-type x parent-group).

Returns the list of team IDs that belong to one group (conference or
division) for one (MBB season x season-type).

Returns metadata for one group (conference or division) in one (NBA
season x season-type), plus `$ref` URLs to its parent group, children
groups, member teams, and standings.

Returns the list of child groups (e.g. divisions within a conference)
for one (NBA season x season-type x parent-group).

Returns the list of team IDs that belong to one group (conference or
division) for one (NBA season x season-type).

## Usage

``` r
espn_mbb_season_group(
  group_id,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_mbb_season_group_children(
  group_id,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_mbb_season_group_teams(
  group_id,
  season = most_recent_mbb_season(),
  season_type = 2L,
  ...
)

espn_nba_season_group(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)

espn_nba_season_group_children(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)

espn_nba_season_group_teams(
  group_id,
  season = most_recent_nba_season(),
  season_type = 2L,
  ...
)
```

## Arguments

- group_id:

  ESPN group identifier.

- season:

  Season year. Defaults to most recent MBB season.

- season_type:

  Season-type id (2 = regular (default)).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

Columns as documented in the shared
[espn_mbb_season_group_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_schema.md)
table.

A tibble with one row per child group.

Columns as documented in the shared
[espn_mbb_season_group_children_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children_schema.md)
table.

A tibble with one row per team in the group.

Columns as documented in the shared
[espn_mbb_season_group_teams_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams_schema.md)
table.

A single-row tibble.

Columns as documented in the shared
[espn_mbb_season_group_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_schema.md)
table.

A tibble with one row per child group.

Columns as documented in the shared
[espn_mbb_season_group_children_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_children_schema.md)
table.

A tibble with one row per team in the group.

Columns as documented in the shared
[espn_mbb_season_group_teams_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_season_group_teams_schema.md)
table.

## Details

**Get ESPN MBB Season Group Detail**

**Get ESPN MBB Season Group Children Index**

**Get ESPN MBB Season Group Teams Index**

**Get ESPN NBA Season Group Detail**

**Get ESPN NBA Season Group Children Index**

**Get ESPN NBA Season Group Teams Index**

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
  espn_mbb_season_group(group_id = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Group Detail ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 1 × 15
#>   league         season season_type group_id uid   name  abbreviation short_name
#>   <chr>           <int>       <int> <chr>    <chr> <chr> <chr>        <chr>     
#> 1 mens-college-…   2025           2 5        s:40… Big … bsky         Big Sky   
#> # ℹ 7 more variables: midsize_name <chr>, is_conference <lgl>, slug <chr>,
#> #   parent_ref <chr>, children_ref <chr>, teams_ref <chr>, standings_ref <chr>
# }
# \donttest{
  espn_mbb_season_group_children(group_id = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Group Children Index ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 0 × 6
#> # ℹ 6 variables: league <chr>, season <int>, season_type <int>,
#> #   parent_group_id <chr>, child_group_id <chr>, ref <chr>
# }
# \donttest{
  espn_mbb_season_group_teams(group_id = 5, season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Season Group Teams Index ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 10 × 6
#>    league                  season season_type group_id team_id ref              
#>    <chr>                    <int>       <int> <chr>    <chr>   <chr>            
#>  1 mens-college-basketball   2025           2 5        16      http://sports.co…
#>  2 mens-college-basketball   2025           2 5        70      http://sports.co…
#>  3 mens-college-basketball   2025           2 5        147     http://sports.co…
#>  4 mens-college-basketball   2025           2 5        149     http://sports.co…
#>  5 mens-college-basketball   2025           2 5        304     http://sports.co…
#>  6 mens-college-basketball   2025           2 5        331     http://sports.co…
#>  7 mens-college-basketball   2025           2 5        2458    http://sports.co…
#>  8 mens-college-basketball   2025           2 5        2464    http://sports.co…
#>  9 mens-college-basketball   2025           2 5        2502    http://sports.co…
#> 10 mens-college-basketball   2025           2 5        2692    http://sports.co…
# }
# \donttest{
  espn_nba_season_group(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Detail ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 1 × 15
#>   league season season_type group_id uid           name  abbreviation short_name
#>   <chr>   <int>       <int> <chr>    <chr>         <chr> <chr>        <chr>     
#> 1 nba      2025           2 5        s:40~l:46~g:5 East… East         NA        
#> # ℹ 7 more variables: midsize_name <chr>, is_conference <lgl>, slug <chr>,
#> #   parent_ref <chr>, children_ref <chr>, teams_ref <chr>, standings_ref <chr>
# }
# \donttest{
  espn_nba_season_group_children(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Children Index ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 3 × 6
#>   league season season_type parent_group_id child_group_id ref                  
#>   <chr>   <int>       <int> <chr>           <chr>          <chr>                
#> 1 nba      2025           2 5               1              http://sports.core.a…
#> 2 nba      2025           2 5               2              http://sports.core.a…
#> 3 nba      2025           2 5               9              http://sports.core.a…
# }
# \donttest{
  espn_nba_season_group_teams(group_id = 5, season = 2025)
#> ── ESPN NBA Season Group Teams Index ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:12 UTC
#> # A tibble: 15 × 6
#>    league season season_type group_id team_id ref                               
#>    <chr>   <int>       <int> <chr>    <chr>   <chr>                             
#>  1 nba      2025           2 5        1       http://sports.core.api.espn.com/v…
#>  2 nba      2025           2 5        2       http://sports.core.api.espn.com/v…
#>  3 nba      2025           2 5        4       http://sports.core.api.espn.com/v…
#>  4 nba      2025           2 5        5       http://sports.core.api.espn.com/v…
#>  5 nba      2025           2 5        8       http://sports.core.api.espn.com/v…
#>  6 nba      2025           2 5        11      http://sports.core.api.espn.com/v…
#>  7 nba      2025           2 5        14      http://sports.core.api.espn.com/v…
#>  8 nba      2025           2 5        15      http://sports.core.api.espn.com/v…
#>  9 nba      2025           2 5        17      http://sports.core.api.espn.com/v…
#> 10 nba      2025           2 5        18      http://sports.core.api.espn.com/v…
#> 11 nba      2025           2 5        19      http://sports.core.api.espn.com/v…
#> 12 nba      2025           2 5        20      http://sports.core.api.espn.com/v…
#> 13 nba      2025           2 5        27      http://sports.core.api.espn.com/v…
#> 14 nba      2025           2 5        28      http://sports.core.api.espn.com/v…
#> 15 nba      2025           2 5        30      http://sports.core.api.espn.com/v…
# }
```
