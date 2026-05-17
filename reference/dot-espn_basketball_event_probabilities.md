# Internal: ESPN basketball event win probabilities

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/probabilities`
with pagination. Loops over pages while `pageIndex < pageCount` and
accumulated row count is below `limit`. Sleeps ~250ms between pages.
Capped at 50 pages as a defensive upper bound.

## Usage

``` r
.espn_basketball_event_probabilities(league, event_id, limit = 200, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- event_id:

  character or numeric. ESPN event/game identifier.

- limit:

  integer. Maximum rows to return (default `200`).

- ...:

  Unused; absorbed for forward compatibility.

## Value

A `hoopR_data` tibble or `NULL` on error.
