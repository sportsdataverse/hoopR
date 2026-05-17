# Internal: ESPN basketball event broadcasts

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/broadcasts`
and returns a tidy tibble (one row per broadcast outlet).

## Usage

``` r
.espn_basketball_event_broadcasts(league, event_id, ...)
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
