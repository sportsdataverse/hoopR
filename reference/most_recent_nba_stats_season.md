# **Most Recent NBA Stats Season**

Returns the most recent season's **START** year – the `seasons` value
the `nba_stats_*` release loaders expect (see
[`load_nba_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/load_nba_stats_coaches.md)),
matching sdv-py's `load_nba_stats_*` Python loaders. It is defined as
`most_recent_nba_season() - 1`:
[`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md)
returns the current season's **END** year (hoopR's ESPN-family
convention, used directly – with no offset – by `load_nba_*()`), and the
published `nba_stats_*` assets are themselves keyed by that same END
year, but the `nba_stats_*` loaders take the season's START year and
translate it internally via `seasons + 1`. So this helper is not a plain
alias of
[`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md);
it is one less.

## Usage

``` r
most_recent_nba_stats_season()
```
