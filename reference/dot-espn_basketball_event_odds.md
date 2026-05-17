# Internal: ESPN basketball event odds

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/odds`
and returns a tidy tibble (one row per provider). MBB will typically
return an empty tibble because ESPN does not carry NCAA basketball odds
lines.

## Usage

``` r
.espn_basketball_event_odds(league, event_id, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- event_id:

  character or numeric. ESPN event/game identifier.

- ...:

  Unused; absorbed for forward compatibility.

## Value

A `hoopR_data` tibble or `NULL` on error.
