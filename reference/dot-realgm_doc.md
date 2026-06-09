# Internal: fetch a RealGM page and parse it into an `xml_document`

Internal: fetch a RealGM page and parse it into an `xml_document`

## Usage

``` r
.realgm_doc(path, wait = 25)
```

## Arguments

- path:

  Page path beginning with `/`.

- wait:

  Maximum seconds to wait for the Cloudflare challenge to clear.

## Value

An `xml_document` (from
[`rvest::read_html()`](http://xml2.r-lib.org/reference/read_xml.md)).
