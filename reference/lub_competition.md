# **Liga Uruguaya de Basquetbol (Genius LiveStats)**

Convenience wrappers binding the Genius family to the Liga Uruguaya de
Basquetbol (men's; Genius ORG `FUBB`, LiveStats ORG `FUBB`). Season
rule: END year; Genius year + 1 (2025-26 = 2026).

- `lub_competitions()`: every competition of the `FUBB` org, with its
  END-year season
  ([`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)).

- `lub_schedule()`: every match of one season
  ([`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md)).

- `lub_team_box()`, `lub_player_box()`, `lub_pbp()`, `lub_shots()`: one
  finished game
  ([`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
  [`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
  [`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
  [`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md)).

## Usage

``` r
lub_competitions(return_parsed = TRUE)

lub_schedule(season = NULL, comp_id = NULL, round_number = -1, return_parsed = TRUE)

lub_team_box(match_id, return_parsed = TRUE)

lub_player_box(match_id, return_parsed = TRUE)

lub_pbp(match_id, return_parsed = TRUE)

lub_shots(match_id, return_parsed = TRUE)
```

## Arguments

- season:

  END-year season (see the season rule). `NULL` (default) = the newest
  season the org lists.

- comp_id:

  Genius competition id; skips the season lookup (needed when the label
  rule matches several competitions).

- round_number:

  Round to list; -1 (default) lists every round.

- match_id:

  Genius match id (`match_id` of `lub_schedule()`) of a game of this
  competition.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the raw list.

## Value

The base function's `hoopR_data` tibble, same columns and types (the raw
list when `return_parsed = FALSE`) of each function:

- `lub_competitions()`: the columns of
  [`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md).

- `lub_schedule()`: the columns of
  [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md).

- `lub_team_box()`: the columns of
  [`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md).

- `lub_player_box()`: the columns of
  [`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md).

- `lub_pbp()`: the columns of
  [`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md).

- `lub_shots()`: the columns of
  [`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md).

## Details

The season's competition is picked from the `FUBB` chooser by the label
rule include = `liga uruguaya|^lub`, exclude = `amistosos|femenina`
(case-insensitive); cups and play-offs have their own `comp_id`. Several
matching competitions raise `hoopR_bad_request` (pass `comp_id`); none
raises `hoopR_no_data`.

Genius match ids are one global sequence shared by every customer and
`data.json` names no competition, so each game alias checks the id on
the game's LiveStats shell (`/u/FUBB/<match_id>/`: one extra request per
game, cached per process for an hour): its competition name must pass
the label rule. Another org's game, a cup or play-off game of `FUBB`, or
a shell request that fails twice (or names no competition) raises
`hoopR_asset_fetch`. The base `genius_*()` function reads any game
unchecked.

Access, proxy and error notes: see
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md).

     lub_competitions()
     lub_schedule()

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)
