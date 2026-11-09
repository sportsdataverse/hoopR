# **Get ACB Competition Editions**

Every competition edition (season) the API knows, one row per edition.

One row per competition and edition: `edition_id` (START year - 1935),
`season_start_year` and `season` (END year), plus how many rounds and
weeks the edition lists. `competition_name` is the API's name for the
competition (the Liga is `Liga Nacional` here).

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_editions(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble with one row per edition. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_competition_editions")`) and in the
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
  try(acb_competition_editions())
#> Error in acb_competition_editions() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
