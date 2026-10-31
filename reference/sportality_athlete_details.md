# **Get Basketligaen Athlete Details**

Player bio plus playerExtIds (the Genius person id).

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athlete-details/{athlete_uuid}`

## Usage

``` r
sportality_athlete_details(athlete_uuid)
```

## Arguments

- athlete_uuid:

  (required) Athlete uuid: roster `players[].uuid` or stats-info
  `stats[].info.uuid`. Key space: platform athlete uuids (not the Genius
  person id).

## Value

A `hoopR_data` tibble: Player bio plus playerExtIds (the Genius person
id). An empty valid answer raises `hoopR_no_data`; the documented
columns come first, in this order (sportsdataverse-py
`sportality_athlete_details`), then any column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| athlete_uuid | character | Platform athlete uuid (rosters and athlete routes key on it); not the Genius person id; null where the site has none. |
| player_id | integer | Genius person id (Int64). A string key in the players maps, an integer in play-by-play and box-score rows; cast here so the frames join, and join the genius family. |
| created_at | character | Creation timestamp. |
| created_by | character | Creating site instance. |
| creator_site | character | Unobserved: null in every sample and every full body. When filled: Creating site (null). |
| height | integer | Height of the player in centimetres. |
| deleted | logical | Soft-delete flag. |
| first_name | character | Given (first) name(s) of the player. |
| gender | character | Gender of the person as recorded by the site (male in every row seen). |
| last_modified | character | Last-modified timestamp. |
| last_name | character | Family name (surname) of the player. |
| metadata | character | Free metadata (always empty). |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| shoots | character | Shooting hand (”). |
| weight | integer | Weight of the player in kilograms. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_athlete_details(athlete_uuid = "dpu0901c0t")

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)
