# **Get VTB Infobasket Standings**

Standings of one stage (a round-robin stage such as the regular season),
one row per team.

Endpoint:
`GET https://org.infobasket.su/Widget/CompTeamResults/{comp_id}`

## Usage

``` r
vtb_infobasket_standings(comp_id)
```

## Arguments

- comp_id:

  Stage CompID (comp_id in vtb_infobasket_comp_issue), not a season id
  and not an END year, e.g. 50720 (Regular Season 2025-26) or 54281
  (Playoff 2025-26).

## Value

A `hoopR_data` tibble: Standings of one stage (a round-robin stage such
as the regular season), one row per team. The columns are always these,
in this order (sportsdataverse-py `vtb_infobasket_standings`); an empty
valid answer raises `hoopR_no_data`, a valid body with no rows for this
frame is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Stage CompID the request asked for (50720 = the 2025-26 regular season): a stage below the season, not an END year. |
| comp_team_id | integer | Infobasket competition-team id: one team's registration in one competition stage (a different key space from TeamID). |
| team_id | integer | Infobasket team id (TeamID): one club's entry in a competition family (Lokomotiv Kuban = 2650). Joins to /Widget/Team\*/{teamId} and equals the v2 API `teamId`. |
| place | integer | Current place in the standings. |
| start_place | integer | Place before the latest round (unverified). |
| games | integer | Games played in the stage (top-level copy of standing_game). |
| won | integer | Games won in the stage (top-level copy of standing_win). |
| lost | integer | Games lost in the stage (top-level copy of standing_lose). |
| standing_game | integer | Games played in the stage. |
| standing_win | integer | Games won in the stage. |
| standing_draw | character | Draws; null in basketball. |
| standing_lose | integer | Games lost in the stage. |
| standing_forfeit | integer | Games lost by forfeit in the stage. |
| standing_points | integer | League points (2 per win, 1 per loss). |
| standing_goal_plus | integer | Points scored in the stage. |
| standing_goal_minus | integer | Points conceded in the stage. |
| standing_goal_difference | integer | Point difference (scored minus conceded). |
| standing_penalty | integer | Points deducted. |
| standing_is_play | logical | True while the team is still playing in the stage. |
| victory_percent | double | Win percentage as a number (83 = 83 percent). |
| avg_goal_plus | double | Average points scored per game. |
| avg_goal_minus | double | Average points conceded per game. |
| team_short_name_ru | character | The the team's short name in Russian (as the competition names it). |
| team_short_name_en | character | The the team's short name in English (as the competition names it). |
| team_name_ru | character | The the team's name in Russian (as the competition names it). |
| team_name_en | character | The the team's name in English (as the competition names it). |
| team_region_name_ru | character | The the team's region or city in Russian (as the competition names it). |
| team_region_name_en | character | The the team's region or city in English (as the competition names it). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_standings(comp_id = 50720))
#> ── VTB Infobasket Standings from org.infobasket.su ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:10:13 UTC
#> # A tibble: 11 × 28
#>    comp_id comp_team_id team_id place start_place games   won  lost
#>      <int>        <int>   <int> <int>       <int> <int> <int> <int>
#>  1   50720       450736      15     1          11    40    37     3
#>  2   50720       450734     697     2           9    40    33     7
#>  3   50720       450728    2994     3           4    40    28    12
#>  4   50720       450729    2650     4           5    40    27    13
#>  5   50720       450732    3059     5           2    40    22    18
#>  6   50720       450735    1390     6          10    40    19    21
#>  7   50720       450730    2747     7           6    40    18    22
#>  8   50720       450727     688     8           3    40    15    25
#>  9   50720       450731     468     9           7    40    12    28
#> 10   50720       450726     682    10           1    40     7    33
#> 11   50720       450733    2792    11           8    40     2    38
#> # ℹ 20 more variables: standing_game <int>, standing_win <int>,
#> #   standing_draw <chr>, standing_lose <int>, standing_forfeit <int>,
#> #   standing_points <int>, standing_goal_plus <int>, standing_goal_minus <int>,
#> #   standing_goal_difference <int>, standing_penalty <int>,
#> #   standing_is_play <lgl>, victory_percent <dbl>, avg_goal_plus <dbl>,
#> #   avg_goal_minus <dbl>, team_short_name_ru <chr>, team_short_name_en <chr>,
#> #   team_name_ru <chr>, team_name_en <chr>, team_region_name_ru <chr>, …
# }
```
