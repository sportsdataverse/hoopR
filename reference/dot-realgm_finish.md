# Internal: finalize a RealGM table as a `hoopR_data` tibble

Coerces numeric-looking columns (via `.bref_type_convert()`), converts
to a tibble, and attaches the `hoopR_data` class + metadata.

## Usage

``` r
.realgm_finish(df, description)
```

## Arguments

- df:

  A parsed RealGM `data.frame`.

- description:

  Provenance string stored on the result.

## Value

A `hoopR_data` tibble.
