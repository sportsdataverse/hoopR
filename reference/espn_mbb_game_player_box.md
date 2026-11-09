# **Get ESPN MBB Event Player Box Score (Long Format)**

Returns the long-format per-game box score for a single athlete in one
MBB event. One row per (category x stat). Same shape as
[`espn_mbb_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md)
but scoped to a single athlete-in-event instead of the full team.
`stat_type` defaults to 0 (regular-season aggregate as ESPN tags it for
finished events).

Returns the long-format per-game box score for a single athlete in one
NBA event. One row per (category x stat). Same shape as
[`espn_nba_game_team_statistics()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_team_linescores.md)
but scoped to a single athlete-in-event instead of the full team.
`stat_type` defaults to 0 (regular-season aggregate as ESPN tags it for
finished events).

## Usage

``` r
espn_mbb_game_player_box(event_id, team_id, athlete_id, stat_type = 0L, ...)

espn_nba_game_player_box(event_id, team_id, athlete_id, stat_type = 0L, ...)
```

## Arguments

- event_id:

  ESPN event identifier.

- team_id:

  ESPN team identifier (the competitor the athlete played for).

- athlete_id:

  ESPN athlete identifier.

- stat_type:

  Integer stat-type segment. Defaults to 0 (the only type commonly
  populated for finished events).

- ...:

  Additional arguments; currently unused.

## Value

A long tibble with one row per (category x stat).

A long tibble with one row per (category x stat).

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_game_player_box(event_id = 401256760, team_id = 52,
                               athlete_id = 4593919)
#> ✖ 2026-11-09 19:52:49.275984: Failed to retrieve ESPN mens-college-basketball event player box for event_id=401256760, team_id=52, athlete_id=4593919
#> ✖ Args: league = "mens-college-basketball", event_id = 401256760, team_id = 52, athlete_id = 4593919, stat_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN MENS-COLLEGE-BASKETBALL Event Player Box ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:49 UTC
#> # A tibble: 0 × 0
# }
# \donttest{
  espn_nba_game_player_box(event_id = 401283399, team_id = 29,
                               athlete_id = 1966)
#> ✖ 2026-11-09 19:52:49.371192: Failed to retrieve ESPN nba event player box for event_id=401283399, team_id=29, athlete_id=1966
#> ✖ Args: league = "nba", event_id = 401283399, team_id = 29, athlete_id = 1966, stat_type = 0L
#> ✖ Error: The API returned an error
#> ── ESPN NBA Event Player Box ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:49 UTC
#> # A tibble: 0 × 0
# }
```
