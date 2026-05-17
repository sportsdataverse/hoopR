# Internal helper – ESPN basketball league news

Fetches the top-level news feed for an ESPN basketball league and
returns a tidy tibble of articles. This is the single implementation
shared by
[`espn_mbb_news()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_news.md)
(league = "mens-college-basketball") and
[`espn_nba_news()`](https://hoopR.sportsdataverse.org/reference/espn_nba_news.md)
(league = "nba").

## Usage

``` r
.espn_basketball_news(league, limit = 50, ...)
```

## Arguments

- league:

  character. One of `"nba"` or `"mens-college-basketball"`.

- limit:

  integer. Maximum number of articles to return (default `50`).

- ...:

  Currently unused; reserved for future pass-through arguments.

## Value

A `hoopR_data` tibble of articles, or `NULL` on error.
