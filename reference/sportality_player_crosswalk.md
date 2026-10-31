# **Get the Basketligaen player id crosswalk**

Genius person id -\> athlete uuid for every player of a Basketligaen
season, from one stats-info call (`players_summary`). The site has two
player id systems: the **Genius person id** that play-by-play, box
scores and stats tables key on (and that joins the genius family), and
the platform **athlete uuid** that rosters and athlete routes key on.
The `players_summary` table's `players` map is keyed by Genius id and
carries each player's uuid.

Endpoint:
`GET https://www.basketligaen.dk/api/statistics-v2/stats-info/players_summary`

## Usage

``` r
sportality_player_crosswalk(season, game_type = "regular")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025/26), mapped to its ssgt
  through layout-info.

- game_type:

  (default `"regular"`) Game type: `regular` (the league season) or
  `finals` (the playoffs, Slutspil).

## Value

A `hoopR_data` tibble, one row per player. sportsdataverse-py documents
no fixed schema for this frame: the columns after the first two are the
fields the `players` map carries (the 2025/26 map is shown); birth dates
are dropped.

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | Genius person id (the map key); joins play-by-play, box scores, stats tables and the genius family. |
| athlete_uuid | character | Platform athlete uuid (NA where the site has none, common before about 2005); joins rosters and the athlete routes. |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| shoots | character | Shooting hand (empty or NA for every player seen). |
| ep_url | character | Profile URL on an external site (empty for every player seen). |
| full_name | character | Full display name of the player. |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| gender | character | Gender as recorded by the site (`male`, or empty). |
| weight | integer | Weight in kilograms. |
| height | integer | Height in centimetres. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

     sportality_player_crosswalk(season = 2026)

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
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
