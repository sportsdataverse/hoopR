# **Get VTB Infobasket Team**

Club profile: names, region, country, status.

Endpoint: `GET https://org.infobasket.su/Widget/TeamPage/{team_id}`

## Usage

``` r
vtb_infobasket_team(team_id, lang = "en", tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

- lang:

  Label language (en or ru). Most bodies carry both languages whatever
  is asked; the leader categories' labels follow it.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble: Club profile: names, region, country, status. The
columns are always these, in this order (sportsdataverse-py
`vtb_infobasket_team`); an empty valid answer raises `hoopR_no_data`, a
valid body with no rows for this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. The scope check compares it with the request. |
| team_type | integer | Team type code: 1 on the club record. |
| team_name_ru | character | Club name, Russian. |
| team_name_en | character | Club name, English. |
| team_short_name_ru | character | Club short name, Russian. |
| team_short_name_en | character | Club short name, English. |
| team_abc_name_ru | character | Club abbreviation, Russian (the full name in the sample). |
| team_abc_name_en | character | Club abbreviation, English. |
| team_gender | integer | Team gender code: 0 on every sample (men). |
| team_region | integer | Infobasket region id of the club's city. |
| team_country | integer | Country id of the club (1 = Russia, unverified). |
| team_logo | integer | Logo flag; 0 in the samples. |
| team_uniform1 | integer | First uniform colour code. |
| team_uniform2 | integer | Second uniform colour code. |
| team_status | integer | Club record status (1 active). |
| team_record_id | integer | Id of the club-record name (CurrentTeamName.TeamID, 2259 for team 2650): a different key space from team_id. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_team(team_id = 2650))
#> ── VTB Infobasket Team from org.infobasket.su ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:10:15 UTC
#> # A tibble: 1 × 16
#>   team_id team_type team_name_ru     team_name_en    team_short_name_ru
#>     <int>     <int> <chr>            <chr>           <chr>             
#> 1    2650         1 Локомотив-Кубань Lokomotiv Kuban Локомотив-Кубань  
#> # ℹ 11 more variables: team_short_name_en <chr>, team_abc_name_ru <chr>,
#> #   team_abc_name_en <chr>, team_gender <int>, team_region <int>,
#> #   team_country <int>, team_logo <int>, team_uniform1 <int>,
#> #   team_uniform2 <int>, team_status <int>, team_record_id <int>
# }
```
