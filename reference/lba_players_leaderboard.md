# **Get LBA Players Leaderboard**

Season player leaderboard for one category (per-game average).

Endpoint:
`GET https://www.legabasket.it/api/statistics/get-players-statistics`
(`cs_id=1&s=<season>&cat=<category>`)

## Usage

``` r
lba_players_leaderboard(season = NULL, category = "points")
```

## Arguments

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

- category:

  Category: points, rating_lega, total_rebound, assists, shots_3p_perc,
  ... (the site's filters.categories).

## Value

A `hoopR_data` tibble: Season player leaderboard for one category
(per-game average). The columns are always these, in this order
(sportsdataverse-py `lba_players_leaderboard`); a column the site adds
later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| category | character | Category of this row (the `cat` param, e.g. `points`). |
| player_id | integer | Player id (global, one per career). |
| name | character | Given name (players) / team name (teams). |
| surname | character | Player's family name. |
| team_name | character | Team name in that season, with its sponsor (`Nutribullet Treviso Basket`); changes with the sponsor. |
| tv_name | character | Short team name for TV graphics. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| category_filter_total | integer | Season total in the category. |
| attempts | integer | Shots attempted in the zone, parsed from num. |
| presences | integer | Games the player appeared in, counted for the leaderboard. |
| minutes | double | Minutes per game (players: decimal string `28.67`) / total minutes (teams: integer). |
| score_40_min | double | Value per 40 minutes. |
| score | double | Value in the category under the `ob` order (default `avg` = per game); players send a decimal string, teams a number. |
| team_id | integer | Team id (team-season). |
| player_photo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_players_leaderboard(season = 2027, category = "points")

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
[`lba_roster()`](https://hoopR.sportsdataverse.org/reference/lba_roster.md),
[`lba_roster_coach()`](https://hoopR.sportsdataverse.org/reference/lba_roster_coach.md),
[`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md),
[`lba_standings()`](https://hoopR.sportsdataverse.org/reference/lba_standings.md),
[`lba_team_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_team_box_score.md),
[`lba_team_players_stats()`](https://hoopR.sportsdataverse.org/reference/lba_team_players_stats.md),
[`lba_teams()`](https://hoopR.sportsdataverse.org/reference/lba_teams.md),
[`lba_teams_leaderboard()`](https://hoopR.sportsdataverse.org/reference/lba_teams_leaderboard.md)
