# **Get ACB Competition Editions**

Every competition edition (season) the API knows, one row per edition.

One row per competition and edition: `edition_id` (START year - 1935),
`season_start_year` and `season` (END year), plus how many rounds and
weeks the edition lists. `competition_name` is the API's name for the
competition (the Liga is `Liga Nacional` here).

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`

## Usage

``` r
acb_competition_editions(competition_ids = NULL)
```

## Arguments

- competition_ids:

  (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for
  several. Omitted = the API's default competition. One or more whole
  numbers (a vector repeats `competitionIds` in the query).

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_competition_editions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
| competition_name | character | The API's competition name ('Liga Nacional' for the Liga). |
| edition_id | integer | Season id (START year - 1935). |
| season_start_year | integer | Calendar year the season starts (2026 for 2026-27). |
| season | integer | Season END year (2027 for 2026-27) = seasonEndYear. |
| n_rounds | integer | Rounds the edition lists. |
| n_weeks | integer | Weeks the edition lists. |

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
  try(acb_competition_editions())
#> Error in acb_competition_editions() : 
#>   api2.acb.com/api/matchdata/Menu/competition-data: the answer holds no
#> rows (competitions is empty).
# }
```
