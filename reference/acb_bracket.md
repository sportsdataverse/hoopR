# **Get ACB Bracket**

Playoff bracket: one row per series (quarter-final, semifinal, final).

One row per series; `stage` is quarter_finals, semifinals or final.
`home_wins` / `away_wins` are the series score, `best_of` the series
length, `n_games` the games listed. An edition with no playoffs yet
raises `hoopR_no_data`.

Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/bracket`

## Usage

``` r
acb_bracket(competition_id = NULL, season = NULL)
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

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_bracket`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| stage | character | Bracket stage: quarter_finals, semifinals, final (other_positions when present). |
| phase_id | integer | Phase id of the series (111 = Play Off Titulo). |
| subphase_id | integer | Sub-phase id (the playoff stage). |
| home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| home_team | character | Team name that season (sponsor names change) |
| home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| away_team | character | Team name that season (sponsor names change) |
| away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| home_wins | integer | Games won by the home-court team in the series. |
| away_wins | integer | Games won by the other team in the series. |
| finished | logical | True once the series is decided. |
| best_of | integer | Series length (best of N). |
| n_games | integer | Games listed for the series. |
| edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |

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
  try(acb_bracket(season = 2026))
#> ── ACB Bracket from api2.acb.com ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:02:23 UTC
#> # A tibble: 7 × 18
#>   stage  phase_id subphase_id home_team_id home_club_id home_team home_team_abbr
#>   <chr>     <int>       <int>        <int>        <int> <chr>     <chr>         
#> 1 quart…      111         293         4388            9 Real Mad… RMB           
#> 2 quart…      111         293         4393           12 UCAM Mur… UCM           
#> 3 quart…      111         293         4397           13 Valencia… VBC           
#> 4 quart…      111         293         4398            3 Kosner B… BKN           
#> 5 semif…      111         292         4386            2 Barça     BAR           
#> 6 semif…      111         292         4397           13 Valencia… VBC           
#> 7 final       111         291         4397           13 Valencia… VBC           
#> # ℹ 11 more variables: away_team_id <int>, away_club_id <int>, away_team <chr>,
#> #   away_team_abbr <chr>, home_wins <int>, away_wins <int>, finished <lgl>,
#> #   best_of <int>, n_games <int>, edition_id <int>, season <int>
# }
```
