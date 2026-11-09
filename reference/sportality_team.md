# **Get Basketligaen Team**

One team.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/teams/{team_uuid}`

## Usage

``` r
sportality_team(team_uuid)
```

## Arguments

- team_uuid:

  (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the
  schedule or `teamList[].uuid`. Key space: platform team uuids (not the
  numeric Genius team id).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_team")`) and in the
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
  try(sportality_team(team_uuid = "rfo82vr830"))
#> ── Basketligaen Team from basketligaen.dk ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:02 UTC
#> # A tibble: 1 × 16
#>   names_code names_short  names_long names_full names_code_site names_short_site
#>   <chr>      <chr>        <chr>      <chr>      <chr>           <chr>           
#> 1 HOL        Holbæk-Sten… Holbæk-St… Holbæk-St… HOL             Holbæk-Stenhus  
#> # ℹ 10 more variables: names_full_site <chr>, names_long_site <chr>,
#> #   info <chr>, uuid <chr>, nationality <chr>, arena_name <chr>,
#> #   public_url <chr>, icon <chr>, owner_instance_id <chr>,
#> #   site_display_name <chr>
# }
```
