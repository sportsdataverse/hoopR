# **Get VTB Infobasket Playoff Games**

The games of every series of a playoff stage.

Endpoint: `GET https://org.infobasket.su/Widget/PlayOff/{comp_id}`

## Usage

``` r
vtb_infobasket_playoff_games(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble: The games of every series of a playoff stage. The
columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_playoff_games`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Stage CompID the request asked for (50720 = the 2025-26 regular season): a stage below the season, not an END year. |
| tree | integer | Bracket tree number (1 = the main bracket). |
| round | integer | Round as the number of series in it (4 = quarter-finals, 2 = semi-finals, 1 = final). |
| sort | integer | Series order within the round. |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. |
| game_status | integer | Game status in the game-record code set: 21 on every completed game sampled (not the calendar's 0/1/2). |
| score | character | Final score 'side1:side2'. |
| plus_minus | integer | Point difference from side 1's view. |
| game_date | character | Game date as an ISO 8601 date (YYYY-MM-DD); the wire sends DD.MM.YYYY. |
| team1_id | integer | TeamID of side 1. |
| team2_id | integer | TeamID of side 2. |
| team1_place | integer | Seed of side 1. |
| team2_place | integer | Seed of side 2. |
| home_team | integer | Home side of that game (1 or 2). |
| win_team | integer | Winning side of that game (1 or 2). |
| score1 | integer | Series wins of side 1. |
| score2 | integer | Series wins of side 2. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_playoff_games(comp_id = 54281))
#> ── VTB Infobasket Playoff Games from org.infobasket.su ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:10:00 UTC
#> # A tibble: 34 × 17
#>    comp_id  tree round  sort game_id game_status score  plus_minus game_date 
#>      <int> <int> <int> <int>   <int>       <int> <chr>       <int> <chr>     
#>  1   54281     1     4     1 1058377          21 104:66         38 2026-04-27
#>  2   54281     1     4     1 1058378          21 85:67          18 2026-04-29
#>  3   54281     1     4     1 1058379          21 94:65          29 2026-05-03
#>  4   54281     1     4     2 1058382          21 93:80          13 2026-04-27
#>  5   54281     1     4     2 1058383          21 79:76           3 2026-04-29
#>  6   54281     1     4     2 1058384          21 87:82           5 2026-05-03
#>  7   54281     1     4     3 1058387          21 87:62          25 2026-04-26
#>  8   54281     1     4     3 1058388          21 83:63          20 2026-04-28
#>  9   54281     1     4     3 1058389          21 74:63          11 2026-05-02
#> 10   54281     1     4     4 1058392          21 78:85          -7 2026-04-26
#> # ℹ 24 more rows
#> # ℹ 8 more variables: team1_id <int>, team2_id <int>, team1_place <int>,
#> #   team2_place <int>, home_team <int>, win_team <int>, score1 <int>,
#> #   score2 <int>
# }
```
