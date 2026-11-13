# **Get LBA Team Box Score**

Team lines of a final game's box score: the team-booked stats and the
totals of each side.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id`
(`info=true&id=<game_id>`)

## Usage

``` r
lba_team_box_score(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_team_box_score")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(lba_team_box_score(game_id = 25602))
#> ── LBA Team Box Score from legabasket.it ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:17:12 UTC
#> # A tibble: 4 × 32
#>   game_id season side    team_id row_type   pun falli_c falli_sf falli_tc1
#>     <int>  <int> <chr>     <int> <chr>    <int>   <int>    <int>     <int>
#> 1   25602   2027 home       1764 team         0       0        0         0
#> 2   25602   2027 home       1764 totals     109      21       27         0
#> 3   25602   2027 visitor    1761 team         0       0        0         0
#> 4   25602   2027 visitor    1761 totals      94      27       21         0
#> # ℹ 23 more variables: falli_fla <int>, rimbalzi_o <int>, rimbalzi_d <int>,
#> #   rimbalzi_t <int>, palle_p <int>, palle_r <int>, val_lega <int>, min <int>,
#> #   sec <int>, t2_r <int>, t2_t <int>, t2_perc <dbl>, sc <int>, t3_r <int>,
#> #   t3_t <int>, t3_perc <dbl>, tl_r <int>, tl_t <int>, tl_perc <dbl>,
#> #   stoppate_dat <int>, stoppate_sub <int>, ass <int>, val_oer <dbl>
# }
```
