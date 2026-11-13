# **Get ACB Standings**

League table after a round (default: the current round).

One row per team: position, record, points for and against, home and
away records. `round_id` is the round the table is as of; `total_rounds`
the rounds in the phase.

Endpoint:
`GET https://api2.acb.com/api/seasondata/Competition/standings`

## Usage

``` r
acb_standings(competition_id = NULL, season = NULL, round_id = NULL)
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

  (default `NULL`) Standings after this round. Round id (integer):
  global across seasons, not the round number (6017 = Liga 2026-27 round
  3). List them with `acb_competition_rounds` or `acb_calendar`. Omitted
  = the current (or last) round. A whole number; a whole double is
  accepted.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_standings")`) and in the searchable
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
  try(acb_standings(season = 2027))
#> ── ACB Standings from api2.acb.com ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:33:02 UTC
#> # A tibble: 18 × 22
#>    competition_id edition_id season round_id total_rounds team_id club_id team  
#>             <int>      <int>  <int>    <int>        <int>   <int>   <int> <chr> 
#>  1              1         91   2027     6021           34    4475       4 Surne…
#>  2              1         91   2027     6021           34    4471      10 Kids&…
#>  3              1         91   2027     6021           34    4466      22 MoraB…
#>  4              1         91   2027     6021           34    4479      57 Monbu…
#>  5              1         91   2027     6021           34    4467       2 Barça 
#>  6              1         91   2027     6021           34    4480     657 Leyma…
#>  7              1         91   2027     6021           34    4464      25 Río B…
#>  8              1         91   2027     6021           34    4473       8 Asisa…
#>  9              1         91   2027     6021           34    4469     549 Recol…
#> 10              1         91   2027     6021           34    4463       3 Kosne…
#> 11              1         91   2027     6021           34    4478      28 La La…
#> 12              1         91   2027     6021           34    4474      16 Casad…
#> 13              1         91   2027     6021           34    4470     591 FIATC…
#> 14              1         91   2027     6021           34    4468      12 UCAM …
#> 15              1         91   2027     6021           34    4472      13 Valen…
#> 16              1         91   2027     6021           34    4465     658 iLERN…
#> 17              1         91   2027     6021           34    4476       9 Real …
#> 18              1         91   2027     6021           34    4477      14 Unica…
#> # ℹ 14 more variables: team_abbr <chr>, position <int>, position_trend <int>,
#> #   played <int>, wins <int>, losses <int>, win_pct <dbl>, points_for <int>,
#> #   points_against <int>, plus_minus <int>, home_wins <int>, home_losses <int>,
#> #   away_wins <int>, away_losses <int>
# }
```
