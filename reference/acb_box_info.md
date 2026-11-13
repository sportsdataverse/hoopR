# **Get ACB Box Info**

Coaches and game facts per team: head coach, assistants, arena,
attendance, referees.

One row per team. `arena`, `attendance` and `referees` (joined with
`'; '`) describe the game and repeat on both rows; `assistant_coaches`
is joined with `'; '`.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_box_info(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_box_info")`) and in the searchable
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
  try(acb_box_info(match_id = 105401))
#> ── ACB Box Info from api2.acb.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:12:16 UTC
#> # A tibble: 2 × 13
#>   match_id edition_id season team_side team_id club_id team            team_abbr
#>      <int>      <int>  <int> <chr>       <int>   <int> <chr>           <chr>    
#> 1   105401         91   2027 home         4467       2 Barça           BAR      
#> 2   105401         91   2027 away         4472      13 Valencia Basket VBC      
#> # ℹ 5 more variables: head_coach <chr>, assistant_coaches <chr>, arena <chr>,
#> #   attendance <int>, referees <chr>
# }
```
