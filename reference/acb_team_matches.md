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

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_team_matches`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
| round_type | character | Phase code: LR = Liga Regular (regular season), PO = playoffs (a bundle value, not in the samples); null on every row of /Menu/competition-data and /TeamProfile/next-matches |
| round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
| round_number | integer | Round number within the phase |
| group_id | integer | Group id in group-stage competitions |
| subphase_id | integer | Sub-phase id of the round (playoff stages); null in the regular season. |
| subphase_number | integer | Sub-phase number of the round; null in the regular season. |
| week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
| status | character | Match state (x-match-statuses) |
| is_on_half_time | logical | Not sent by this route (always null). |
| current_quarter | integer | Not sent by this route (always null). |
| home_score | integer | Home points (null before the match) |
| away_score | integer | Away points (null before the match) |
| start | POSIXct | Tip-off, ISO 8601 UTC |
| home_wins | integer | Not sent by this route (series records are in acb_matchlist). |
| home_losses | integer | Not sent by this route (series records are in acb_matchlist). |
| away_wins | integer | Not sent by this route (series records are in acb_matchlist). |
| away_losses | integer | Not sent by this route (series records are in acb_matchlist). |
| home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| home_team | character | Team name that season (sponsor names change) |
| home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| away_team | character | Team name that season (sponsor names change) |
| away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
| edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| is_selected_local | logical | True when the requested club played at home. |

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
#> ℹ Data updated: 2026-11-09 12:02:09 UTC
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
