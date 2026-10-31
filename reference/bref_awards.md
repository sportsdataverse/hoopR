# **Basketball-Reference Awards Voting**

**Get end-of-season award voting from
[Basketball-Reference](https://www.basketball-reference.com).**

Returns the voting results for the major end-of-season awards (MVP,
Rookie of the Year, Defensive Player of the Year, Sixth Man, Most
Improved, Clutch Player, Coach of the Year) in one tidy tibble, one row
per candidate per award. No API key is required. Basketball-Reference
rate-limits aggressive scraping (~20 requests/minute) – space repeated
calls with [`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_awards(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per award candidate:

|  |  |  |
|----|----|----|
| col_name | types | description |
| award | character | Award slug (`mvp`, `roy`, `dpoy`, `smoy`, `mip`, `clutch_poy`, `coy`). |
| rank | integer | Finish in the voting. |
| player | character | Player (or coach) name. |
| age | integer | Age. |
| team | character | Team abbreviation. |
| votes_first | numeric | First-place votes. |
| points_won | numeric | Voting points won. |
| points_max | numeric | Maximum possible voting points. |
| award_share | numeric | Share of the maximum voting points. |
| season | integer | Season (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(bref_awards(season = 2024))
# }
}
```
