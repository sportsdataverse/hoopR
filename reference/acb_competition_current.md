# **Get ACB Competition Current**

The API's current pointers: competition, edition, week, round and match.

One row: the ids the site opens by default, and the current match with
its teams.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_current(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble with one row per game of the current round. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_competition_current")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_competition_current())
#> Error in acb_competition_current() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
