# Internal: GET a barttorvik.com resource and return the response body text

Routes through hoopR's shared
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
(retries, timeouts, proxy resolution) with a browser User-Agent, and
returns the raw response body as a string for downstream CSV / JSON /
HTML parsing.

## Usage

``` r
.torvik_text(path)
```

## Arguments

- path:

  Endpoint path beginning with `/` (e.g. `"/2024_team_results.csv"`).

## Value

The response body as a character string.
