# **Check Status function**

Raises the classed `hoopR_http_error` of `.stop_for_http_status()`
(status, URL and the error body's message) for a non-2xx response.

## Usage

``` r
check_status(res)
```

## Arguments

- res:

  Response from API (httr2 response object)

## Value

`res`, invisibly, when its status is 2xx.
