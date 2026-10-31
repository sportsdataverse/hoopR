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
if (FALSE) { # interactive()
# \donttest{
  try(bref_player_bios(letter = "a"))
# }
}
```
