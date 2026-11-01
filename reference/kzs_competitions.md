# **Get KZS Competitions**

Competitions of a season (leagues, cups, youth, 3x3, national teams), or
of every season.

Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/`

## Usage

``` r
kzs_competitions(season = NULL)
```

## Arguments

- season:

  Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque
  season id. Omitted = every season (627 competitions).

## Value

A `hoopR_data` tibble: Competitions of a season (leagues, cups, youth,
3x3, national teams), or of every season. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_competitions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
| name | character | Competition name, Slovenian; the sponsor name changes over the years (glossary in kzs-returns.md). |
| gender | character | MALE or FEMALE. |
| category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
| rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
| season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
| season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
| season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
| season_active | logical | Same as `isActive`. |
| type | character | Competition type (code table); absent on 2 competitions. |
| season | integer | The competition's season. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
[`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md),
[`kzs_pbp_players()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp_players.md),
[`kzs_period_scores()`](https://hoopR.sportsdataverse.org/reference/kzs_period_scores.md),
[`kzs_phases()`](https://hoopR.sportsdataverse.org/reference/kzs_phases.md),
[`kzs_player()`](https://hoopR.sportsdataverse.org/reference/kzs_player.md),
[`kzs_player_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_player_leaderboard.md),
[`kzs_player_stats()`](https://hoopR.sportsdataverse.org/reference/kzs_player_stats.md),
[`kzs_playing_days()`](https://hoopR.sportsdataverse.org/reference/kzs_playing_days.md),
[`kzs_roster()`](https://hoopR.sportsdataverse.org/reference/kzs_roster.md),
[`kzs_rounds()`](https://hoopR.sportsdataverse.org/reference/kzs_rounds.md),
[`kzs_score_changes()`](https://hoopR.sportsdataverse.org/reference/kzs_score_changes.md),
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md),
[`kzs_standings()`](https://hoopR.sportsdataverse.org/reference/kzs_standings.md),
[`kzs_team()`](https://hoopR.sportsdataverse.org/reference/kzs_team.md),
[`kzs_team_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_team_box_score.md),
[`kzs_team_general()`](https://hoopR.sportsdataverse.org/reference/kzs_team_general.md),
[`kzs_team_leaderboard()`](https://hoopR.sportsdataverse.org/reference/kzs_team_leaderboard.md),
[`kzs_teams()`](https://hoopR.sportsdataverse.org/reference/kzs_teams.md)

## Examples

``` r
# \donttest{
  try(kzs_competitions(season = 2026))
#> ── KZS Competitions from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:48:38 UTC
#> # A tibble: 44 × 11
#>    competition_id name               gender category rank  season_id season_name
#>             <int> <chr>              <chr>  <chr>    <chr>     <int> <chr>      
#>  1            579 Liga OTP banka     MALE   ABSOLUTE FIRST        26 2025/2026  
#>  2            553 Pripravljalne tek… MALE   ABSOLUTE FIRST        26 2025/2026  
#>  3            585 1. Ž SKL           FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  4            546 Pripravljalne tek… FEMALE ABSOLUTE FIRST        26 2025/2026  
#>  5            581 2. SKL             MALE   ABSOLUTE SECO…        26 2025/2026  
#>  6            582 3. SKL             MALE   ABSOLUTE THIRD        26 2025/2026  
#>  7            583 4. SKL             MALE   ABSOLUTE FOUR…        26 2025/2026  
#>  8            584 Pokal Spar         MALE   ABSOLUTE TOUR…        26 2025/2026  
#>  9            580 Superpokal         MALE   ABSOLUTE TOUR…        26 2025/2026  
#> 10            586 Pokal članice      FEMALE ABSOLUTE TOUR…        26 2025/2026  
#> # ℹ 34 more rows
#> # ℹ 4 more variables: season_is_active <lgl>, season_active <lgl>, type <chr>,
#> #   season <int>
# }
```
