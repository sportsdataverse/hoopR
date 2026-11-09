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

A `hoopR_data` tibble: Clubs (sites) taking part in an ssgt. An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sportsdataverse-py `sportality_sites`), then any column
the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| id | character | Site instance id of the club (platform key space; the same as instanceId). |
| instance_id | character | Site instance id of the club or league (platform key space, `<code><n>_<code>` such as hol2_hol; the league itself is dbl1_dbl). |
| public_url | character | The club's own website. |
| name | character | Display name of the club. |
| icon | character | Team logo URL (SVG on sportality.cdn.s8y.se). |

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
