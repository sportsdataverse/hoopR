# **IBBA Segev Player Box**

**Per-player box score of a finished game, plus a team-credited line per
side.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`

## Usage

``` r
ibba_segev_player_box(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
| team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
| team_id | integer | Segev team id of the side (key space: Segev teams, stable across seasons). Not an IBBA team-season id; null on game-level actions. |
| row_type | character | player (one player's line) or team (actions credited to the team and no player, such as team rebounds and turnovers). |
| player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
| jersey_number | integer | Jersey number as an integer. |
| starter | logical | True when the player was in the starting five. |
| on_court | logical | True when the player was on court at the final buzzer or the feed's last state. |
| minutes | character | Time played as 'mm:ss'. |
| seconds_played | integer | Time played in seconds, derived from minutes. |
| plus_minus | integer | Plus-minus while the player was on court, signed. |
| fg2m | integer | Two-point field goals made. |
| fg2_missed | integer | Two-point field goals MISSED (not attempted; attempts = made + missed, verified against the IBBA box score). |
| fg3m | integer | Three-point field goals made. |
| fg3_missed | integer | Three-point field goals MISSED (not attempted). |
| ftm | integer | Free throws made. |
| ft_missed | integer | Free throws MISSED (not attempted). |
| dreb | integer | Defensive rebounds. |
| oreb | integer | Offensive rebounds. |
| fouls | integer | Fouls committed (the feed's f; equals the IBBA fouls). |
| fouls_drawn | integer | Fouls drawn (the feed's f_drawn; equals the IBBA fouls_drawn). |
| steals | integer | Steals made by the player or team. |
| turnovers | integer | Turnovers committed by the player or team. |
| assists | integer | Assists credited to the player or team. |
| blocks | integer | Shots the player or team blocked. |
| blocks_against | integer | Own shots that were blocked. |
| fast_break_pts | integer | Fast-break points; for a team total it equals the P of the feed's 'P of N' fast-break stat. |
| second_chance_pts | integer | Second-chance points (scored after an offensive rebound). |
| pts | integer | Points scored by the player or side (free throws included). |
| val | integer | Efficiency rating (the feed's rate; equals the IBBA VAL). |
| deflections | integer | Deflections (count of deflection actions). |
| recoveries | integer | The feed's rec count; unverified, probably loose-ball recoveries. |
| dunks | integer | Dunks made by the player or side. |
| offensive_fouls_drawn | integer | Offensive fouls drawn (charges taken); inferred. |
| and_ones | integer | And-one plays (a made basket plus a foul); inferred. |
| vps | double | The feed's vps ratio with two decimals; its definition is unverified (it matches neither points per shot nor rate per minute). |
| fg2a | integer | Two-point field goals attempted, derived as made + missed. |
| fg3a | integer | Three-point field goals attempted, derived as made + missed. |
| fta | integer | Free throws attempted, derived as made + missed. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_player_box(game_id = 50))
#> ── IBBA Segev player box ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:46:00 UTC
#> # A tibble: 26 × 39
#>    game_id team_side team_id row_type player_id jersey_number starter on_court
#>      <int> <chr>       <int> <chr>        <int>         <int> <lgl>   <lgl>   
#>  1      50 home           11 player        1111             0 FALSE   TRUE    
#>  2      50 home           11 player        1179             5 FALSE   TRUE    
#>  3      50 home           11 player        1266             6 FALSE   FALSE   
#>  4      50 home           11 player        1114            14 FALSE   FALSE   
#>  5      50 home           11 player        1115            16 TRUE    FALSE   
#>  6      50 home           11 player        1249            17 FALSE   TRUE    
#>  7      50 home           11 player        1116            21 TRUE    TRUE    
#>  8      50 home           11 player        1117            22 FALSE   FALSE   
#>  9      50 home           11 player        1118            24 TRUE    TRUE    
#> 10      50 home           11 player        1119            35 TRUE    FALSE   
#> # ℹ 16 more rows
#> # ℹ 31 more variables: minutes <chr>, seconds_played <int>, plus_minus <int>,
#> #   fg2m <int>, fg2_missed <int>, fg3m <int>, fg3_missed <int>, ftm <int>,
#> #   ft_missed <int>, dreb <int>, oreb <int>, fouls <int>, fouls_drawn <int>,
#> #   steals <int>, turnovers <int>, assists <int>, blocks <int>,
#> #   blocks_against <int>, fast_break_pts <int>, second_chance_pts <int>,
#> #   pts <int>, val <int>, deflections <int>, recoveries <int>, dunks <int>, …
# }
```
