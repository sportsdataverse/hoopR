# **RealGM NBA Draft Results**

**Get the results of a past NBA draft from RealGM
(basketball.realgm.com).**

One row per selection (rounds 1 and 2, labelled by `round`) plus the
listed undrafted players (`round = NA`), including pre-draft team /
international club, age, years of service and nationality.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft(year = most_recent_nba_season() - 1L)
```

## Arguments

- year:

  Draft year (the calendar year the draft was held). Defaults to the
  most recently completed draft (`most_recent_nba_season() - 1`).

## Value

A `hoopR_data` tibble carrying `draft_year` and `round` columns:

|                |           |                                            |
|----------------|-----------|--------------------------------------------|
| col_name       | types     | description                                |
| pick           | integer   | Overall pick number (`NA` for undrafted).  |
| player         | character | Player name.                               |
| team           | character | Drafting team abbreviation.                |
| draft_trades   | character | Draft-night trade note, if any.            |
| pos            | character | Position.                                  |
| ht             | character | Listed height.                             |
| wt             | integer   | Listed weight (lbs).                       |
| age            | numeric   | Age at draft.                              |
| yos            | integer   | Years of service since.                    |
| pre_draft_team | character | Pre-draft team / school / club.            |
| class          | character | College class / draft eligibility note.    |
| nationality    | character | Player nationality.                        |
| round          | integer   | Draft round (`1`, `2`, or `NA` undrafted). |
| draft_year     | numeric   | Draft year (echoes `year`).                |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_draft(year = 2020))
} # }
```
