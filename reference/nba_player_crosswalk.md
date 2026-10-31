# **Get the NBA cross-source player crosswalk**

Build a wide, one-row-per-player-per-team crosswalk linking ESPN, NBA
Stats, and Fox player identities. Matching is deterministic: normalized
exact name within a team block, then Jaro-Winkler fuzzy with jersey/DOB
tiebreakers. Yahoo columns are NA placeholders.

## Usage

``` r
nba_player_crosswalk(season = most_recent_nba_season(), min_confidence = 0.92)
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)).

- min_confidence:

  Jaro-Winkler similarity floor for fuzzy matches (default 0.92).

## Value

A `hoopR_data` tibble, one row per player per team (ESPN-anchored).

## See also

Other NBA Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md),
[`nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_team_crosswalk.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(nba_player_crosswalk())
# }
}
```
