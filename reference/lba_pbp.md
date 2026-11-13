# **Get LBA Play-by-Play**

Play-by-play of a final game (2017-18 on), one row per action with x/y;
coordinate frame by era.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play`
(`info=true&sort=asc&id=<game_id>`)

## Usage

``` r
lba_pbp(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per action with x/y. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_pbp")`) and in the searchable
[return
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
  try(lba_pbp(game_id = 25602))
#> ── LBA Play-by-Play from legabasket.it ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 14:00:01 UTC
#> # A tibble: 605 × 36
#>    game_id season home_team_id visitor_team_id team_side home_score
#>      <int>  <int>        <int>           <int> <chr>          <int>
#>  1   25602   2027         1764            1761 NA                 0
#>  2   25602   2027         1764            1761 home               0
#>  3   25602   2027         1764            1761 home               0
#>  4   25602   2027         1764            1761 home               0
#>  5   25602   2027         1764            1761 home               0
#>  6   25602   2027         1764            1761 home               0
#>  7   25602   2027         1764            1761 home               0
#>  8   25602   2027         1764            1761 visitor            0
#>  9   25602   2027         1764            1761 visitor            0
#> 10   25602   2027         1764            1761 visitor            0
#> # ℹ 595 more rows
#> # ℹ 30 more variables: visitor_score <int>, coord_frame <chr>, action_id <int>,
#> #   description <chr>, player_id <int>, team_id <int>, home_club <int>,
#> #   in_area <lgl>, dunk <int>, seconds <int>, minute <int>, period <int>,
#> #   order <int>, side <int>, x <int>, y <int>, score <chr>,
#> #   linked_action_id <int>, print_time <chr>, action_1_qualifier_code <chr>,
#> #   action_2_qualifier_code <chr>, action_1_qualifier_description <chr>, …
# }
```
