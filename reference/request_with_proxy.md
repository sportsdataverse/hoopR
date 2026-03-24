# **Retry http request with proxy**

This is a thin wrapper around httr2 for NBA Stats API requests

## Usage

``` r
request_with_proxy(
  url,
  params = list(),
  origin = "https://stats.nba.com",
  referer = "https://www.nba.com/",
  ...
)
```

## Arguments

- url:

  Request url

- params:

  list of params

- origin:

  Origin url

- referer:

  Referer url

- ...:

  Additional arguments (currently unused)
