# **Get ESPN Women's College Basketball Athlete Info**

**Get ESPN Women's College Basketball Athlete Info**

**Get ESPN Women's College Basketball Athlete Info**

**Get ESPN NBA Athlete Info**

**Get ESPN NBA Athlete Info**

## Usage

``` r
espn_mbb_player_info(athlete_id, ...)

espn_nba_player_info(athlete_id, ...)
```

## Arguments

- athlete_id:

  ESPN athlete identifier (character or numeric).

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A named list of `hoopR_data` tibbles: `Bio`, `Team`, `Position`,
`Status`, `College`, `Draft`.

**Bio**

|               |           |                                   |
|---------------|-----------|-----------------------------------|
| col_name      | types     | description                       |
| id            | character | Id.                               |
| full_name     | character | Player's full name.               |
| display_name  | character | Display name.                     |
| jersey        | character | Jersey number worn by the player. |
| age           | character | Player age (in years).            |
| date_of_birth | character | Date of birth (YYYY-MM-DD).       |
| headshot_href | character | Headshot image URL.               |

**Team**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| abbreviation | character | Short abbreviation. |
| display_name | character | Display name.       |

**Position**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| name         | character | Display name.       |
| abbreviation | character | Short abbreviation. |

**Status**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| id       | character | Id.                     |
| name     | character | Display name.           |
| type     | character | Record type / category. |

**College**

|          |           |               |
|----------|-----------|---------------|
| col_name | types     | description   |
| id       | character | Id.           |
| name     | character | Display name. |
| mascot   | character | Team mascot.  |

**Draft**

|           |           |                             |
|-----------|-----------|-----------------------------|
| col_name  | types     | description                 |
| year      | character | 4-digit year.               |
| round     | character | Tournament / playoff round. |
| selection | character |                             |

A named list of `hoopR_data` tibbles: `Bio`, `Team`, `Position`,
`Status`, `College`, `Draft`.

**Bio**

|               |           |                                   |
|---------------|-----------|-----------------------------------|
| col_name      | types     | description                       |
| id            | character | Id.                               |
| full_name     | character | Player's full name.               |
| display_name  | character | Display name.                     |
| jersey        | character | Jersey number worn by the player. |
| age           | character | Player age (in years).            |
| date_of_birth | character | Date of birth (YYYY-MM-DD).       |
| headshot_href | character | Headshot image URL.               |

**Team**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| abbreviation | character | Short abbreviation. |
| display_name | character | Display name.       |

**Position**

|              |           |                     |
|--------------|-----------|---------------------|
| col_name     | types     | description         |
| id           | character | Id.                 |
| name         | character | Display name.       |
| abbreviation | character | Short abbreviation. |

**Status**

|          |           |                         |
|----------|-----------|-------------------------|
| col_name | types     | description             |
| id       | character | Id.                     |
| name     | character | Display name.           |
| type     | character | Record type / category. |

**College**

|          |           |               |
|----------|-----------|---------------|
| col_name | types     | description   |
| id       | character | Id.           |
| name     | character | Display name. |
| mascot   | character | Team mascot.  |

**Draft**

|           |           |                             |
|-----------|-----------|-----------------------------|
| col_name  | types     | description                 |
| year      | character | 4-digit year.               |
| round     | character | Tournament / playoff round. |
| selection | character |                             |

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
  espn_mbb_player_info(athlete_id = "4593919")
#> $Bio
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Bio from ESPN.com ─────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 18
#>   id      uid       guid  first_name last_name full_name display_name short_name
#>   <chr>   <chr>     <chr> <chr>      <chr>     <chr>     <chr>        <chr>     
#> 1 4593919 s:40~l:4… 5ec0… Nicolas    Elame     Nicolas … Nicolas Ela… N. Elame  
#> # ℹ 10 more variables: weight <dbl>, display_weight <chr>, height <dbl>,
#> #   display_height <chr>, jersey <chr>, active <lgl>, headshot_href <chr>,
#> #   birth_city <chr>, birth_state <chr>, birth_country <chr>
#> 
#> $Team
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Team from ESPN.com ────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 1
#>   x_ref                                                                         
#>   <chr>                                                                         
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-bas…
#> 
#> $Position
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Position from ESPN.com ── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 5
#>   id    name  display_name abbreviation leaf 
#>   <chr> <chr> <chr>        <chr>        <lgl>
#> 1 3     Guard Guard        G            FALSE
#> 
#> $Status
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Status from ESPN.com ──── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 4
#>   id    name     type     abbreviation
#>   <chr> <chr>    <chr>    <chr>       
#> 1 2     Inactive inactive Inactive    
#> 
#> $College
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete College from ESPN.com ─── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Draft
#> ── ESPN MENS-COLLEGE-BASKETBALL Athlete Draft from ESPN.com ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 0 × 0
#> 
# }
# \donttest{
  espn_nba_player_info(athlete_id = "1966")
#> $Bio
#> ── ESPN NBA Athlete Bio from ESPN.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 21
#>   id    uid         guid  first_name last_name full_name display_name short_name
#>   <chr> <chr>       <chr> <chr>      <chr>     <chr>     <chr>        <chr>     
#> 1 1966  s:40~l:46~… 1f65… LeBron     James     LeBron J… LeBron James L. James  
#> # ℹ 13 more variables: weight <dbl>, display_weight <chr>, height <dbl>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>, debut_year <int>,
#> #   jersey <chr>, active <lgl>, headshot_href <chr>, birth_city <chr>,
#> #   birth_state <chr>, birth_country <chr>
#> 
#> $Team
#> ── ESPN NBA Athlete Team from ESPN.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 1
#>   x_ref                                                                         
#>   <chr>                                                                         
#> 1 http://sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/2027…
#> 
#> $Position
#> ── ESPN NBA Athlete Position from ESPN.com ────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 5
#>   id    name    display_name abbreviation leaf 
#>   <chr> <chr>   <chr>        <chr>        <lgl>
#> 1 7     Forward Forward      F            FALSE
#> 
#> $Status
#> ── ESPN NBA Athlete Status from ESPN.com ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 4
#>   id    name   type   abbreviation
#>   <chr> <chr>  <chr>  <chr>       
#> 1 1     Active active Active      
#> 
#> $College
#> ── ESPN NBA Athlete College from ESPN.com ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 0 × 0
#> 
#> $Draft
#> ── ESPN NBA Athlete Draft from ESPN.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:34 UTC
#> # A tibble: 1 × 4
#>   year  round selection display_text               
#>   <chr> <chr> <chr>     <chr>                      
#> 1 2003  1     1         Year: 2003 Round: 1 Pick: 1
#> 
# }
```
