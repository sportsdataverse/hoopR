# **Get the NBA cross-source team crosswalk**

Build a wide, one-row-per-team crosswalk linking ESPN, NBA Stats, and
Fox team identities, keyed on `espn_team_id`.
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md)
already supplies the ESPN\<-\>Stats linkage; this reshapes it and
attaches Fox. Yahoo columns are NA placeholders. NOTE: ESPN/Stats team
endpoints are current-season snapshots, so `season` is a stamp;
historical relocations are not back-modeled live.

## Usage

``` r
nba_team_crosswalk(season = most_recent_nba_season())
```

## Arguments

- season:

  NBA season per hoopR convention (default
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md);
  e.g. 2025 for 2024-25).

## Value

A `hoopR_data` tibble, one row per team (ESPN / `nba_*` / Fox / Yahoo
column groups + `match_method` / `match_confidence`).

## See also

Other NBA Crosswalk Functions:
[`load_nba_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/load_nba_team_crosswalk.md),
[`nba_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_player_crosswalk.md),
[`nba_schedule_crosswalk()`](https://hoopR.sportsdataverse.org/reference/nba_schedule_crosswalk.md)

## Examples

``` r
if (FALSE) { # interactive()
# \donttest{
  try(nba_team_crosswalk())
# }
}
```
