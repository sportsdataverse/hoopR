# **Get Basketligaen Standings**

Standings of an ssgt (gameday widget).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/team-standings/{ssgt_uuid}`

## Usage

``` r
sportality_standings(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_standings")`) and in the
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
  try(sportality_standings(ssgt_uuid = "xs07bd3fmp"))
#> ── Basketligaen Standings from basketligaen.dk ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:19:35 UTC
#> # A tibble: 12 × 13
#>    team_id team_uuid  team_code team_name     rank    gp     w     l    tp `for`
#>      <int> <chr>      <chr>     <chr>        <int> <int> <int> <int> <int> <int>
#>  1   22255 iutrlqp3ef TFN       Team FOG Næ…     1    11    10     1    20  1089
#>  2   22249 hip2m60a45 HIC       Horsens IC       2    10     8     2    16   892
#>  3   22256 kgmhwo9l5d SVE       Svendborg R…     3    10     8     2    16   906
#>  4   22248 ktcu9aaala BAK       Bakken Bears     4     8     7     1    14   816
#>  5   22250 gvvuxe9ysw RAN       Randers Cim…     5    10     7     3    14   956
#>  6  156486 ka7lusvmtn BCC       BC Copenhag…     6     9     5     4    10   756
#>  7  153747 rfo82vr830 HOL       Holbæk-Sten…     7    10     4     6     8   771
#>  8  199228 nuzzapynfd GLX       Gladsaxe Ba…     8    10     3     7     6   794
#>  9  187013 wv1lcxg0u2 BKV       BK Vejen         9     9     3     6     6   728
#> 10  114932 ozojzoejir VBH       Værløse Blu…    10    10     2     8     4   780
#> 11  140898 kgejfzwwbd BMS       BMS Herlev      11    11     1    10     2   818
#> 12  130088 swr1d65lew BAC       Bears Acade…    12    10     1     9     2   788
#> # ℹ 3 more variables: ga <int>, plus_minus <int>, strk <int>
# }
```
