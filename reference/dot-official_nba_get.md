# GET a URL from official.nba.com, signalling classed conditions on failure

Returns the response body (character) on HTTP 200. Any other status
raises a classed condition instead of returning: a 404 is always
`hoopR_no_data`; only a 403 reads the body, via
[`.classify_official_403()`](https://hoopR.sportsdataverse.org/reference/dot-classify_official_403.md)
(an S3 `AccessDenied` document is `hoopR_no_data`, anything else
`hoopR_fetch_error`); every other status is `hoopR_fetch_error`. The
request is built directly against httr2 here (rather than delegating to
the shared
[`.retry_request()`](https://hoopR.sportsdataverse.org/reference/dot-retry_request.md))
so the retry policy can treat 403/404 as definitive instead of
transient, and so a transport-level failure (DNS, TLS, a dropped
connection) is retried, then reclassified into the same error vocabulary
instead of escaping as a raw curl/httr2 condition. Only
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)
is wrapped: an error while building the request (a malformed `proxy`,
say) is the caller's mistake and propagates unchanged. A response
without a body (a bare 503, an empty 200) is classified by its status
like any other.

## Usage

``` r
.official_nba_get(url, params = list(), proxy = NULL)
```

## Arguments

- url:

  character(1). Full official.nba.com URL to fetch.

- params:

  Named list of query parameters, spliced onto `url` (default: empty
  list).

- proxy:

  Optional proxy: a URL string (e.g. `"http://host:port"`) or a named
  list of
  [`httr2::req_proxy()`](https://httr2.r-lib.org/reference/req_proxy.html)
  arguments (`url`, `port`, `username`, `password`, `auth`). `NULL` (the
  default) falls back to `getOption("hoopR.proxy")`, then the
  `http_proxy`/`https_proxy` environment variables.

## Value

character(1). The response body text.
