# **Get ACB Competition Current**

The API's current pointers: competition, edition, week, round and match.

One row: the ids the site opens by default, and the current match with
its teams.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_current(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_competition_current`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition the site opens by default. |
| edition_id | integer | Edition (season) the site opens by default. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| week_id | integer | Week the site opens by default. |
| round_id | integer | Round the site opens by default. |
| match_grouping | character | round or week (current pointers) |
| match_id | integer | The current match (the featured game). |
| status | character | State of the current match. |
| start | POSIXct | Tip-off instant (UTC) of the current match. |
| home_team_id | integer | Home season-team entry id of the current match. |
| home_club_id | integer | Home stable club id of the current match. |
| home_team | character | Home team name of the current match. |
| home_team_abbr | character | Home team abbreviation of the current match. |
| away_team_id | integer | Away season-team entry id of the current match. |
| away_club_id | integer | Away stable club id of the current match. |
| away_team | character | Away team name of the current match. |
| away_team_abbr | character | Away team abbreviation of the current match. |

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
  try(acb_competition_current())
#> Error in acb_competition_current() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
