# **Genius Team Crosswalk**

Sportality platform team uuid \<-\> Genius team id, from a Sportality
frame that carries both.

The Genius ids are the ones the genius schedule frames call
`home_team_id` / `away_team_id`. No request is made.

## Usage

``` r
genius_team_crosswalk(df, source)
```

## Arguments

- df:

  A Sportality data frame.

- source:

  One of `"sportality_standings"`, `"sportality_teams"`,
  `"sportality_players"`.

## Value

A `hoopR_data` tibble, one row per team:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_uuid | character | Sportality platform team uuid. |
| genius_team_id | integer | Genius team id of the same team (home_team_id / away_team_id of the genius schedule frames). |

## Details

Sources: `sportality_standings` (`team_uuid` / `team_id`),
`sportality_teams` (`info_uuid` / `info_team_id`) and
`sportality_players` (`info_team_uuid` / `info_team_id`). A wrong
source, a missing column, a wrong id type or a key that maps to two ids
raises `hoopR_bad_request`.

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  standings <- data.frame(team_uuid = c("a1", "b2"), team_id = c(101L, 102L))
  genius_team_crosswalk(standings, "sportality_standings")
#> ── Genius LiveStats team crosswalk ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:30:41 UTC
#> # A tibble: 2 × 2
#>   team_uuid genius_team_id
#>   <chr>              <int>
#> 1 a1                   101
#> 2 b2                   102
# }
```
