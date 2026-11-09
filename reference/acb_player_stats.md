# **Get ACB Player Stats**

A player's season statistics, one row per team and edition.

One row per team-edition the player played: `total_*` counts, `avg_*`
averages and `per40_*` per-40 rates as in `acb_team_stats`.
`edition_year` is the label (`'2026-2027'`).

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/player-stats`

## Usage

``` r
acb_player_stats(player_id, competition_id = NULL, season = NULL)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year used as an UPPER bound: the rows keep
  the seasons up to this one (2026 drops the 2026-27 row). Omitted = all
  seasons. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team and edition. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_stats")`) and in the
searchable [return
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
  try(acb_player_stats(player_id = 20209407))
#> ── ACB Player Stats from api2.acb.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:10:32 UTC
#> # A tibble: 13 × 96
#>    player_id team_id competition_id edition_id season edition_year club_id team 
#>        <int>   <int>          <int>      <int>  <int> <chr>          <int> <chr>
#>  1  20209407    4476              1         91   2027 2026-2027          9 Real…
#>  2  20209407    4388              1         90   2026 2025-2026          9 Real…
#>  3  20209407    4345              1         89   2025 2024-2025          9 Real…
#>  4  20209407    4239              1         88   2024 2023-2024          9 Real…
#>  5  20209407    4149              1         87   2023 2022-2023          9 Real…
#>  6  20209407    3674              1         86   2022 2021-2022          9 Real…
#>  7  20209407    3387              1         85   2021 2020-2021          9 Real…
#>  8  20209407    3301              1         84   2020 2019-2020          9 Real…
#>  9  20209407    3212              1         83   2019 2018-2019          9 Real…
#> 10  20209407    3148              1         82   2018 2017-2018          9 Real…
#> 11  20209407    2980              1         79   2015 2014-2015          5 Herb…
#> 12  20209407    2940              1         78   2014 2013-2014          5 Herb…
#> 13  20209407    2870              1         77   2013 2012-2013          5 Gran…
#> # ℹ 88 more variables: team_abbr <chr>, total_num_games <int>,
#> #   total_time_played <int>, total_starter <int>, total_points <int>,
#> #   total_max_points <int>, total_three_pointers_made <int>,
#> #   total_three_pointers_attempted <int>,
#> #   total_three_pointers_percentage <dbl>, total_two_pointers_made <int>,
#> #   total_two_pointers_attempted <int>, total_two_pointers_percentage <dbl>,
#> #   total_free_throws_made <int>, total_free_throws_attempted <int>, …
# }
```
