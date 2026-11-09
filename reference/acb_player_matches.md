# **Get ACB Player Matches**

A player's game log for an edition (default: the current one).

One row per game. `has_won` is true when the player's team won;
`is_selected_local` is true when it played at home. `play_time` is
`'mm:ss'` (`seconds_played` in seconds). Percentages are Float64, the
rest counts. Names follow the player-route vocabulary (`rebounds`,
`shots_rejected`, `fouls_received`).

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/matches`

## Usage

``` r
acb_player_matches(player_id, season = NULL)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_matches")`) and in the
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
  try(acb_player_matches(player_id = 20209407, season = 2027))
#> ── ACB Player Matches from api2.acb.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:08:53 UTC
#> # A tibble: 7 × 42
#>   player_id match_id round_type round_number date                home_team_id
#>       <int>    <int> <chr>             <int> <dttm>                     <int>
#> 1  20209407   105383 LR                    1 2026-09-27 17:00:00         4476
#> 2  20209407   105389 LR                    2 2026-10-04 10:30:00         4479
#> 3  20209407   105397 LR                    3 2026-10-11 10:00:00         4476
#> 4  20209407   105407 LR                    4 2026-10-18 10:30:00         4476
#> 5  20209407   105419 LR                    5 2026-10-25 18:00:00         4465
#> 6  20209407   105425 LR                    6 2026-11-01 11:30:00         4476
#> 7  20209407   105437 LR                    7 2026-11-08 18:00:00         4476
#> # ℹ 36 more variables: home_club_id <int>, home_team <chr>,
#> #   home_team_abbr <chr>, away_team_id <int>, away_club_id <int>,
#> #   away_team <chr>, away_team_abbr <chr>, edition_id <int>, season <int>,
#> #   is_selected_local <lgl>, has_won <lgl>, play_time <chr>,
#> #   seconds_played <int>, points <int>, three_pointers_made <int>,
#> #   three_pointers_attempted <int>, three_pointers_percentage <dbl>,
#> #   two_pointers_made <int>, two_pointers_attempted <int>, …
# }
```
