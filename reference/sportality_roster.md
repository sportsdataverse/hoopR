# **Get Basketligaen Team Roster**

Current roster of a team, grouped by position.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athletes/by-team-uuid/{team_uuid}`

## Usage

``` r
sportality_roster(team_uuid)
```

## Arguments

- team_uuid:

  (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the
  schedule or `teamList[].uuid`. Key space: platform team uuids (not the
  numeric Genius team id).

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_roster")`) and in the
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
  try(sportality_roster(team_uuid = "rfo82vr830"))
#> ── Basketligaen Team Roster from basketligaen.dk ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:54:51 UTC
#> # A tibble: 14 × 13
#>    position position_code player_type gender uuid       first_name    last_name 
#>    <chr>    <chr>         <chr>       <chr>  <chr>      <chr>         <chr>     
#>  1 Guards   G             athlete     male   cj81dc09w3 Malthe        Aabling   
#>  2 Guards   G             athlete     male   cjcrt5hlho Bryceson      Burns     
#>  3 Guards   G             athlete     male   dmon8irp4j Maxim         Shinkarev 
#>  4 Guards   G             athlete     male   hnrg2dqjcu Oskar Harring Østoft    
#>  5 Guards   G             athlete     male   k1nh3mnqzp Julius        Aabling   
#>  6 Guards   G             athlete     male   khm59ormd2 Sebastian     Reumert   
#>  7 Guards   G             athlete     male   q87tbjqicc Bertil        Anneberg …
#>  8 Guards   G             athlete     male   wtpfbry97z Karl          Heming    
#>  9 Guards   G             athlete     male   zu0qp4mq65 Anders        Jellesmark
#> 10 Forwards F             athlete     male   fjn17iovmg August        Heming    
#> 11 Forwards F             athlete     male   m8ajfnag3m Caden         Fry       
#> 12 Centers  C             athlete     male   fyeh5w7iar Oskar Fløng   Vanner    
#> 13 Centers  C             athlete     male   mqers10jtj Daniel        Stubkjær  
#> 14 Centers  C             athlete     male   wz2bk7trd4 Visti         Thomsen   
#> # ℹ 6 more variables: full_name <chr>, nationality <chr>, jersey_number <int>,
#> #   portrait_url <chr>, height <int>, weight <int>
# }
```
