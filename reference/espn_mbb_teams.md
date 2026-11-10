# **Get ESPN men's college basketball team names and IDs**

**Get ESPN men's college basketball team names and IDs**

**Get ESPN NBA team names and IDs**

## Usage

``` r
espn_mbb_teams(year = most_recent_mbb_season())

espn_nba_teams()
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A `hoopR_data` tibble with one row per team.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| abbreviation | character | Short abbreviation. |
| display_name | character | Display name. |
| short_name | character | Short display name. |
| mascot | character | Team mascot. |
| nickname | character | Team or athlete nickname. |
| team | character | Team-side label or team identifier. |
| color | character | Primary color (hex without leading '#'). |
| alternate_color | character | Alternate color (hex without leading '#'). |
| logo | character | Team or league logo URL. |
| logo_dark | character | Logo dark. |
| href | character | Link / page URL. |
| conference_url | character | URL for conference. |
| group_id | integer | Group identifier (e.g. conference group_id). |
| conference_short_name | character | Conference short name (e.g. 'ACC'). |
| conference_uid | character | ESPN universal conference identifier. |
| conference_name | character | Full conference name. |
| conference_logo | character | Logo image URL for conference. |
| parent_group_id | integer | Unique identifier for parent group. |
| conference_id | integer | Conference identifier. |

A `hoopR_data` tibble with one row per team.

|                 |           |                                            |
|-----------------|-----------|--------------------------------------------|
| col_name        | types     | description                                |
| team_id         | integer   | Unique team identifier.                    |
| abbreviation    | character | Short abbreviation.                        |
| display_name    | character | Display name.                              |
| short_name      | character | Short display name.                        |
| mascot          | character | Team mascot.                               |
| nickname        | character | Team or athlete nickname.                  |
| team            | character | Team-side label or team identifier.        |
| color           | character | Primary color (hex without leading '#').   |
| alternate_color | character | Alternate color (hex without leading '#'). |
| logo            | character | Team or league logo URL.                   |
| logo_dark       | character | Logo dark.                                 |
| logos_href_3    | character | Logos href 3.                              |
| logos_href_4    | character | Logos href 4.                              |

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
# Interactive only: ESPN's directory of about 360 teams takes ~7 s.
try(espn_mbb_teams())
#> ── ESPN MBB Teams Information from ESPN.com ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:00:59 UTC
#> # A tibble: 365 × 32
#>    abbreviation alternate_color color display_name team_id team  logo  logo_dark
#>    <chr>        <chr>           <chr> <chr>          <int> <chr> <chr> <chr>    
#>  1 ACU          b1b3b3          592d… Abilene Chr…    2000 Abil… http… https://…
#>  2 AF           ffffff          0035… Air Force F…    2005 Air … http… https://…
#>  3 AKR          c5b783          041e… Akron Zips      2006 Akron http… https://…
#>  4 AAMU         ffffff          7900… Alabama A&M…    2010 Alab… http… https://…
#>  5 ALA          ffffff          9e1b… Alabama Cri…     333 Alab… http… https://…
#>  6 ALST         0a0a0a          e9a9… Alabama Sta…    2011 Alab… http… https://…
#>  7 ALCN         46166a          4b00… Alcorn Stat…    2016 Alco… http… https://…
#>  8 AMER         c8102e          c411… American Un…      44 Amer… http… https://…
#>  9 APP          ffcd00          0000… App State M…    2026 App … http… https://…
#> 10 ASU          8c1d40          ffc6… Arizona Sta…       9 Ariz… http… https://…
#> # ℹ 355 more rows
#> # ℹ 24 more variables: logos_href_3 <chr>, logos_href_4 <chr>,
#> #   logos_href_5 <chr>, logos_href_6 <chr>, logos_href_7 <chr>,
#> #   logos_href_8 <chr>, logos_href_9 <chr>, logos_href_10 <chr>,
#> #   logos_href_11 <chr>, logos_href_12 <chr>, logos_href_13 <chr>,
#> #   logos_href_14 <chr>, mascot <chr>, nickname <chr>, short_name <chr>,
#> #   href <chr>, conference_url <chr>, group_id <int>, conference_name <chr>, …
# }
# \donttest{
try(espn_nba_teams())
#> ── ESPN NBA Teams Information from ESPN.com ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:01:00 UTC
#> # A tibble: 30 × 25
#>    abbreviation alternate_color color display_name team_id team  logo  logo_dark
#>    <chr>        <chr>           <chr> <chr>          <int> <chr> <chr> <chr>    
#>  1 ATL          fdb927          c810… Atlanta Haw…       1 Atla… http… https://…
#>  2 BOS          ffffff          0083… Boston Celt…       2 Bost… http… https://…
#>  3 BKN          ffffff          0000… Brooklyn Ne…      17 Broo… http… https://…
#>  4 CHA          1d1060          008c… Charlotte H…      30 Char… http… https://…
#>  5 CHI          000000          ce11… Chicago Bul…       4 Chic… http… https://…
#>  6 CLE          bc945c          8600… Cleveland C…       5 Clev… http… https://…
#>  7 DAL          bbc4ca          0064… Dallas Mave…       6 Dall… http… https://…
#>  8 DEN          fec524          0e22… Denver Nugg…       7 Denv… http… https://…
#>  9 DET          c8102e          1d42… Detroit Pis…       8 Detr… http… https://…
#> 10 GS           1d428a          fdb9… Golden Stat…       9 Gold… http… https://…
#> # ℹ 20 more rows
#> # ℹ 17 more variables: logos_href_3 <chr>, logos_href_4 <chr>,
#> #   logos_href_5 <chr>, logos_href_6 <chr>, logos_href_7 <chr>,
#> #   logos_href_8 <chr>, logos_href_9 <chr>, logos_href_10 <chr>,
#> #   logos_href_11 <chr>, logos_href_12 <chr>, logos_href_13 <chr>,
#> #   logos_href_14 <chr>, logos_href_15 <chr>, logos_href_16 <chr>,
#> #   mascot <chr>, nickname <chr>, short_name <chr>
# }
```
