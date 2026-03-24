# Fetch a KenPom page as parsed HTML using an authenticated cookie jar

Fetch a KenPom page as parsed HTML using an authenticated cookie jar

## Usage

``` r
.kp_get_page(jar, url)
```

## Arguments

- jar:

  Path to the httr2 cookie jar file (returned by
  [`login()`](https://hoopR.sportsdataverse.org/reference/kp_user_pw.md))

- url:

  The KenPom URL to fetch

## Value

A parsed HTML document (xml_document)
