# Internal: perform a GET against the CollegeBasketballData API

Attaches the `Authorization: Bearer <CBBD_API_KEY>` header, routes
through hoopR's shared
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md)
(which handles retries, timeouts and proxy resolution), and parses the
JSON body. `NULL` query values are dropped automatically by
[`httr2::req_url_query()`](https://httr2.r-lib.org/reference/req_url.html),
so optional parameters can be threaded through unconditionally.

## Usage

``` r
.cbbd_get(path, query = list())
```

## Arguments

- path:

  Endpoint path beginning with `/` (e.g. `"/teams"`).

- query:

  Named list of query parameters. `NULL` elements are omitted.

## Value

The parsed JSON body (a data.frame for list endpoints).
