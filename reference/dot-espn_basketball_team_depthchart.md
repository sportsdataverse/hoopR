# Internal: ESPN basketball team depth chart (long format)

Returns one row per (position x rank x athlete). NBA-only at ESPN.
Schema: `items[1].positions[5].athletes[N]` where each position is PG /
SG / SF / PF / C, and each `athletes[i]` has `{athlete $ref, rank}`.

## Usage

``` r
.espn_basketball_team_depthchart(league, team_id, season, ...)
```
