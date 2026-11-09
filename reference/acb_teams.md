# **Get ACB Teams**

Teams entered in a competition edition.

One row per team: the entry of the selected edition (`team_id`, new
every season) and the club's latest entry (`latest_team_id`). `club_id`
is the stable key.

Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/teams`

## Usage

``` r
acb_teams(competition_id = NULL, season = NULL)
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

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_teams")`) and in the searchable
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
  try(acb_teams(season = 2027))
#> ── ACB Teams from api2.acb.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:10:40 UTC
#> # A tibble: 18 × 9
#>    team_id club_id team               team_abbr competition_id edition_id season
#>      <int>   <int> <chr>              <chr>              <int>      <int>  <int>
#>  1    4473       8 Asisa Joventut     JOV                    1         91   2027
#>  2    4467       2 Barça              BAR                    1         91   2027
#>  3    4474      16 Casademont Zarago… CAZ                    1         91   2027
#>  4    4470     591 FIATC Girona       GIR                    1         91   2027
#>  5    4465     658 iLERNA Lleida      ILE                    1         91   2027
#>  6    4471      10 Kids&Us Manresa    K&U                    1         91   2027
#>  7    4463       3 Kosner Baskonia    BKN                    1         91   2027
#>  8    4478      28 La Laguna Tenerife LLT                    1         91   2027
#>  9    4480     657 Leyma Coruña       COR                    1         91   2027
#> 10    4479      57 Monbus Obradoiro   MOB                    1         91   2027
#> 11    4466      22 MoraBanc Andorra   MBA                    1         91   2027
#> 12    4476       9 Real Madrid        RMB                    1         91   2027
#> 13    4469     549 Recoletas Salud S… BUR                    1         91   2027
#> 14    4464      25 Río Breogán        BRE                    1         91   2027
#> 15    4475       4 Surne Bilbao       SBB                    1         91   2027
#> 16    4468      12 UCAM Murcia        UCM                    1         91   2027
#> 17    4477      14 Unicaja            UNI                    1         91   2027
#> 18    4472      13 Valencia Basket    VBC                    1         91   2027
#> # ℹ 2 more variables: latest_team_id <int>, latest_team <chr>
# }
```
