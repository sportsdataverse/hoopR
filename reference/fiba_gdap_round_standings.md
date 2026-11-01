# **FIBA GDAP: round standings**

Group standings of every round of a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`

## Usage

``` r
fiba_gdap_round_standings(comp, return_parsed = TRUE)
```

## Arguments

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| round_id | integer | Round id (Int64) the group belongs to. |
| round_name | character | Round name (Preliminary Round, Final Round...). |
| round_code | character | Round code (a short code such as G or F). |
| group_name | character | Group name within the round (A, B...). |
| group_status_code | character | Group status code (COMPL when the group is complete). |
| rank | integer | Rank in the group. |
| team_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| team_organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| team_code | character | Team code (FIBA country code or club abbreviation). |
| team_official_name | character | Official team name (the country for a national team, the club for a club team). |
| team_short_name | character | Short team name: the country code for a national team, the club's short name for a club. |
| games_played | integer | Games played in the group. |
| games_lost | integer | Losses in the group. |
| games_won | integer | Wins in the group. |
| points | integer | Standing points (2 per win, 1 per loss). |
| points_against | integer | Points conceded. |
| points_for | integer | Points the team scored in the group's games. |
| starting_position | integer | Seed / draw position in the group. |
| final_position | integer | Final position in the group. |
| plus_minus | integer | Point differential (pointsFor - pointsAgainst). |
| penalty_points | integer | Standing points deducted. |
| draw_points | integer | Points for a draw (0); null when not applicable. |
| group_game_results | character | This team's games in the group. Stored as a JSON string. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

## See also

Other FIBA Functions:
[`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md),
[`fiba_gamepage_box_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_teams.md),
[`fiba_gamepage_lineup()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_lineup.md),
[`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md),
[`fiba_gamepage_period_scores()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_period_scores.md),
[`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md),
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md),
[`fiba_gdap_competition()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_competition.md),
[`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md),
[`fiba_gdap_federation_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_games.md),
[`fiba_gdap_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_federation_ranking.md),
[`fiba_gdap_final_standings()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_final_standings.md),
[`fiba_gdap_game()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game.md),
[`fiba_gdap_game_officials()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_officials.md),
[`fiba_gdap_game_periods()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_game_periods.md),
[`fiba_gdap_games_between()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_games_between.md),
[`fiba_gdap_gateway_competition_ids()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_competition_ids.md),
[`fiba_gdap_gateway_federation_ranking()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_gateway_federation_ranking.md),
[`fiba_gdap_medal_count()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_medal_count.md),
[`fiba_gdap_national_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_national_teams.md),
[`fiba_gdap_nominations()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_nominations.md),
[`fiba_gdap_player_game_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_game_stats.md),
[`fiba_gdap_player_info()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_info.md),
[`fiba_gdap_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_player_stats.md),
[`fiba_gdap_ranking_zones()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_ranking_zones.md),
[`fiba_gdap_roster()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster.md),
[`fiba_gdap_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_coaches.md),
[`fiba_gdap_roster_latest()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_roster_latest.md),
[`fiba_gdap_round_gamedays()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_round_gamedays.md),
[`fiba_gdap_rounds()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_rounds.md),
[`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md),
[`fiba_gdap_team_games()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_games.md),
[`fiba_gdap_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_player_stats.md),
[`fiba_gdap_team_staff()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_staff.md),
[`fiba_gdap_team_stats()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_team_stats.md),
[`fiba_gdap_teams()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_teams.md)

## Examples

``` r
# \donttest{
  try(fiba_gdap_round_standings(comp = 208182))
#> ── FIBA gdap_round_standings from fiba.basketball ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:47:49 UTC
#> # A tibble: 88 × 23
#>    round_id round_name  round_code group_name group_status_code  rank
#>       <int> <chr>       <chr>      <chr>      <chr>             <int>
#>  1    25276 First Round FR         A          COMPL                 1
#>  2    25276 First Round FR         A          COMPL                 2
#>  3    25276 First Round FR         A          COMPL                 3
#>  4    25276 First Round FR         A          COMPL                 4
#>  5    25276 First Round FR         B          COMPL                 1
#>  6    25276 First Round FR         B          COMPL                 2
#>  7    25276 First Round FR         B          COMPL                 3
#>  8    25276 First Round FR         B          COMPL                 4
#>  9    25276 First Round FR         C          COMPL                 1
#> 10    25276 First Round FR         C          COMPL                 2
#> # ℹ 78 more rows
#> # ℹ 17 more variables: team_team_id <int>, team_organisation_id <int>,
#> #   team_code <chr>, team_official_name <chr>, team_short_name <chr>,
#> #   games_played <int>, games_lost <int>, games_won <int>, points <int>,
#> #   points_against <int>, points_for <int>, starting_position <int>,
#> #   final_position <int>, plus_minus <int>, penalty_points <int>,
#> #   draw_points <int>, group_game_results <chr>
# }
```
