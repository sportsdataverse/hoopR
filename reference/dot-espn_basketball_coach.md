# Internal: ESPN basketball single coach detail

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/coaches/{coach_id}`
and returns a single-row tibble with name, biography, current team /
college refs, and a count of career-record and coach-season entries.

## Usage

``` r
.espn_basketball_coach(league, coach_id, ...)
```
