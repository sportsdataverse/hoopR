# **Get ACB Competition Weeks**

The weeks of every competition edition: the week ids to crawl.

One row per edition and week: the global `week_id`, the Spanish
`description` ('Semana 1') and the Monday `start_date`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_weeks(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_competition_weeks`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| edition_id | integer | Season id the week belongs to (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
| description | character | Spanish week label ('Semana 1'). |
| start_date | POSIXct | Monday the week starts (UTC midnight). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_competition_weeks()

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
