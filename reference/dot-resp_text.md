# Extract response body as text

Replaces the httr::content(as = "text", encoding = "UTF-8") pattern.

## Usage

``` r
.resp_text(resp)
```

## Arguments

- resp:

  An httr2 response object

## Value

Character string of response body
