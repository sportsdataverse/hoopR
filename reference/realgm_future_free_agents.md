# **RealGM Future NBA Free Agents**

**Get RealGM's projected future NBA free-agent class from RealGM
(basketball.realgm.com).**

One row per upcoming free agent, including the free-agency season, the
player's Bird/veteran free-agent status, recent production and –
distinctively – the player's listed agent.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_future_free_agents()
```

## Value

A `hoopR_data` tibble with one row per future free agent:

|                   |           |                                        |
|-------------------|-----------|----------------------------------------|
| col_name          | types     | description                            |
| player            | character | Player name.                           |
| pos               | character | Position.                              |
| team              | character | Current team abbreviation.             |
| season            | character | Free-agency season (e.g. `2026-2027`). |
| age               | integer   | Age.                                   |
| yos               | integer   | Years of service.                      |
| veteran_fa_status | character | Bird / Non-Bird / veteran FA status.   |
| gp                | integer   | Games played.                          |
| pts               | numeric   | Points per game.                       |
| reb               | numeric   | Rebounds per game.                     |
| ast               | numeric   | Assists per game.                      |
| per               | numeric   | Player Efficiency Rating.              |
| agent             | character | Listed player agent.                   |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_future_free_agents())
} # }
```
