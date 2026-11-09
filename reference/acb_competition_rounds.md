# **Get ACB Competition Rounds**

The rounds of every competition edition: the round ids to crawl.

One row per edition and round: the global `round_id` (the key of the
round routes), `round_number` within the phase and the sub-phase.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_rounds(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_competition_rounds`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id the round belongs to (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
| round_number | integer | Round number within the phase |
| subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
| subphase_number | integer | Sub-phase number; null in the regular season |

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
  try(acb_competition_rounds())
#> Error in acb_competition_rounds() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
