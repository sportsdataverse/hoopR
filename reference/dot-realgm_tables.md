# Internal: extract every parseable HTML table from a RealGM document

RealGM pages usually carry a small nav / filter / legend table ahead of
the real data table. This returns all tables that parse and clear
`min_rows`,
[`janitor::clean_names()`](https://sfirke.github.io/janitor/reference/clean_names.html)-ed,
so a caller can pick or combine them.

## Usage

``` r
.realgm_tables(doc, min_rows = 1)
```

## Arguments

- doc:

  An `xml_document` from
  [`.realgm_doc()`](https://hoopR.sportsdataverse.org/reference/dot-realgm_doc.md).

- min_rows:

  Minimum row count for a table to be kept (drops nav/legend).

## Value

A list of cleaned `data.frame`s.
