# **Basketball-Reference Team Roster**

**Get a team's season roster from
[Basketball-Reference](https://www.basketball-reference.com).**

No API key is required. Basketball-Reference rate-limits aggressive
scraping (~20 requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_team_roster(team, season = most_recent_nba_season())
```

## Arguments

- team:

  (*character* required): Basketball-Reference team abbreviation (e.g.
  `BOS`, `LAL`, `GSW`). Historical franchises use their era code (e.g.
  `NJN`, `SEA`).

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per player on the roster:

|                  |           |                                                 |
|------------------|-----------|-------------------------------------------------|
| col_name         | types     | description                                     |
| number           | character | Jersey number.                                  |
| player           | character | Player name.                                    |
| pos              | character | Position.                                       |
| height           | character | Height.                                         |
| weight           | integer   | Weight (lbs).                                   |
| birth_date       | character | Birth date.                                     |
| years_experience | character | Years of NBA experience (`R` for rookies).      |
| college          | character | College.                                        |
| team             | character | Team abbreviation (echoes the `team` argument). |
| season           | integer   | Season (echoes the `season` argument).          |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_team_roster(team = "BOS", season = 2024))
#> ── Team roster from basketball-reference.com ──────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 16:51:43 UTC
#> # A tibble: 19 × 11
#>    number player   pos   height weight birth_date flag  years_experience college
#>     <dbl> <chr>    <chr> <chr>   <dbl> <chr>      <chr> <chr>            <chr>  
#>  1     45 Dalano … PG    6-8       203 November … ca CA 2                "Nebra…
#>  2     12 Oshae B… SF    6-7       210 June 20, … ca CA 4                "Syrac…
#>  3      7 Jaylen … SF    6-6       223 October 2… us US 7                "Calif…
#>  4     20 JD Davi… SG    6-1       195 October 3… us US 1                "Alaba…
#>  5     30 Sam Hau… SF    6-7       217 December … us US 2                "Marqu…
#>  6      4 Jrue Ho… PG    6-4       220 June 12, … us US 14               "UCLA" 
#>  7     42 Al Horf… C     6-8       240 June 3, 1… do DO 16               "Flori…
#>  8     40 Luke Ko… C     7-1       250 July 15, … us US 6                "Vande…
#>  9     50 Svi Myk… SF    6-7       205 June 10, … ua UA 5                "Kansa…
#> 10     13 Drew Pe… PF    6-8       205 November … us US R                "Rice …
#> 11      8 Kristap… C     7-2       240 August 2,… lv LV 7                ""     
#> 12     11 Payton … PG    6-1       195 January 2… us US 3                "Orego…
#> 13     88 Neemias… C     7-0       248 July 13, … pt PT 2                "Utah …
#> 14     44 Jaden S… SG    6-4       202 September… us US 2                "Tenne…
#> 15     77 Lamar S… PF    6-7       230 July 9, 1… us US 3                "Penn …
#> 16      0 Jayson … PF    6-8       210 March 3, … us US 6                "Duke" 
#> 17     26 Xavier … PF    6-8       245 January 1… us US 3                "Michi…
#> 18     27 Jordan … SF    6-6       205 March 3, … us US R                "Arkan…
#> 19      9 Derrick… SG    6-4       190 July 2, 1… us US 6                "Color…
#> # ℹ 2 more variables: team <chr>, season <int>
# }
```
