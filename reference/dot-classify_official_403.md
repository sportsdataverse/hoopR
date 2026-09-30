# Classify an official.nba.com 403 response body

A 403 from official.nba.com means two different things depending on the
body: an S3 XML `AccessDenied` document means "no such object" (there is
no report/no data for the request), while anything else (typically an
Akamai HTML interstitial) means the fetch itself was blocked.

## Usage

``` r
.classify_official_403(body)
```

## Arguments

- body:

  character(1). Response body text.

## Value

character(1). `"no_data"` or `"fetch_error"`.
