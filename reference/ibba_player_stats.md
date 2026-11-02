# **IBBA Player Stats**

**A player-season's totals, or per-game averages with
is_averages=True.**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/PlayerStatsById`

## Usage

``` r
ibba_player_stats(player_id, season, is_averages = FALSE, is_playoff = FALSE)
```

## Arguments

- player_id:

  (*integer* required): Player-season id (new every season; Jaylen Hoard
  = 21912 in 2025-26): `player_id` in ibba_players.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- is_averages:

  (*logical*, default `FALSE`): True returns per-game averages
  (decimals); False (default) the season totals.

- is_playoff:

  (*logical*, default `FALSE`): True returns the playoff games only;
  False (default) the regular season.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Player-season id (key space: IBBA player registrations; a NEW id every season, e.g. Jaylen Hoard = 21912 in 2025-26 and 25997 in 2026-27; the ASMX host has no cross-season person id). Joins ibba_players, ibba_player, ibba_box_score and ibba_leaders; null on the team-credited and TOTAL box rows. |
| jersey | character | Jersey number as a zero-padded string ('02'); a box score also uses '\_TEAM' and 'TOTAL' for its two non-player lines. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| team_id | integer | Team-season id (key space: IBBA team registrations; a NEW id every season for the same club, e.g. Maccabi Tel Aviv = 1109 in 2025-26 and 2111 in 2026-27). Joins ibba_teams, ibba_players, ibba_coaches, ibba_box_score and the games' home / away ids. |
| games | integer | Games played (in the standings or in the season stats). |
| minutes | double | Minutes played, whole minutes; a TOTAL line holds the team's player-minutes (200 plus 25 per overtime). Season total, or the per-game average when is_averages is true. |
| pts | double | Points scored by the player or team (free throws included). Season total, or the per-game average when is_averages is true. |
| fg2m | double | Two-point field goals made. Season total, or the per-game average when is_averages is true. |
| fg2a | double | Two-point field goals attempted (verified equal to Segev made + missed). Season total, or the per-game average when is_averages is true. |
| fg2_pct | double | Two-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
| fg3m | double | Three-point field goals made. Season total, or the per-game average when is_averages is true. |
| fg3a | double | Three-point field goals attempted. Season total, or the per-game average when is_averages is true. |
| fg3_pct | double | Three-point field-goal percentage, 0-100. Season total, or the per-game average when is_averages is true. |
| ftm | double | Free throws made. Season total, or the per-game average when is_averages is true. |
| fta | double | Free throws attempted. Season total, or the per-game average when is_averages is true. |
| ft_pct | double | Free-throw percentage, 0-100. Season total, or the per-game average when is_averages is true. |
| dreb | double | Defensive rebounds. Season total, or the per-game average when is_averages is true. |
| oreb | double | Offensive rebounds. Season total, or the per-game average when is_averages is true. |
| reb | double | Total rebounds. Season total, or the per-game average when is_averages is true. |
| fouls_drawn | double | Fouls DRAWN: fouls opponents committed against the player or team (the wire's fouls_against; verified equal to Segev f_drawn). Season total, or the per-game average when is_averages is true. |
| fouls | double | Fouls COMMITTED by the player or team (the wire's fouls_for; verified equal to Segev f). Season total, or the per-game average when is_averages is true. |
| steals | double | Steals made by the player or team. Season total, or the per-game average when is_averages is true. |
| turnovers | double | Turnovers (the wire's misspelt tournovers). Season total, or the per-game average when is_averages is true. |
| assists | double | Assists credited to the player or team. Season total, or the per-game average when is_averages is true. |
| blocks | double | Shots the player or team blocked. Season total, or the per-game average when is_averages is true. |
| blocks_against | double | Own shots that were blocked. Season total, or the per-game average when is_averages is true. |
| val | double | Efficiency rating (valuation; verified equal to Segev rate); -1 on 2004-05 team-credited lines. Season total, or the per-game average when is_averages is true. |
| plus_minus | double | Plus-minus; 0 on every line of the 2004-05 sample (not recorded then, inferred). Season total, or the per-game average when is_averages is true. |
| dunks | double | Dunks made by the player or team. Season total, or the per-game average when is_averages is true. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_games_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_games_ex.md),
[`ibba_leaders()`](https://hoopR.sportsdataverse.org/reference/ibba_leaders.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)

## Examples

``` r
# \donttest{
  try(ibba_player_stats(player_id = 21912, season = 2026))
#> ── IBBA player stats ──────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:53:36 UTC
#> # A tibble: 1 × 29
#>   player_id jersey season team_id games minutes   pts  fg2m  fg2a fg2_pct  fg3m
#>       <int> <chr>   <int>   <int> <int>   <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>
#> 1     21912 01       2026    1109    20     454   195    64   118      NA     5
#> # ℹ 18 more variables: fg3a <dbl>, fg3_pct <dbl>, ftm <dbl>, fta <dbl>,
#> #   ft_pct <dbl>, dreb <dbl>, oreb <dbl>, reb <dbl>, fouls_drawn <dbl>,
#> #   fouls <dbl>, steals <dbl>, turnovers <dbl>, assists <dbl>, blocks <dbl>,
#> #   blocks_against <dbl>, val <dbl>, plus_minus <dbl>, dunks <dbl>
# }
```
