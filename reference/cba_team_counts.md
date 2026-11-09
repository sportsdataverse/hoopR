# **Get CBA Team Counts**

Team counts of one season, keyed by match type.

Endpoint: `GET https://data-server.cbaleague.com/api/team-count/season`

## Usage

``` r
cba_team_counts(season)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

## Value

A `hoopR_data` tibble: One row per match type. An empty valid answer is
a zero-row tibble with these columns, in this order (sportsdataverse-py
`cba_team_counts`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| key | character | Match type id as a string ('1' regular season, '2' playoffs); see getMatchType. |
| value | integer | Number of teams in that match type in the requested season (inferred: 20 for key '1' in 2025, equal to the 2025 getTeam list length; the playoff count is smaller). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

     cba_team_counts(season = 2026)

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.
