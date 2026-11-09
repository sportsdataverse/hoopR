# **RealGM NBA Players Abroad**

**Get the list of NBA-affiliated players currently playing overseas from
RealGM (basketball.realgm.com).**

RealGM tracks NBA draft picks, two-way and free-agent players who are on
international rosters – a view no first-party NBA/ESPN endpoint
provides.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_players_abroad()
```

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_players_abroad")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_players_abroad())
} # }
```
