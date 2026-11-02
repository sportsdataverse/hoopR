# **Get KZS Play-by-Play**

Play-by-play of a final game (2015/16 on, with gaps), one row per action
with shot x/y.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`

## Usage

``` r
kzs_pbp(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: Play-by-play of a final game (2015/16 on, with
gaps), one row per action with shot x/y. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `kzs_pbp`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
| action_number | integer | 1-based position of the action in the feed, which is in game order. |
| team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
| source | character | Feed the action came from: GENIUS_SPORTS in every sample. |
| clock | character | Time remaining in the period, 'MM:SS:CC' (minutes, seconds, hundredths): '09:56:00' = 9:56 left. |
| action_type | character | Action type (code table). |
| sub_type | character | Action subtype (” when none; code table). |
| qualifiers | character | Semicolon-separated qualifiers (” when none; code table). |
| x | double | Location along the court length, 0-100 percent (see the coordinate section): shots, and from 2020-21 fouls and turnovers; 0.0 when the row has no location. |
| y | double | Location across the court width, 0-100 percent (see the coordinate section); 0.0 when the row has no location. |
| area | character | Court zone of the action (code table): set on shots, and from 2020-21 on located fouls and turnovers; ” on rows without a location and on every shot of early 2015-16 games. |
| side | character | Basket end: LEFT (x~0) or RIGHT (x~100). Absent on non-shot rows before 2020-21 and on some 2020-21 rows (read absent on a shot as LEFT). |
| success | logical | True when the shot / free throw was made (true on non-shot rows). |
| score1 | integer | First (home) team score after the action, a numeric STRING. |
| score2 | integer | Second (away) team score after the action, a numeric STRING. |
| period | integer | Period number; overtime restarts at 1 with periodType OVERTIME. |
| period_type | character | REGULAR or OVERTIME. |
| part | character | Period label: QUARTER1-QUARTER4, then OT1 (OT2 and on by the same pattern, unobserved). |
| match_team_player_id | integer | Match-player id: the player's entry in this one match; NOT the player id. No captured route is keyed by it: join on `playerId` on the same row. |
| player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
| match_team_player_first_name | character | The acting player's given name, as entered for this match. |
| match_team_player_last_name | character | The acting player's family name, as entered for this match. |
| team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
| team_name | character | Team name for the season, sponsor included (e.g. 'Perspektiva Ilirija'). |
| match_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. |
| player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
| shirt_number | character | Shirt number worn by the acting player, sent as a string. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

Other KZS Functions:
[`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md),
[`kzs_competition()`](https://hoopR.sportsdataverse.org/reference/kzs_competition.md),
[`kzs_competitions()`](https://hoopR.sportsdataverse.org/reference/kzs_competitions.md),
[`kzs_match()`](https://hoopR.sportsdataverse.org/reference/kzs_match.md),
[`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md),
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
  try(kzs_pbp(match_id = 101839))
#> ── KZS Play-by-Play from api.kzs.si ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:54:07 UTC
#> # A tibble: 816 × 27
#>    match_id action_number team_side source clock action_type sub_type qualifiers
#>       <int>         <int> <chr>     <chr>  <chr> <chr>       <chr>    <chr>     
#>  1   101839             1 NA        GENIU… 10:0… game        "start"  ""        
#>  2   101839             2 NA        GENIU… 10:0… period      "start"  ""        
#>  3   101839             3 NA        GENIU… 10:0… clock       "start"  ""        
#>  4   101839             4 NA        GENIU… 10:0… jumpball    "startp… ""        
#>  5   101839             5 away      GENIU… 09:5… jumpball    "won"    ""        
#>  6   101839             6 home      GENIU… 09:5… jumpball    "lost"   ""        
#>  7   101839             7 NA        GENIU… 09:5… clock       "stop"   ""        
#>  8   101839             8 away      GENIU… 09:5… 2pt         "drivin… "pointsin…
#>  9   101839             9 home      GENIU… 09:5… foul        "person… "shooting…
#> 10   101839            10 away      GENIU… 09:5… foulon      ""       ""        
#> # ℹ 806 more rows
#> # ℹ 19 more variables: x <dbl>, y <dbl>, area <chr>, side <chr>, success <lgl>,
#> #   score1 <int>, score2 <int>, period <int>, period_type <chr>, part <chr>,
#> #   match_team_player_id <int>, player_id <int>,
#> #   match_team_player_first_name <chr>, match_team_player_last_name <chr>,
#> #   team_application_id <int>, team_name <chr>, match_team_id <int>,
#> #   player_photo_uuid <chr>, shirt_number <chr>
# }
```
