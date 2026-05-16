# Capture the calling function's formal arguments

Returns a named list of the bound formal arguments (excluding `...`) of
the calling function, suitable for passing to
[`.report_api_error()`](https://hoopR.sportsdataverse.org/reference/dot-report_api_error.md)
/
[`.report_api_warning()`](https://hoopR.sportsdataverse.org/reference/dot-report_api_warning.md).
Tolerates functions with empty or `...`-only formals (where
`names(formals())` is `NULL`), unlike the inline
`mget(setdiff(names(formals()), "..."))` pattern that errors with
`mget: invalid first argument` for arg-less wrappers.

## Usage

``` r
.capture_args()
```

## Value

Named list. Empty list if the caller has no non-... formals.

## Details

Caller usage:

    some_wrapper <- function(...) {
      .args <- .capture_args()
      ...
    }
