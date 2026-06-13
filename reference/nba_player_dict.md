# **NBA Player Dictionary**

A tidy player dictionary (id, name, team, bio, headshot URL) sourced
from the stats.nba.com player index. Handy for joining player ids to
names/teams and for fetching headshots.

## Usage

``` r
nba_player_dict(season = year_to_season(most_recent_nba_season() - 1), ...)
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

A `hoopR_data` tibble with one row per player:

|                   |           |                                        |
|-------------------|-----------|----------------------------------------|
| col_name          | types     | description                            |
| player_id         | character | Player id (`PERSON_ID`).               |
| player_name       | character | Full name.                             |
| player_slug       | character | URL-safe player slug.                  |
| team_id           | character | Team id.                               |
| team_abbreviation | character | Team abbreviation.                     |
| team_name         | character | Full team name.                        |
| position          | character | Listed position.                       |
| jersey_number     | character | Jersey number.                         |
| height            | character | Listed height.                         |
| weight            | character | Listed weight.                         |
| country           | character | Country.                               |
| draft_year        | character | Draft year.                            |
| from_year         | character | First season.                          |
| to_year           | character | Most recent season.                    |
| headshot_url      | character | NBA CDN headshot URL.                  |
| season            | character | Season (echoes the `season` argument). |

## See also

Other NBA Dictionary Functions:
[`nba_player_headshot_url()`](https://hoopR.sportsdataverse.org/reference/nba_player_headshot_url.md),
[`nba_team_dict()`](https://hoopR.sportsdataverse.org/reference/nba_team_dict.md),
[`nba_team_logo_url()`](https://hoopR.sportsdataverse.org/reference/nba_team_logo_url.md)

## Examples

``` r
# \donttest{
  try(nba_player_dict())
#> ── NBA player dictionary from stats.nba.com ───────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:29:00 UTC
#> # A tibble: 5,126 × 16
#>    player_id player_name         player_slug team_id team_abbreviation team_name
#>    <chr>     <chr>               <chr>       <chr>   <chr>             <chr>    
#>  1 76001     Alaa Abdelnaby      alaa-abdel… 161061… POR               Portland…
#>  2 76002     Zaid Abdul-Aziz     zaid-abdul… 161061… HOU               Houston …
#>  3 76003     Kareem Abdul-Jabbar kareem-abd… 161061… LAL               Los Ange…
#>  4 51        Mahmoud Abdul-Rauf  mahmoud-ab… 161061… DEN               Denver N…
#>  5 1505      Tariq Abdul-Wahad   tariq-abdu… 161061… SAC               Sacramen…
#>  6 949       Shareef Abdur-Rahim shareef-ab… 161061… MEM               Memphis …
#>  7 76005     Tom Abernethy       tom-aberne… 161061… GSW               Golden S…
#>  8 76006     Forest Able         forest-able 161061… PHI               Philadel…
#>  9 76007     John Abramovic      john-abram… 161061… PIT               Pittsbur…
#> 10 203518    Alex Abrines        alex-abrin… 161061… OKC               Oklahoma…
#> # ℹ 5,116 more rows
#> # ℹ 10 more variables: position <chr>, jersey_number <chr>, height <chr>,
#> #   weight <chr>, country <chr>, draft_year <chr>, from_year <chr>,
#> #   to_year <chr>, headshot_url <chr>, season <chr>
# }
```
