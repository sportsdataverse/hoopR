# **Get ACB Competition Weeks**

The weeks of every competition edition: the week ids to crawl.

One row per edition and week: the global `week_id`, the Spanish
`description` ('Semana 1') and the Monday `start_date`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_weeks(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble with one row per edition and week. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_competition_weeks")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_competition_weeks()

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
