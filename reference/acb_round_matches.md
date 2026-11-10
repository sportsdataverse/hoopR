# **Get ACB Round Matches**

Games of one round (or week) with scores, status and broadcasters.

One row per game. A round route returns the whole round, postponed games
included. `broadcasters` joins the channel names with `'; '`. The team
columns are looked up in the body's team list; `week_id` is the selected
week.

Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/matches`

## Usage

``` r
acb_round_matches(
  competition_id = NULL,
  season = NULL,
  round_id = NULL,
  week_id = NULL,
  is_round_selected = NULL
)
```

## Arguments

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

- round_id:

  (default `NULL`) Round id (integer): global across seasons, not the
  round number (6017 = Liga 2026-27 round 3). List them with
  `acb_competition_rounds` or `acb_calendar`. Omitted = the current (or
  last) round. A whole number; a whole double is accepted.

- week_id:

  (default `NULL`) Week id (integer): global across seasons (2989 = the
  week of 2026-10-10). List them with `acb_competition_weeks`. A whole
  number; a whole double is accepted.

- is_round_selected:

  (default `NULL`) With week_id: false = the games played that week
  across rounds; true resolves the week to one round. `TRUE` or `FALSE`,
  sent as `true` / `false`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_round_matches")`) and in the
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
  try(acb_round_matches(round_id = 6017, season = 2027))
#> ── ACB Round Matches from api2.acb.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:58:04 UTC
#> # A tibble: 9 × 25
#>   competition_id edition_id season round_id round_number subphase_id
#>            <int>      <int>  <int>    <int>        <int>       <int>
#> 1              1         91   2027     6017            3          NA
#> 2              1         91   2027     6017            3          NA
#> 3              1         91   2027     6017            3          NA
#> 4              1         91   2027     6017            3          NA
#> 5              1         91   2027     6017            3          NA
#> 6              1         91   2027     6017            3          NA
#> 7              1         91   2027     6017            3          NA
#> 8              1         91   2027     6017            3          NA
#> 9              1         91   2027     6017            3          NA
#> # ℹ 19 more variables: subphase_number <int>, week_id <int>, match_id <int>,
#> #   home_team_id <int>, away_team_id <int>, home_score <int>, away_score <int>,
#> #   start <dttm>, status <chr>, is_on_half_time <lgl>, current_quarter <int>,
#> #   home_club_id <int>, home_team <chr>, home_team_abbr <chr>,
#> #   away_club_id <int>, away_team <chr>, away_team_abbr <chr>,
#> #   ticketing_link <chr>, broadcasters <chr>
# }
```
