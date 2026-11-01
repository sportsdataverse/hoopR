# **Get LBA Shots**

Shooting by court zone per team for a final game (made / attempted
aggregates; zone 7 includes free throws).

Endpoint:
`GET https://www.legabasket.it/api/matches/get-championship-matches-shots-by-id`
(`info=1&id=<game_id>`)

## Usage

``` r
lba_shots(game_id)
```

## Arguments

- game_id:

  (required) Game id (game_id in lba_calendar), e.g. 25602. Global
  across seasons.

## Value

A `hoopR_data` tibble: Shooting by court zone per team for a final game
(made / attempted aggregates; zone 7 includes free throws). The columns
are always these, in this order (sportsdataverse-py `lba_shots`); a
column the site adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (global across seasons); joins lba_calendar and lba_game. |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| side | character | Which team of the game the row belongs to: home or visitor. |
| team_id | integer | Team-season id (re-issued every season); join lba_teams for the stable club_id. |
| zone | integer | Court zone 1-10 (the play-by-play side_area_code); zone 7 also holds the free throws. |
| made | integer | Shots made in the zone, parsed from num. |
| attempts | integer | Shots attempted in the zone, parsed from num. |
| perc | double | Made / attempted x 100. |
| precision | integer | Decimal places the site shows (1). |
| num | character | Made/attempted as a string (`17/21`); zone `7` also counts free throws. |
| opacity | integer | Heat-map shading for the site: `perc` floored, minimum 5. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

## See also

Other LBA Functions:
[`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md),
[`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md),
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md),
[`lba_game()`](https://hoopR.sportsdataverse.org/reference/lba_game.md),
[`lba_game_log()`](https://hoopR.sportsdataverse.org/reference/lba_game_log.md),
[`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md),
[`lba_pbp_legend()`](https://hoopR.sportsdataverse.org/reference/lba_pbp_legend.md),
[`lba_player()`](https://hoopR.sportsdataverse.org/reference/lba_player.md),
[`lba_player_stats()`](https://hoopR.sportsdataverse.org/reference/lba_player_stats.md),
[`lba_players()`](https://hoopR.sportsdataverse.org/reference/lba_players.md),
[`lba_players_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_players_leaderboard.md),
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)

## Examples

``` r
# \donttest{
  try(lba_shots(game_id = 25602))
#> ── LBA Shots from legabasket.it ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:49:02 UTC
#> # A tibble: 20 × 11
#>    game_id season side    team_id  zone  made attempts  perc precision num  
#>      <int>  <int> <chr>     <int> <int> <int>    <int> <dbl>     <int> <chr>
#>  1   25602   2027 home       1764     1     1        2  50           1 1/2  
#>  2   25602   2027 home       1764     2     0        1   0           1 0/1  
#>  3   25602   2027 home       1764     3    17       21  81.0         1 17/21
#>  4   25602   2027 home       1764     4     2        4  50           1 2/4  
#>  5   25602   2027 home       1764     5     1        2  50           1 1/2  
#>  6   25602   2027 home       1764     6     8       13  61.5         1 8/13 
#>  7   25602   2027 home       1764     7    28       42  66.7         1 28/42
#>  8   25602   2027 home       1764     8     5       10  50           1 5/10 
#>  9   25602   2027 home       1764     9     1        6  16.7         1 1/6  
#> 10   25602   2027 home       1764    10     0        3   0           1 0/3  
#> 11   25602   2027 visitor    1761     1     5        8  62.5         1 5/8  
#> 12   25602   2027 visitor    1761     2     1        3  33.3         1 1/3  
#> 13   25602   2027 visitor    1761     3    17       22  77.3         1 17/22
#> 14   25602   2027 visitor    1761     4     0        1   0           1 0/1  
#> 15   25602   2027 visitor    1761     5     1        3  33.3         1 1/3  
#> 16   25602   2027 visitor    1761     6     1        4  25           1 1/4  
#> 17   25602   2027 visitor    1761     7    17       26  65.4         1 17/26
#> 18   25602   2027 visitor    1761     8     4       11  36.4         1 4/11 
#> 19   25602   2027 visitor    1761     9     2        9  22.2         1 2/9  
#> 20   25602   2027 visitor    1761    10     0        5   0           1 0/5  
#> # ℹ 1 more variable: opacity <int>
# }
```
