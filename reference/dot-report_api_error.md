# Report an API-call error with full context

Internal helper that standardizes the message every NBA / ESPN / NCAA
wrapper emits inside its `tryCatch(error = ...)` block. Always emits, in
order:

## Usage

``` r
.report_api_error(e, hint = NULL, args = list())
```

## Arguments

- e:

  error condition (the `e` from `function(e)` in `tryCatch`).

- hint:

  character. A friendly message with optional `{name}` tokens that
  resolve against the *caller's* environment (so `{game_id}` etc. pull
  from the wrapper's formals). If `NULL`, defaults to "Request failed".

- args:

  optional named list of caller arguments to dump (typically
  `mget(setdiff(names(formals()), "..."))` captured at function entry).

## Value

Invisibly `NULL`. Called for its side effects.

## Details

1.  A timestamped friendly hint (brace-interpolated against the caller
    env),

2.  A dump of the function call's arguments,

3.  The actual error message (`conditionMessage(e)`).

Functions opt in by capturing their formals once near the top –
`.args <- mget(setdiff(names(formals()), "..."))` – and then calling
`.report_api_error(e, hint = "...", args = .args)` from the error
handler.
