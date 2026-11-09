# **Get Basketligaen Post-Game Team Stats**

Post-game team comparison (2023/24 on).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/post-game-data/team-stats/{game_uuid}`

## Usage

``` r
sportality_post_game_team_stats(
  game_uuid,
  ssgt_uuid,
  home_team_uuid,
  away_team_uuid
)
```

## Arguments

- game_uuid:

  (required) Game uuid: `gameInfo[].uuid` of the schedule (10 lowercase
  letters and digits). Key space: platform game uuids; the Genius match
  id is `extId` / `gameSourceId` in the body.

- ssgt_uuid:

  (required) ssgt uuid. Without it the answer is an empty 200 body.

- home_team_uuid:

  (required) Home team uuid; without it the home side comes back blank.

- away_team_uuid:

  (required) Away team uuid; without it the away side comes back blank.

## Value

A `hoopR_data` tibble: Post-game team comparison (2023/24 on). An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sportsdataverse-py `sportality_post_game_team_stats`),
then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| home_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
| home_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
| home_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
| home_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
| home_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
| home_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
| home_team_center_value | integer | Centre value (percentage as an integer 0-100). |
| away_team_side_translate_key | character | Translation key of the comparison row's label (s_2P, s_3P, s_FT, ...); the site translates it. |
| away_team_left_type | character | Stat code of the left value (2PM = two-pointers made). |
| away_team_left_value | integer | Value of the left-hand statistic of the comparison row. |
| away_team_right_type | character | Stat code of the right value (2PA = two-pointers attempted). |
| away_team_right_value | integer | Value of the right-hand statistic of the comparison row. |
| away_team_center_type | character | Stat code of the centre value (2PPerc = two-point percentage). |
| away_team_center_value | integer | Centre value (percentage as an integer 0-100). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_post_game_team_stats(
       away_team_uuid = "gvvuxe9ysw", game_uuid = "c4hh5nig6t", home_team_uuid = "rfo82vr830",
       ssgt_uuid = "xs07bd3fmp"
     )

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.
