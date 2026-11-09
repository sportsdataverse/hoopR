# **Get P. LEAGUE+ Standings**

Regular-season standings of one season: record, scoring averages, home /
away and recent form.

Endpoint: `GET https://pleagueofficial.com/standings/{season slug}`

## Usage

``` r
pleague_standings(season)
```

## Arguments

- season:

  Required. Season END year (2025 = the site's slug '2024-25'). The slug
  is `<season - 1>-<yy>` (yy: the last two digits of season). The first
  season is 2020-21 (`season=2021`); earlier slugs redirect.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_standings(season = 2025))
#> Error in pleague_standings(season = 2025) : 
#>   pleagueofficial.com/standings/2024-25: not the page asked for: layout
#> drift: standings table not found
# }
```
