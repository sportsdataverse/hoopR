# Internal: extract and parse the Next.js `__NEXT_DATA__` JSON from a page

Sites built on Next.js (e.g. HoopsHype) embed their hydrated data in a
`<script id="__NEXT_DATA__">` JSON blob. This returns that parsed list.

## Usage

``` r
.next_data(doc)
```

## Arguments

- doc:

  An `xml_document` from
  [`.ext_html()`](https://hoopR.sportsdataverse.org/reference/dot-ext_html.md).

## Value

The parsed `__NEXT_DATA__` as a list, or `NULL` if absent.
