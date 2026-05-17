# Internal helper – ESPN basketball calendar

Fetches the schedule calendar for an ESPN basketball league and returns
a tidy tibble of calendar entries. This is the single implementation
shared by
[`espn_mbb_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_calendar.md)
(league = "mens-college-basketball") and
[`espn_nba_calendar()`](https://hoopR.sportsdataverse.org/reference/espn_nba_calendar.md)
(league = "nba"). The scoreboard endpoint carries a
`leagues[[1]]$calendar` block that describes the season types and their
date-range entries (weeks / round labels).

## Usage

``` r
.espn_basketball_calendar(league, season, ...)
```

## Arguments

- league:

  character. One of `"nba"` or `"mens-college-basketball"`.

- season:

  integer or character. Four-digit season year (e.g. `2025`).

- ...:

  Currently unused; reserved for future pass-through arguments.

## Value

A `hoopR_data` tibble of calendar entries, or `NULL` on error.
