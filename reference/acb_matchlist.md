# **Get ACB Match List**

The games of the round (or week) around a game.

One row per game. `home_wins` / `home_losses` / `away_wins` /
`away_losses` are the teams' series record in a playoff series (null
otherwise). `match_grouping` is `round` or `week`. `team_id` columns are
season-team entries; `club_id` is stable.

Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/matchlist`

## Usage

``` r
acb_matchlist(match_id, round_id = NULL, week_id = NULL)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

- round_id:

  (default `NULL`) Round id (integer): global across seasons, not the
  round number (6017 = Liga 2026-27 round 3). List them with
  `acb_competition_rounds` or `acb_calendar`. Omitted = the current (or
  last) round. A whole number; a whole double is accepted.

- week_id:

  (default `NULL`) Week id (integer): global across seasons (2989 = the
  week of 2026-10-10). List them with `acb_competition_weeks`. A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_matchlist")`) and in the searchable
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
  try(acb_matchlist(match_id = 105401))
#> ── ACB Match List from api2.acb.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:50:56 UTC
#> # A tibble: 9 × 31
#>   match_id round_type round_id round_number group_id subphase_id subphase_number
#>      <int> <chr>         <int>        <int>    <int>       <int>           <int>
#> 1   105393 LR             6017            3       NA          NA               0
#> 2   105394 LR             6017            3       NA          NA               0
#> 3   105395 LR             6017            3       NA          NA               0
#> 4   105396 LR             6017            3       NA          NA               0
#> 5   105397 LR             6017            3       NA          NA               0
#> 6   105398 LR             6017            3       NA          NA               0
#> 7   105399 LR             6017            3       NA          NA               0
#> 8   105400 LR             6017            3       NA          NA               0
#> 9   105401 LR             6017            3       NA          NA               0
#> # ℹ 24 more variables: week_id <int>, status <chr>, is_on_half_time <lgl>,
#> #   current_quarter <int>, home_score <int>, away_score <int>, start <dttm>,
#> #   home_wins <int>, home_losses <int>, away_wins <int>, away_losses <int>,
#> #   home_team_id <int>, home_club_id <int>, home_team <chr>,
#> #   home_team_abbr <chr>, away_team_id <int>, away_club_id <int>,
#> #   away_team <chr>, away_team_abbr <chr>, competition_id <int>,
#> #   edition_id <int>, season <int>, is_selected_local <lgl>, …
# }
```
