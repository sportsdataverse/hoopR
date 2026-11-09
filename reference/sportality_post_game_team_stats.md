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

A `hoopR_data` tibble with one row per statistic. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_post_game_team_stats")`) and
in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
