# **IBBA to Segev Game Crosswalk**

**IBBA `game_id` \<-\> Segev `game_id`, from an
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md)
(or
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md))
frame you already have: no request is made.**

The pairs come from the frame's `segev_game_id` column (the host's own
`ExternalID`, read as a Segev game id); nothing is guessed from names.
Games before 2025-26 and external-team news links carry no Segev id and
are dropped. The id types are checked (no float or string id casts) and
the mapping must be one-to-one both ways.

## Usage

``` r
ibba_segev_game_crosswalk(df)
```

## Arguments

- df:

  A data frame from
  [`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md)
  or
  [`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md).

## Value

A `hoopR_data` tibble, one row per game:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | IBBA game id (key space: basket.co.il games): the `game_id` of [`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md) and [`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md). |
| segev_game_id | integer | The Segev game id of the same game: the `game_id` every `ibba_segev_*()` wrapper takes. |

## Details

Raises `hoopR_bad_request` when `df` is not a data frame, lacks a
column, has an id column of the wrong type, or maps one id to two.

## See also

Other IBBA:
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
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_game_crosswalk(ibba_games(season = 2026, board_id = 5, board_round = 1)))
#> ── IBBA game crosswalk ───────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 15:41:12 UTC
#> # A tibble: 7 × 2
#>   game_id segev_game_id
#>     <int>         <int>
#> 1   26391            51
#> 2   26392            50
#> 3   26394            49
#> 4   26393            48
#> 5   26390            47
#> 6   26395            52
#> 7   26389            23
# }
```
