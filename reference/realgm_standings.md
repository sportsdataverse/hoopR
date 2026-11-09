# **RealGM NBA Standings**

**Get the current NBA standings (both conferences) from RealGM
(basketball.realgm.com).**

One row per team with record, win pct, games back, streak, last-ten,
scoring margin and home/away/division/conference splits. The Eastern and
Western conference tables are stacked and labelled by a `conference`
column.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_standings()
```

## Value

A `hoopR_data` tibble with one row per team:

|            |           |                           |
|------------|-----------|---------------------------|
| col_name   | types     | description               |
| number     | integer   | Conference rank.          |
| team       | character | Team name.                |
| w          | integer   | Wins.                     |
| l          | integer   | Losses.                   |
| pct        | numeric   | Win percentage.           |
| gb         | numeric   | Games back.               |
| l10        | character | Last-ten record.          |
| strk       | character | Current streak.           |
| ppg        | numeric   | Points per game.          |
| oppg       | numeric   | Opponent points per game. |
| diff       | numeric   | Scoring margin.           |
| home       | character | Home record.              |
| away       | character | Away record.              |
| conference | character | `Eastern` or `Western`.   |

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_standings())
} # }
```
