# Internal: ESPN basketball coach-in-season detail

Single coach for one specific season. Returns name, birth info, plus
`$ref`s to college, person, team, and records. ESPN's coverage is
sparse: many `(coach_id x season)` combinations return 404.

## Usage

``` r
.espn_basketball_coach_season(league, coach_id, season, ...)
```
