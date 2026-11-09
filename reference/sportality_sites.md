# **Get Basketligaen Sites (Clubs) of an ssgt**

Clubs (sites) taking part in an ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/all-sites/{ssgt_uuid}`

## Usage

``` r
sportality_sites(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble with one row per club. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_sites")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_sites(ssgt_uuid = "xs07bd3fmp"))
#> Error in sportality_sites(ssgt_uuid = "xs07bd3fmp") : 
#>   www.basketligaen.dk/api/statistics-v2/layout-info: 0 ssgts in the body,
#> expected the 40+ of 25 seasons.
# }
```
