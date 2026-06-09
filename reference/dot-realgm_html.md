# Internal: fetch a RealGM page through headless Chrome (clears Cloudflare)

Navigates headless Chrome to the page, waits for the Cloudflare
challenge to resolve (the page title stops being "Just a moment..."),
and returns the fully rendered HTML for `rvest` parsing.

## Usage

``` r
.realgm_html(path, wait = 25)
```

## Arguments

- path:

  Page path beginning with `/` (e.g. `"/nba/players"`).

- wait:

  Maximum seconds to wait for the challenge to clear.

## Value

The rendered page HTML as a character string.
