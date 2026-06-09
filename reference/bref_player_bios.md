# **Basketball-Reference Player Bios / Index**

**Get the Basketball-Reference player index for a starting letter, with
bios, from
[Basketball-Reference](https://www.basketball-reference.com).**

Returns every player whose last name begins with `letter`, with career
span, position, listed height/weight, birth date, college(s) and the
player's Basketball-Reference id slug (the key used by
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md)
and the other player-level `bref_*()` functions). This doubles as a
Basketball-Reference **player dictionary**. No API key is required.
Basketball-Reference rate-limits aggressive scraping (~20
requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_player_bios(letter = "a")
```

## Arguments

- letter:

  (*character* required): Single letter `a`-`z` (last-name initial).
  Defaults to `"a"`.

## Value

A `hoopR_data` tibble with one row per player:

|            |           |                                                   |
|------------|-----------|---------------------------------------------------|
| col_name   | types     | description                                       |
| player     | character | Player name.                                      |
| player_id  | character | Basketball-Reference id slug (e.g. `jamesle01`).  |
| year_min   | integer   | First season played.                              |
| year_max   | integer   | Last season played.                               |
| pos        | character | Position(s).                                      |
| height     | character | Listed height (e.g. `6-9`).                       |
| weight     | integer   | Listed weight (lbs).                              |
| birth_date | character | Birth date.                                       |
| colleges   | character | College(s).                                       |
| letter     | character | Last-name initial (echoes the `letter` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_player_bios(letter = "a"))
#> ── Player bios from basketball-reference.com ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 21:19:14 UTC
#> # A tibble: 179 × 10
#>    player    player_id year_min year_max pos   height weight birth_date colleges
#>    <chr>     <chr>        <dbl>    <dbl> <chr> <chr>   <dbl> <chr>      <chr>   
#>  1 Alaa Abd… abdelal01     1991     1995 F-C   6-10      240 June 24, … "Duke"  
#>  2 Zaid Abd… abdulza01     1969     1978 C-F   6-9       235 April 7, … "Iowa S…
#>  3 Kareem A… abdulka01     1970     1989 C     7-2       225 April 16,… "UCLA"  
#>  4 Mahmoud … abdulma02     1991     2001 G     6-1       162 March 9, … "LSU"   
#>  5 Tariq Ab… abdulta01     1998     2003 F     6-6       223 November … "Michig…
#>  6 Shareef … abdursh01     1997     2008 F     6-9       225 December … "Califo…
#>  7 Tom Aber… abernto01     1977     1981 F     6-7       220 May 6, 19… "Indian…
#>  8 Forest A… ablefo01      1957     1957 G     6-3       180 July 27, … "Wester…
#>  9 John Abr… abramjo01     1947     1948 F     6-3       195 February … "Salem …
#> 10 Álex Abr… abrinal01     2017     2019 G-F   6-6       200 August 1,… ""      
#> # ℹ 169 more rows
#> # ℹ 1 more variable: letter <chr>
# }
```
