# Internal helper – ESPN basketball team news

Fetches the news feed for a specific team in an ESPN basketball league
and returns a tidy tibble of articles. This is the single implementation
shared by
[`espn_mbb_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_news.md)
and
[`espn_nba_team_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_news.md).

## Usage

``` r
.espn_basketball_team_news(league, team_id, limit = 25, ...)
```

## Arguments

- league:

  character. One of `"nba"` or `"mens-college-basketball"`.

- team_id:

  character or integer. ESPN team ID.

- limit:

  integer. Maximum number of articles to return (default `25`).

- ...:

  Currently unused; reserved for future pass-through arguments.

## Value

A `hoopR_data` tibble of articles, or `NULL` on error.
