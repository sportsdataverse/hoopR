# **Get VTB Infobasket Game**

Header of a finished game: stage, venue, rules, the two teams and their
scores.

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_game(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: Header of a finished game: stage, venue, rules,
the two teams and their scores. The columns are always these, in this
order (sportsdataverse-py `vtb_infobasket_game`); an empty valid answer
raises `hoopR_no_data`, a valid body with no rows for this frame is a
zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| is_online | logical | True while the game is live; False for a completed game. |
| game_status | integer | Game status: 0 planned, 1 completed, 2 live (the site's widget code). Samples are completed games. |
| max_period | integer | Last period played (4 = regulation; 5+ = overtime). |
| from_date | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| game_date | character | Game date (ISO), local. |
| has_time | logical | True when a tip-off time is set. |
| game_time | character | Tip-off time of day as 'HH.MM' (a dot, local time). |
| game_time_msk | character | Tip-off time of day as 'HH.MM' in Moscow time. |
| has_video | logical | True when a video embed is attached. |
| tv_ru | character | TV channels, in Russian ('Match TV' = Match TV). |
| tv_en | character | TV channels, in English. |
| comp_name_ru | character | Stage name, Russian ('Regulyarnyy chempionat' = 'Regular Season'). |
| comp_name_en | character | Stage name (e.g. 'Regular Season'), English. |
| league_name_ru | character | League name, Russian ('Edinaya liga VTB' = 'VTB United League'). |
| league_name_en | character | League name, English. |
| league_short_name_ru | character | League short name, Russian. |
| league_short_name_en | character | League short name, English. |
| gender | integer | Competition gender code from the host (1 male, 0 unspecified). |
| comp_id | integer | Stage CompID of the game (50720 = the 2025-26 regular season): a stage below the season. |
| is3x3 | logical | True for a 3x3 competition (False in every sample). |
| season_comp_id | integer | Season-level CompID of the game (the body calls it LeagueID). |
| game_id | integer | Infobasket GameID of the game (the v2 matches' match_id); global across seasons. |
| game_number | character | Game number within the competition, e.g. 'RS-002' (RS = regular season); playoff games use the series code. |
| game_date_time | character | Tip-off as an ISO 8601 string in Moscow time (+03:00), from Online.GameTime. |
| region_id | integer | Infobasket region (city) id of the venue. |
| arena_id | integer | Infobasket arena id; equals the v2 API `venueId` (11687 = SK Basket-Hall, Krasnodar). |
| venue_en | character | Venue, 'City, Arena', in English. |
| venue_ru | character | Venue, 'City, Arena', in Russian. |
| attendance | integer | Spectators at the game (null when not recorded). |
| period_count | integer | Regulation periods (4). |
| period_extra_seconds | integer | Overtime length in seconds (300 = 5 minutes). |
| period_minutes | character | Period lengths in minutes, comma separated ('10,10,10,10'). |
| intervals_minutes | character | Break lengths in minutes after each period, comma separated ('2,15,2,2'). |
| personal_fouls | integer | Personal fouls that disqualify a player (5). |
| team_fouls | character | Team-foul setting per period, comma separated (4 or 5 seen; exact meaning unverified). |
| players_on_court | integer | Players per team on the court (5). |
| free_throw_value | integer | Points for a made free throw (1). |
| field_goal_value | integer | Points for a made 2-point shot (2). |
| long_shot_value | integer | Points for a made 3-point shot (3). |
| left_team_number | integer | Team number drawn on the left in the widget (1 in every sample). |
| team_a_id | integer | Infobasket TeamID of team A, the team listed first (the home side in the calendar). |
| score_a | integer | Final points of team A (listed first). |
| team_a_short_name_ru | character | The team A (the home side in the calendar)'s short name in Russian (as the competition names it). |
| team_a_short_name_en | character | The team A (the home side in the calendar)'s short name in English (as the competition names it). |
| team_a_name_ru | character | The team A (the home side in the calendar)'s name in Russian (as the competition names it). |
| team_a_name_en | character | The team A (the home side in the calendar)'s name in English (as the competition names it). |
| team_a_region_name_ru | character | The team A (the home side in the calendar)'s region or city in Russian (as the competition names it). |
| team_a_region_name_en | character | The team A (the home side in the calendar)'s region or city in English (as the competition names it). |
| team_b_id | integer | Infobasket TeamID of team B, the team listed second (the away side). |
| score_b | integer | Final points of team B. |
| team_b_short_name_ru | character | The team B (the away side)'s short name in Russian (as the competition names it). |
| team_b_short_name_en | character | The team B (the away side)'s short name in English (as the competition names it). |
| team_b_name_ru | character | The team B (the away side)'s name in Russian (as the competition names it). |
| team_b_name_en | character | The team B (the away side)'s name in English (as the competition names it). |
| team_b_region_name_ru | character | The team B (the away side)'s region or city in Russian (as the competition names it). |
| team_b_region_name_en | character | The team B (the away side)'s region or city in English (as the competition names it). |

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
  try(vtb_infobasket_game(game_id = 921391))
#> ── VTB Infobasket Game from org.infobasket.su ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:55 UTC
#> # A tibble: 1 × 56
#>   is_online game_status max_period from_date game_date  has_time game_time
#>   <lgl>           <int>      <int> <chr>     <chr>      <lgl>    <chr>    
#> 1 FALSE               1          4 NA        2025-09-28 TRUE     14.00    
#> # ℹ 49 more variables: game_time_msk <chr>, has_video <lgl>, tv_ru <chr>,
#> #   tv_en <chr>, comp_name_ru <chr>, comp_name_en <chr>, league_name_ru <chr>,
#> #   league_name_en <chr>, league_short_name_ru <chr>,
#> #   league_short_name_en <chr>, gender <int>, comp_id <int>, is3x3 <lgl>,
#> #   season_comp_id <int>, game_id <int>, game_number <chr>,
#> #   game_date_time <chr>, region_id <int>, arena_id <int>, venue_en <chr>,
#> #   venue_ru <chr>, attendance <int>, period_count <int>, …
# }
```
