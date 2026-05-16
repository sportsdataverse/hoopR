# **Retry http request with optional proxy**

This is a thin wrapper around httr2 for NBA Stats API requests.

## Usage

``` r
request_with_proxy(
  url,
  params = list(),
  origin = "https://stats.nba.com",
  referer = "https://www.nba.com/",
  proxy = NULL,
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

- proxy:

  Optional proxy config. `NULL` (default) lets libcurl honor the
  standard `http_proxy` / `https_proxy` / `no_proxy` environment
  variables. A single URL string (e.g. `"http://host:port"`) is
  forwarded to `httr2::req_proxy(url = proxy)`. A named list is spread
  as keyword args into
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  (`url`, `port`, `username`, `password`, `auth`) for full control over
  authenticated proxies.

- ...:

  Additional arguments (currently unused).
