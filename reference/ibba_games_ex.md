# **IBBA External Games**

**A club's games of a season in external competitions (BoardsEx boards:
European cups, pre-season).**

Endpoint: `GET https://basket.co.il/ws/ws.asmx/GamesEx`

## Usage

``` r
ibba_games_ex(team_uid, season, board_id = 0)
```

## Arguments

- team_uid:

  (*integer* required): IBBA club id, stable across seasons (Maccabi Tel
  Aviv = 10; `team_uid` in ibba_teams). Use 0 for all clubs only where
  the route says so.

- season:

  (*integer* required): Season END year (2026 = 2025-26); sent to the
  host as `cYear` unchanged.

- board_id:

  (*integer*, default `0`): External board id from ibba_boards_ex (1001
  EuroLeague, 1003 Champions League, ...); 0 (default) for all.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | IBBA game id (key space: basket.co.il games). Joins ibba_games to ibba_box_score; in ibba_games_ex it is an EXTERNAL game id (the ig\_ space, e.g. 8888 for a pre-season game). |
| game_date | Date | Local Israel date of the game. |
| season | integer | Season END year as an integer (2026 = 2025-26): the host's own cYear, no mapping. |
| home_team_id | integer | Home team-season id (team1 on the wire; verified home against Segev). On external boards (board_id \>= 1001) an external-team id (the ig_team\_ space), not a team-season. |
| away_team_id | integer | Away team-season id (team2 on the wire). On external boards an external-team id. |
| home_team_he | character | Home team name in Hebrew, HTML-unescaped. |
| away_team_he | character | Away team name in Hebrew, HTML-unescaped. |
| home_logo_url | character | Absolute URL of the home team logo. |
| away_logo_url | character | Absolute URL of the away team logo. |
| home_score | integer | Home final score; 0 before the game is played. |
| away_score | integer | Away final score; 0 before the game is played. |
| board_id | integer | Competition (board) id: 5 league, 10 cup, 16 / 26 / 17 playoff quarterfinals / semifinals / final, 33 play-in, 34 Supercup, 11 the 2004-05 semifinal group; 1001+ external competitions (1001 EuroLeague, 1003 Champions League, 1005 pre-season, 1008 EuroBasket, 1012 EuroCup, 1013 State Cup). |
| board_name_he | character | Competition name in Hebrew, HTML-unescaped. |
| round | integer | Round (game number) within the board; null for external games. |
| tip_off | character | Tip-off 'HH:MM', local Israel time, as text; null in 2004-05. It can disagree with Segev (game 26646: 20:15 here, 19:30 in Segev). |
| venue_he | character | Venue in Hebrew, HTML-unescaped; null in 2004-05. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md).

     ibba_games_ex(season = 2026, team_uid = 10)

## See also

Other IBBA Functions:
[`ibba_boards()`](https://hoopR.sportsdataverse.org/reference/ibba_boards.md),
[`ibba_boards_ex()`](https://hoopR.sportsdataverse.org/reference/ibba_boards_ex.md),
[`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md),
[`ibba_coaches()`](https://hoopR.sportsdataverse.org/reference/ibba_coaches.md),
[`ibba_configuration()`](https://hoopR.sportsdataverse.org/reference/ibba_configuration.md),
[`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md),
[`ibba_games_by_team()`](https://hoopR.sportsdataverse.org/reference/ibba_games_by_team.md),
[`ibba_leaders()`](https://hoopR.sportsdataverse.org/reference/ibba_leaders.md),
[`ibba_player()`](https://hoopR.sportsdataverse.org/reference/ibba_player.md),
[`ibba_player_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_player_stats.md),
[`ibba_players()`](https://hoopR.sportsdataverse.org/reference/ibba_players.md),
[`ibba_segev_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_crosswalk.md),
[`ibba_stats_types()`](https://hoopR.sportsdataverse.org/reference/ibba_stats_types.md),
[`ibba_team()`](https://hoopR.sportsdataverse.org/reference/ibba_team.md),
[`ibba_team_stats()`](https://hoopR.sportsdataverse.org/reference/ibba_team_stats.md),
[`ibba_teams()`](https://hoopR.sportsdataverse.org/reference/ibba_teams.md)
