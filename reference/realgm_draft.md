# **RealGM NBA Draft Results**

**Get the results of a past NBA draft from RealGM
(basketball.realgm.com).**

One row per selection (rounds 1 and 2, labelled by `round`) plus the
listed undrafted players (`round = NA`), including pre-draft team /
international club, age, years of service and nationality.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft(year = most_recent_nba_season() - 1L)
```

## Arguments

- year:

  Draft year (the calendar year the draft was held). Defaults to the
  most recently completed draft (`most_recent_nba_season() - 1`).

## Value

A `hoopR_data` tibble with one row per selection. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_draft")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_draft(year = 2020))
} # }
```
