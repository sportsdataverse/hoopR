# Report an API-call warning with full context

Mirrors
[`.report_api_error()`](https://hoopR.sportsdataverse.org/reference/dot-report_api_error.md)
but for `tryCatch(warning = ...)` handlers. Emits, in order:

## Usage

``` r
.report_api_warning(w, hint = NULL, args = list())
```

## Arguments

- w:

  warning condition (the `w` from `function(w)` in `tryCatch`).

- hint:

  character. Same semantics as
  [`.report_api_error()`](https://hoopR.sportsdataverse.org/reference/dot-report_api_error.md)'s
  `hint`. If `NULL`, defaults to "Request emitted a warning".

- args:

  optional named list of caller arguments to dump.

## Value

Invisibly `NULL`. Called for its side effects.

## Details

1.  A timestamped friendly hint (brace-interpolated against the caller
    env),

2.  A dump of the function call's arguments,

3.  The actual warning message (`conditionMessage(w)`).
