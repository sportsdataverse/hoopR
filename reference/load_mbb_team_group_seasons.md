# **Load team conference membership by season (MBB / NBA) from the data repo**

Loads one row per team per season with the team's subdivision,
conference, and division that season, taken from the most reliable
per-season source and cross-checked against a second source where one
exists. Membership is never back-filled from today's alignment.
`load_mbb_team_group_seasons()` reads the `mbb_groups` release tag and
`load_nba_team_group_seasons()` the `nba_groups` tag.

## Usage

``` r
load_mbb_team_group_seasons(
  seasons = most_recent_mbb_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)

load_nba_team_group_seasons(
  seasons = most_recent_nba_season(),
  ...,
  dbConnection = NULL,
  tablename = NULL
)
```

## Arguments

- seasons:

  A vector of 4-digit season-ending years (2025 = 2024-25). Published
  coverage runs from 2002 (MBB) or 1971 (NBA) through the most recent
  season. Pass `seasons = TRUE` to read every published season from one
  file. (Min: 2002 for MBB, 1971 for NBA)

- ...:

  Additional arguments passed to an underlying function that writes the
  data into a database.

- dbConnection:

  A `DBIConnection` object, as returned by
  [`DBI::dbConnect()`](https://dbi.r-dbi.org/reference/dbConnect.html)

- tablename:

  The name of the data table within the database

## Value

Returns a `hoopR_data` tibble with one row per team-season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| league | character | League key: `mbb` or `nba`. |
| season | integer | Season (ending year; 2025 = 2024-25). |
| team_id | character | ESPN team id. |
| team_id_source | character | Id system of `team_id`: `espn`. |
| team_name | character | Team name as of that season. |
| subdivision_id | character | SDV group id of the subdivision (`mbb:d1`); `NA` for the NBA. |
| conference_id | character | SDV group id of the conference. |
| division_id | character | SDV group id of the division; `NA` where the league or conference had none. |
| source | character | Source the membership came from: `espn_standings`, `espn_core_groups` or `kenpom` (MBB); `nba_stats` or `curated` (NBA). |
| sources_agree | logical | Whether a second source agrees; `NA` when only one source covers the season. |
| notes | character | Membership caveats. |

## See also

Other Conference and Division Group loader functions:
[`load_mbb_group_aliases()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_aliases.md),
[`load_mbb_group_seasons()`](https://hoopR.sportsdataverse.org/reference/load_mbb_group_seasons.md),
[`load_mbb_groups()`](https://hoopR.sportsdataverse.org/reference/load_mbb_groups.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(load_mbb_team_group_seasons(seasons = most_recent_mbb_season()))
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 365 × 11
#>    league season team_id team_id_source team_name   subdivision_id conference_id
#>    <chr>   <int> <chr>   <chr>          <chr>       <chr>          <chr>        
#>  1 mbb      2027 103     espn           Boston Col… mbb:d1         mbb:acc      
#>  2 mbb      2027 104     espn           Boston Uni… mbb:d1         mbb:patriot  
#>  3 mbb      2027 107     espn           Holy Cross… mbb:d1         mbb:patriot  
#>  4 mbb      2027 108     espn           Harvard Cr… mbb:d1         mbb:ivy      
#>  5 mbb      2027 111     espn           Northeaste… mbb:d1         mbb:caa      
#>  6 mbb      2027 112358  espn           Long Islan… mbb:d1         mbb:nec      
#>  7 mbb      2027 113     espn           Massachuse… mbb:d1         mbb:mac      
#>  8 mbb      2027 116     espn           Mount St. … mbb:d1         mbb:maac     
#>  9 mbb      2027 119     espn           Towson Tig… mbb:d1         mbb:caa      
#> 10 mbb      2027 12      espn           Arizona Wi… mbb:d1         mbb:big-12   
#> # ℹ 355 more rows
#> # ℹ 4 more variables: division_id <chr>, source <chr>, sources_agree <lgl>,
#> #   notes <chr>
# }
# \donttest{
  try(load_nba_team_group_seasons(seasons = most_recent_nba_season()))
#> ──────────────────────────────────────────────────────────── hoopR 3.1.0.9000 ──
#> # A tibble: 30 × 11
#>    league season team_id team_id_source team_name   subdivision_id conference_id
#>    <chr>   <int> <chr>   <chr>          <chr>       <chr>          <chr>        
#>  1 nba      2027 1       espn           Atlanta Ha… NA             nba:east     
#>  2 nba      2027 10      espn           Houston Ro… NA             nba:west     
#>  3 nba      2027 11      espn           Indiana Pa… NA             nba:east     
#>  4 nba      2027 12      espn           LA Clippers NA             nba:west     
#>  5 nba      2027 13      espn           Los Angele… NA             nba:west     
#>  6 nba      2027 14      espn           Miami Heat  NA             nba:east     
#>  7 nba      2027 15      espn           Milwaukee … NA             nba:east     
#>  8 nba      2027 16      espn           Minnesota … NA             nba:west     
#>  9 nba      2027 17      espn           Brooklyn N… NA             nba:east     
#> 10 nba      2027 18      espn           New York K… NA             nba:east     
#> # ℹ 20 more rows
#> # ℹ 4 more variables: division_id <chr>, source <chr>, sources_agree <lgl>,
#> #   notes <chr>
# }
```
