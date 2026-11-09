# **Get VTB Infobasket Cross Table**

Head-to-head results grid of a round-robin stage (every game twice, once
from each side).

Endpoint: `GET https://org.infobasket.su/Widget/CrossTable/{comp_id}`

## Usage

``` r
vtb_infobasket_cross_table(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble: Head-to-head results grid of a round-robin stage
(every game twice, once from each side). The columns are always these,
in this order (sportsdataverse-py `vtb_infobasket_cross_table`); an
empty valid answer raises `hoopR_no_data`, a valid body with no rows for
this frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Stage CompID the request asked for (50720 = the 2025-26 regular season): a stage below the season, not an END year. |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. |
| game_status | integer | Game status in the game-record code set: 21 on every completed game sampled (not the calendar's 0/1/2). |
| score | character | Final score 'row team:opponent'. Every game appears twice, once from each side. |
| plus_minus | integer | Point difference from the row team's side. |
| game_date | character | Day and month of the game as the host sends them ('04.04.'): there is no year in this route. |
| team1_id | integer | TeamID of the row team. Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| team2_id | integer | TeamID of the opponent. Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| team1_place | integer | Standings place of the row team. |
| team2_place | integer | Standings place of the opponent. |
| home_team | integer | Which side was at home: 1 the row team, 2 the opponent. |
| win_team | integer | Which side won: 1 the row team, 2 the opponent. |
| score1 | integer | Points of team 1, parsed from the 'a:b' score string. |
| score2 | integer | Points of team 2, parsed from the 'a:b' score string. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_cross_table(comp_id = 50720)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
