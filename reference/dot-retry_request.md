# Perform an HTTP GET request with retry logic

Thin wrapper around httr2 that replaces httr::RETRY("GET", ...).
Supports optional query parameters and custom headers.

## Usage

``` r
.retry_request(url, params = list(), headers = NULL, timeout = 60)
```

## Arguments

- url:

  The URL to request

- params:

  Named list of query parameters (default: empty list)

- headers:

  Named character vector of headers (default: NULL)

- timeout:

  Timeout in seconds (default: 60)

## Value

An httr2 response object
