# **Parse ESPN MBB PBP, helper function**

**Parse ESPN MBB PBP, helper function**

**Parse ESPN MBB Team Box, helper function**

**Parse ESPN MBB Player Box, helper function**

## Usage

``` r
helper_espn_mbb_pbp(resp)

helper_espn_mbb_team_box(resp)

helper_espn_mbb_player_box(resp)
```

## Arguments

- resp:

  Response object from the ESPN MBB game summary endpoint

## Value

For `helper_espn_mbb_pbp()`: a tibble with the columns of
[espn_mbb_game_all_plays_schema](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all_plays_schema.md),
or `NULL` when the game has no play-by-play. `home_score` / `away_score`
are rebuilt from the scoring plays when that reproduces the header's
official final, otherwise they are ESPN's per-play values; the last
column, `score_source` (`"rebuilt"` / `"espn"`), says which.

Returns a tibble

Returns a tibble
