# **Get LBA Calendar**

Games of one round of a championship: teams, score, venue, referees and
broadcasters.

Endpoint:
`GET https://www.legabasket.it/api/championships/get-championships-calendar-by-id`
(`id=<championship_id>&d=<round>`)

## Usage

``` r
lba_calendar(championship_id, round = NULL)
```

## Arguments

- championship_id:

  (required) Championship id (championship_id in lba_championships): one
  season AND one phase.

- round:

  Round number (day_serial, 1, 2, ...). Omitted = the current round (the
  last played for a finished championship).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_calendar")`) and in the searchable
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
  try(lba_calendar(championship_id = 602, round = 1))
#> ── LBA Calendar from legabasket.it ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:02:54 UTC
#> # A tibble: 8 × 38
#>   season game_id game_status championship_id championships_day_id  year number
#>    <int>   <int> <chr>                 <int>                <int> <int>  <int>
#> 1   2027   25602 2                       602                 4486  2026      1
#> 2   2027   25603 2                       602                 4486  2026      1
#> 3   2027   25605 2                       602                 4486  2026      1
#> 4   2027   25600 2                       602                 4486  2026      1
#> 5   2027   25601 2                       602                 4486  2026      1
#> 6   2027   25607 2                       602                 4486  2026      1
#> 7   2027   25604 2                       602                 4486  2026      1
#> 8   2027   25606 2                       602                 4486  2026      1
#> # ℹ 31 more variables: match_datetime <chr>, match_hh <int>, match_mm <int>,
#> #   home_final_score <int>, visitor_final_score <int>, target_score <chr>,
#> #   additional_time <int>, plant_id <int>, websocket_match_id <int>,
#> #   ticketing_url <chr>, has_streaming <int>, updated_at <chr>,
#> #   h_team_id <int>, h_team_name <chr>, h_club_code <chr>,
#> #   h_team_enabled <lgl>, home_logo_key <chr>, v_team_id <int>,
#> #   v_team_name <chr>, v_club_code <chr>, v_team_enabled <lgl>, …
# }
```
