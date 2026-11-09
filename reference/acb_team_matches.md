# **Get ACB Team Matches**

A club's games in a competition edition.

One row per game, with `is_selected_local` true when the club played at
home.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/team-matches`

## Usage

``` r
acb_team_matches(club_id, competition_id = NULL, season = NULL)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_matches")`) and in the
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
  try(acb_team_matches(club_id = 2, season = 2027))
#> ── ACB Team Matches from api2.acb.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:51:08 UTC
#> # A tibble: 34 × 30
#>    match_id round_type round_id round_number group_id subphase_id
#>       <int> <chr>         <int>        <int>    <int>       <int>
#>  1   105377 LR             6015            1       NA          NA
#>  2   105392 LR             6016            2       NA          NA
#>  3   105401 LR             6017            3       NA          NA
#>  4   105410 LR             6018            4       NA          NA
#>  5   105414 LR             6019            5       NA          NA
#>  6   105428 LR             6020            6       NA          NA
#>  7   105432 LR             6021            7       NA          NA
#>  8   105444 LR             6022            8       NA          NA
#>  9   105454 LR             6023            9       NA          NA
#> 10   105460 LR             6024           10       NA          NA
#> # ℹ 24 more rows
#> # ℹ 24 more variables: subphase_number <int>, week_id <int>, status <chr>,
#> #   is_on_half_time <lgl>, current_quarter <int>, home_score <int>,
#> #   away_score <int>, start <dttm>, home_wins <int>, home_losses <int>,
#> #   away_wins <int>, away_losses <int>, home_team_id <int>, home_club_id <int>,
#> #   home_team <chr>, home_team_abbr <chr>, away_team_id <int>,
#> #   away_club_id <int>, away_team <chr>, away_team_abbr <chr>, …
# }
```
