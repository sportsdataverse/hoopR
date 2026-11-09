# **RealGM NBA Players Abroad**

**Get the list of NBA-affiliated players currently playing overseas from
RealGM (basketball.realgm.com).**

RealGM tracks NBA draft picks, two-way and free-agent players who are on
international rosters – a view no first-party NBA/ESPN endpoint
provides.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_players_abroad()
```

## Value

A `hoopR_data` tibble with one row per player:

|            |           |                                               |
|------------|-----------|-----------------------------------------------|
| col_name   | types     | description                                   |
| player     | character | Player name.                                  |
| pos        | character | Position.                                     |
| ht         | character | Listed height.                                |
| wt         | integer   | Listed weight (lbs).                          |
| nba_status | character | NBA contract / rights status.                 |
| team_s     | character | Current overseas team(s) and NBA affiliation. |
| gp         | integer   | Games played.                                 |
| mpg        | numeric   | Minutes per game.                             |
| ppg        | numeric   | Points per game.                              |
| rpg        | numeric   | Rebounds per game.                            |
| apg        | numeric   | Assists per game.                             |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_players_abroad())
} # }
```
