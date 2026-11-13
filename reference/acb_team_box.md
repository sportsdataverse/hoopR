# **Get ACB Team Box**

Team totals of a game per period: everything the team did, and the part
credited to the team itself.

Two rows per team and period: `scope` `total` is everything the team did
(its players plus the team's own events), `team` is the part credited to
the team itself rather than a player (team rebounds, team turnovers).
`quarter` 0 is the whole game.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_team_box(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_box")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(acb_team_box(match_id = 105401))
#> ── ACB Team Box from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:12:35 UTC
#> # A tibble: 20 × 30
#>    match_id edition_id season team_side team_id club_id team   team_abbr quarter
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr>  <chr>       <int>
#>  1   105401         91   2027 home         4467       2 Barça  BAR             0
#>  2   105401         91   2027 home         4467       2 Barça  BAR             0
#>  3   105401         91   2027 home         4467       2 Barça  BAR             1
#>  4   105401         91   2027 home         4467       2 Barça  BAR             1
#>  5   105401         91   2027 home         4467       2 Barça  BAR             2
#>  6   105401         91   2027 home         4467       2 Barça  BAR             2
#>  7   105401         91   2027 home         4467       2 Barça  BAR             3
#>  8   105401         91   2027 home         4467       2 Barça  BAR             3
#>  9   105401         91   2027 home         4467       2 Barça  BAR             4
#> 10   105401         91   2027 home         4467       2 Barça  BAR             4
#> 11   105401         91   2027 away         4472      13 Valen… VBC             0
#> 12   105401         91   2027 away         4472      13 Valen… VBC             0
#> 13   105401         91   2027 away         4472      13 Valen… VBC             1
#> 14   105401         91   2027 away         4472      13 Valen… VBC             1
#> 15   105401         91   2027 away         4472      13 Valen… VBC             2
#> 16   105401         91   2027 away         4472      13 Valen… VBC             2
#> 17   105401         91   2027 away         4472      13 Valen… VBC             3
#> 18   105401         91   2027 away         4472      13 Valen… VBC             3
#> 19   105401         91   2027 away         4472      13 Valen… VBC             4
#> 20   105401         91   2027 away         4472      13 Valen… VBC             4
#> # ℹ 21 more variables: scope <chr>, points <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, two_pointers_made <int>,
#> #   two_pointers_attempted <int>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, assists <int>, off_rebounds <int>,
#> #   def_rebounds <int>, total_rebounds <int>, steals <int>, turnovers <int>,
#> #   blocks <int>, received_blocks <int>, dunks <int>, personal_fouls <int>,
#> #   fouls_drawn <int>, plus_minus <int>, rating <int>
# }
```
