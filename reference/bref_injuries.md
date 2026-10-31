# **Basketball-Reference NBA Injury Report**

**Get the current NBA injury report from
[Basketball-Reference](https://www.basketball-reference.com).**

One row per injured player with team, the date the status was last
updated and the injury note (status + description). No API key is
required.

**Note on RotoWorld:** RotoWorld was a long-standing NBA injuries
source, but NBC shut it down (it now redirects to
`nbcsports.com/fantasy` and the injuries tool is gone). This function
uses Basketball-Reference's live injury report instead, which is
maintained and carries the same player / team / status / note fields.

## Usage

``` r
bref_injuries()
```

## Value

A `hoopR_data` tibble with one row per injured player:

|             |           |                                   |
|-------------|-----------|-----------------------------------|
| col_name    | types     | description                       |
| player      | character | Player name.                      |
| team_name   | character | Team name.                        |
| date_update | character | Date the status was last updated. |
| note        | character | Injury status and description.    |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
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
  try(bref_injuries())
# }
}
```
