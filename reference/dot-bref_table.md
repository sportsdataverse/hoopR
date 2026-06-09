# Internal: parse a Basketball-Reference HTML table by id using data-stat keys

Un-comments the page (so comment-hidden tables are reachable), selects
the table (by `id`, or the first table when `table_id` is `NULL`), drops
mid-table header-repeat rows, and builds a data.frame whose columns are
the cells' `data-stat` attributes.

## Usage

``` r
.bref_table(html, table_id = NULL)
```

## Arguments

- html:

  Raw page HTML (character).

- table_id:

  Optional table `id` (e.g. `"per_game_stats"`); `NULL` = first table.

## Value

A data.frame (character columns), or an empty data.frame if not found.
