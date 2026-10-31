# **IBBA Segev Rosters**

**Both teams' game rosters with Segev player ids and names in English
and Hebrew.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`

## Usage

``` r
ibba_segev_rosters(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
| team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
| team_id | integer | Segev team id of the roster's side (stable across seasons). |
| player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
| jersey_number | integer | Jersey number as an integer. |
| first_name | character | First name in English, upper case. |
| last_name | character | Last name in English, upper case. |
| first_name_local | character | First name in Hebrew. |
| last_name_local | character | Last name in Hebrew. |
| in_roster | integer | Roster flag, 0 or 2 in the samples; meaning unverified. |
| api_id | integer | External player id as an integer: null or equal to the Segev player_id (both occur within one game); its source is unverified. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

     ibba_segev_rosters(game_id = 50)

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)
