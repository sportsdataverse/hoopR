# **Get ESPN Women's College Basketball Team Detail**

Era-correct team identity for a men's college basketball program in a
specific season, plus the available `$ref` URLs for deeper resources
(record, statistics, leaders, athletes/roster, coaches, college, etc.).
Backed by the core-v2 endpoint
`sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/teams/{team_id}`.

Historical depth goes back to **1939** at ESPN. Older seasons return
fewer `$ref` keys; missing refs become `NA`.

Era-correct team identity for an NBA franchise in a specific season,
plus the available `$ref` URLs for deeper resources (record, statistics,
leaders, coaches, etc.). Backed by the core-v2 endpoint
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/teams/{team_id}`.

Historical depth goes back to **1947** (NBA founding). Older seasons
return fewer `$ref` keys; missing refs become `NA`.

## Usage

``` r
espn_mbb_team(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_roster(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_leaders(team_id, season = most_recent_mbb_season(), ...)

espn_mbb_team_season_profile(team_id, season = most_recent_mbb_season(), ...)

espn_nba_team(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_roster(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_leaders(team_id, season = most_recent_nba_season(), ...)

espn_nba_team_season_profile(team_id, season = most_recent_nba_season(), ...)
```

## Arguments

- team_id:

  ESPN team identifier (character or numeric).

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of data frames: `Info`, `Record`, `NextEvent`,
`StandingSummary`, `Coaches`.

**Info**

Columns as documented in the shared
[espn_mbb_team_info_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_info_schema.md)
table.

**Record**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| type     | character | Record type / category. |
| summary  | character |                         |
| stats    | list      |                         |

**NextEvent**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**StandingSummary**

|                  |           |             |
|------------------|-----------|-------------|
| col_name         | types     | description |
| standing_summary | character |             |

**Coaches**

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| id         | character | Id.                               |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| experience | integer   | Years of professional experience. |

A single tibble with one row per athlete.

Columns as documented in the shared
[espn_mbb_team_roster_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster_schema.md)
table. ESPN's roster endpoint ignores the season, so a season before the
current one is built from that season's published player box scores
(name, jersey, position and headshot from the athlete's last game; bio
columns `NA`), and errors when none are published.

A single long-format tibble (one row per category-rank-athlete).

Columns as documented in the shared
[espn_mbb_team_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders_schema.md)
table.

A single-row tibble with team identity scalars and `_ref` URL columns.
Selected columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN team identifier. |
| guid | character | Stable cross-league team GUID. |
| uid | character | ESPN UID string. |
| slug | character | URL-safe identifier. |
| location | character | School/program location (e.g. "Duke"). |
| name | character | Team name (e.g. "Blue Devils"). |
| nickname | character | Common nickname (often same as location). |
| abbreviation | character | Short abbreviation (e.g. "DUKE"). |
| display_name | character | Full display name. |
| short_display_name | character | Short display name. |
| color | character | Primary color (hex, no leading '#'). |
| alternate_color | character | Alternate color (hex, no leading '#'). |
| is_active | logical | Whether the team was active in this season. |
| season | integer | Season year. |
| logo | character | Primary logo URL. |
| logo_dark | character | Dark-mode logo URL. |
| record_ref | character | `$ref` to team record resource. |
| statistics_ref | character | `$ref` to team statistics resource. |
| athletes_ref | character | `$ref` to team roster resource (college-only). |
| college_ref | character | `$ref` to college (institution) resource. |
| coaches_ref | character | `$ref` to team coaches resource. |
| franchise_ref | character | `$ref` to franchise resource. |

A named list of data frames: `Info`, `Record`, `NextEvent`,
`StandingSummary`, `Coaches`.

**Info**

Columns as documented in the shared
[espn_mbb_team_info_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_info_schema.md)
table.

**Record**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| type     | character | Record type / category. |
| summary  | character |                         |
| stats    | list      |                         |

**NextEvent**

|            |           |                            |
|------------|-----------|----------------------------|
| col_name   | types     | description                |
| id         | character | Id.                        |
| date       | character | Date in YYYY-MM-DD format. |
| name       | character | Display name.              |
| short_name | character | Short display name.        |

**StandingSummary**

|                  |           |             |
|------------------|-----------|-------------|
| col_name         | types     | description |
| standing_summary | character |             |

**Coaches**

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| id         | character | Id.                               |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| experience | integer   | Years of professional experience. |

A single tibble with one row per athlete.

Columns as documented in the shared
[espn_mbb_team_roster_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_roster_schema.md)
table. ESPN's roster endpoint ignores the season, so a season before the
current one is built from that season's published player box scores
(name, jersey, position and headshot from the athlete's last game; bio
columns `NA`), and errors when none are published.

A single long-format tibble (one row per category-rank-athlete).

Columns as documented in the shared
[espn_mbb_team_leaders_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_leaders_schema.md)
table.

A single-row tibble with team identity scalars and `_ref` URL columns.
Selected columns:

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN team identifier. |
| guid | character | Stable cross-league team GUID. |
| uid | character | ESPN UID string. |
| slug | character | URL-safe identifier. |
| location | character | Team city/region (e.g. "Los Angeles"). |
| name | character | Team name (e.g. "Lakers"). |
| abbreviation | character | Short abbreviation (e.g. "LAL"). |
| display_name | character | Full display name. |
| short_display_name | character | Short display name. |
| color | character | Primary color (hex, no leading '#'). |
| alternate_color | character | Alternate color (hex, no leading '#'). |
| is_active | logical | Whether the team was active in this season. |
| season | integer | Season year. |
| logo | character | Primary logo URL. |
| logo_dark | character | Dark-mode logo URL. |
| record_ref | character | `$ref` to team record resource (if present). |
| statistics_ref | character | `$ref` to team statistics resource (if present). |
| leaders_ref | character | `$ref` to team leaders resource (if present). |
| coaches_ref | character | `$ref` to team coaches resource (if present). |
| depth_charts_ref | character | `$ref` to depth chart resource (NBA-only). |
| events_ref | character | `$ref` to team events resource (if present). |
| transactions_ref | character | `$ref` to team transactions resource (if present). |
| franchise_ref | character | `$ref` to franchise resource. |

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
  espn_mbb_team(team_id = "150", season = 2025)
#> $Info
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Info from ESPN.com ───────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:45 UTC
#> # A tibble: 1 × 13
#>   id    uid    slug  abbreviation display_name short_display_name name  nickname
#>   <chr> <chr>  <chr> <chr>        <chr>        <chr>              <chr> <chr>   
#> 1 150   s:40~… duke… DUKE         Duke Blue D… Duke               Blue… Duke    
#> # ℹ 5 more variables: location <chr>, color <chr>, alternate_color <chr>,
#> #   logo <chr>, logo_dark <chr>
#> 
#> $Record
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Record from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:45 UTC
#> # A tibble: 1 × 4
#>   description    stats         summary type 
#>   <chr>          <list>        <chr>   <chr>
#> 1 Overall Record <df [30 × 2]> 31-3    total
#> 
#> $NextEvent
#> data frame with 0 columns and 0 rows
#> 
#> $StandingSummary
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Standing Summary from ESPN.com ────────────
#> ℹ Data updated: 2026-11-09 17:04:45 UTC
#> # A tibble: 1 × 1
#>   standing_summary
#>   <chr>           
#> 1 1st in ACC      
#> 
#> $Coaches
#> data frame with 0 columns and 0 rows
#> 
# }
# \donttest{
  espn_mbb_team_roster(team_id = "150", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Roster from ESPN.com player box scores ────
#> ℹ Data updated: 2026-11-09 17:04:48 UTC
#> # A tibble: 15 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 4431753    Mason Gi… 18     F               Forward       NA     NA     NA   
#>  2 4431890    Neal Beg… 20     F               Forward       NA     NA     NA   
#>  3 4432321    Cameron … 13     G               Guard         NA     NA     NA   
#>  4 4602025    Sion Jam… 14     G               Guard         NA     NA     NA   
#>  5 4711256    Caleb Fo… 1      G               Guard         NA     NA     NA   
#>  6 4873107    Darren H… 8      G               Guard         NA     NA     NA   
#>  7 4873209    Patrick … 21     C               Center        NA     NA     NA   
#>  8 4897107    Stanley … 52     C               Center        NA     NA     NA   
#>  9 4897108    Spencer … 55     G               Guard         NA     NA     NA   
#> 10 5023693    Tyrese P… 5      G               Guard         NA     NA     NA   
#> 11 5041939    Cooper F… 2      F               Forward       NA     NA     NA   
#> 12 5061575    Kon Knue… 7      G               Guard         NA     NA     NA   
#> 13 5061585    Isaiah E… 3      G               Guard         NA     NA     NA   
#> 14 5105337    Maliq Br… 6      F               Forward       NA     NA     NA   
#> 15 5203685    Khaman M… 9      C               Center        NA     NA     NA   
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
# }
# \donttest{
  espn_mbb_team_leaders(team_id = "150", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_mbb_team_season_profile(team_id = "150", season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Team Season Profile from ESPN.com ──────────────
#> ℹ Data updated: 2026-11-09 17:04:48 UTC
#> # A tibble: 1 × 35
#>   id    guid       uid   slug  location name  nickname abbreviation display_name
#>   <chr> <chr>      <chr> <chr> <chr>    <chr> <chr>    <chr>        <chr>       
#> 1 150   c4430c6c-… s:40… duke… Duke     Blue… Duke     DUKE         Duke Blue D…
#> # ℹ 26 more variables: short_display_name <chr>, color <chr>,
#> #   alternate_color <chr>, is_active <lgl>, is_all_star <lgl>, season <int>,
#> #   logo <chr>, logo_dark <chr>, record_ref <chr>, venue_ref <chr>,
#> #   groups_ref <chr>, ranks_ref <chr>, statistics_ref <chr>, leaders_ref <chr>,
#> #   injuries_ref <chr>, notes_ref <chr>, against_the_spread_records_ref <chr>,
#> #   awards_ref <chr>, franchise_ref <chr>, depth_charts_ref <chr>,
#> #   events_ref <chr>, transactions_ref <chr>, coaches_ref <chr>, …
# }
# \donttest{
  espn_nba_team(team_id = "13", season = 2025)
#> $Info
#> ── ESPN NBA Team Info from ESPN.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:49 UTC
#> # A tibble: 1 × 12
#>   id    uid    slug  abbreviation display_name short_display_name name  location
#>   <chr> <chr>  <chr> <chr>        <chr>        <chr>              <chr> <chr>   
#> 1 13    s:40~… los-… LAL          Los Angeles… Lakers             Lake… Los Ang…
#> # ℹ 4 more variables: color <chr>, alternate_color <chr>, logo <chr>,
#> #   logo_dark <chr>
#> 
#> $Record
#> ── ESPN NBA Team Record from ESPN.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:49 UTC
#> # A tibble: 3 × 4
#>   description    stats         summary type 
#>   <chr>          <list>        <chr>   <chr>
#> 1 Overall Record <df [20 × 2]> 50-32   total
#> 2 Home Record    <df [5 × 2]>  31-10   home 
#> 3 Away Record    <df [5 × 2]>  19-22   road 
#> 
#> $NextEvent
#> data frame with 0 columns and 0 rows
#> 
#> $StandingSummary
#> ── ESPN NBA Team Standing Summary from ESPN.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:49 UTC
#> # A tibble: 1 × 1
#>   standing_summary       
#>   <chr>                  
#> 1 1st in Pacific Division
#> 
#> $Coaches
#> data frame with 0 columns and 0 rows
#> 
# }
# \donttest{
  espn_nba_team_roster(team_id = "13", season = 2025)
#> ── ESPN NBA Team Roster from ESPN.com player box scores ───────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:49 UTC
#> # A tibble: 26 × 15
#>    athlete_id full_name jersey position_abbrev position_name height weight age  
#>    <chr>      <chr>     <chr>  <chr>           <chr>         <chr>  <chr>  <chr>
#>  1 1966       LeBron J… 23     F               Forward       NA     NA     NA   
#>  2 6461       Markieff… 88     PF              Power Forward NA     NA     NA   
#>  3 6583       Anthony … 3      F               Forward       NA     NA     NA   
#>  4 2578185    Dorian F… 17     F               Forward       NA     NA     NA   
#>  5 2596107    Alex Len  27     C               Center        NA     NA     NA   
#>  6 2960236    Maxi Kle… 14     F               Forward       NA     NA     NA   
#>  7 3058254    Christia… 35     F               Forward       NA     NA     NA   
#>  8 3136776    D'Angelo… 1      G               Guard         NA     NA     NA   
#>  9 3137259    Gabe Vin… 7      G               Guard         NA     NA     NA   
#> 10 3915195    Shake Mi… 20     SG              Shooting Gua… NA     NA     NA   
#> # ℹ 16 more rows
#> # ℹ 7 more variables: birth_date <chr>, birth_place <chr>, headshot <chr>,
#> #   link_web <chr>, status <chr>, team_id <chr>, season <int>
# }
# \donttest{
  espn_nba_team_leaders(team_id = "13", season = 2025)
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_team_season_profile(team_id = "13", season = 2025)
#> ── ESPN NBA Team Season Profile from ESPN.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:04:50 UTC
#> # A tibble: 1 × 35
#>   id    guid       uid   slug  location name  nickname abbreviation display_name
#>   <chr> <chr>      <chr> <chr> <chr>    <chr> <lgl>    <chr>        <chr>       
#> 1 13    2876e98b-… s:40… los-… Los Ang… Lake… NA       LAL          Los Angeles…
#> # ℹ 26 more variables: short_display_name <chr>, color <chr>,
#> #   alternate_color <chr>, is_active <lgl>, is_all_star <lgl>, season <int>,
#> #   logo <chr>, logo_dark <chr>, record_ref <chr>, venue_ref <chr>,
#> #   groups_ref <chr>, ranks_ref <chr>, statistics_ref <chr>, leaders_ref <chr>,
#> #   injuries_ref <chr>, notes_ref <chr>, against_the_spread_records_ref <chr>,
#> #   awards_ref <chr>, franchise_ref <chr>, depth_charts_ref <chr>,
#> #   events_ref <chr>, transactions_ref <chr>, coaches_ref <chr>, …
# }
```
