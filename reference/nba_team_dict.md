# **NBA Team Dictionary**

A tidy team dictionary (id, abbreviation, name, conference, division,
logo URL) derived from the stats.nba.com player index plus a static
conference/division map.

## Usage

``` r
nba_team_dict(season = year_to_season(most_recent_nba_season() - 1), ...)
```

## Arguments

- season:

  Season in `"YYYY-YY"` form. Defaults to the most recent completed
  season.

- ...:

  Additional arguments passed to
  [`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_playerindex.md)
  (e.g. `proxy`).

## Value

A `hoopR_data` tibble with one row per team:

|                   |           |                                     |
|-------------------|-----------|-------------------------------------|
| col_name          | types     | description                         |
| team_id           | character | Team id.                            |
| team_abbreviation | character | Team abbreviation.                  |
| team_city         | character | Team city / region.                 |
| team_name         | character | Team nickname.                      |
| team_full         | character | Full team name.                     |
| conference        | character | Conference (`Eastern` / `Western`). |
| division          | character | Division.                           |
| logo_url          | character | NBA CDN primary logo URL.           |

## See also

Other NBA Dictionary Functions:
[`nba_player_dict()`](https://hoopR.sportsdataverse.org/reference/nba_player_dict.md),
[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md),
[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)

## Examples

``` r
# \donttest{
  try(nba_team_dict())
#> ── NBA team dictionary from stats.nba.com ─────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 03:13:57 UTC
#> # A tibble: 30 × 8
#>    team_id   team_abbreviation team_city team_name team_full conference division
#>    <chr>     <chr>             <chr>     <chr>     <chr>     <chr>      <chr>   
#>  1 16106127… BOS               Boston    Celtics   Boston C… Eastern    Atlantic
#>  2 16106127… BKN               Brooklyn  Nets      Brooklyn… Eastern    Atlantic
#>  3 16106127… NYK               New York  Knicks    New York… Eastern    Atlantic
#>  4 16106127… PHI               Philadel… 76ers     Philadel… Eastern    Atlantic
#>  5 16106127… TOR               Toronto   Raptors   Toronto … Eastern    Atlantic
#>  6 16106127… CHI               Chicago   Bulls     Chicago … Eastern    Central 
#>  7 16106127… CLE               Cleveland Cavaliers Clevelan… Eastern    Central 
#>  8 16106127… DET               Detroit   Pistons   Detroit … Eastern    Central 
#>  9 16106127… IND               Indiana   Pacers    Indiana … Eastern    Central 
#> 10 16106127… MIL               Milwaukee Bucks     Milwauke… Eastern    Central 
#> # ℹ 20 more rows
#> # ℹ 1 more variable: logo_url <chr>
# }
```
