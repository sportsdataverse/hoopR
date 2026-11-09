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

A `hoopR_data` tibble: One team. An empty valid answer raises
`hoopR_no_data`; the documented columns come first, in this order
(sportsdataverse-py `sportality_team`), then any column the API added
later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| names_code | character | Three-letter team code (HOL, RAN ...); codes changed between seasons for some clubs (BAK in 2026, BKA in 2025 for Bakken Bears). |
| names_short | character | Short name of the team. |
| names_long | character | Long name of the team. |
| names_full | character | Full name of the team. |
| names_code_site | character | Team code as the club's own site shows it. |
| names_short_site | character | Short team name as the club's own site shows it. |
| names_full_site | character | Full team name as the club's own site shows it. |
| names_long_site | character | Long team name as the club's own site shows it. |
| info | character | Detail record (shape depends on the route; see the child columns). |
| uuid | character | Platform uuid of this record (10-character lowercase key space of its record type; joins the route that serves it). |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| arena_name | character | Name of the arena. |
| public_url | character | The club's own website. |
| icon | character | Team logo URL (SVG on sportality.cdn.s8y.se). |
| owner_instance_id | character | Site instance id of the club that owns the team (platform key space, e.g. hol2_hol). |
| site_display_name | character | Team name as the league site displays it. |

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
#> ℹ Data updated: 2026-11-09 12:08:55 UTC
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
