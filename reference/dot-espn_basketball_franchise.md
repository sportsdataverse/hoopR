# Internal: ESPN basketball franchise detail

Fetches the core-v2 franchise resource
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/franchises/{franchise_id}`
and returns a single-row tibble. The franchise resource is stable across
relocations and rebrands — for example, the Charlotte Hornets and New
Orleans Pelicans share a different franchise lineage than current /
historical teams suggest.

## Usage

``` r
.espn_basketball_franchise(league, franchise_id, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- franchise_id:

  character or numeric. ESPN franchise identifier.

- ...:

  Unused; absorbed for forward compatibility.

## Value

A single-row `hoopR_data` tibble, or `NULL` on error.
