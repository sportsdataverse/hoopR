# **Get NBA Stats API League Hustle Stats Player**

**Get NBA Stats API League Hustle Stats Player**

**Get NBA Stats API League Hustle Stats Player**

## Usage

``` r
nba_leaguehustlestatsplayer(
  college = "",
  conference = "",
  country = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_pick = "",
  draft_year = "",
  height = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  po_round = "",
  per_mode = "Totals",
  player_experience = "",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  weight = "",
  ...
)
```

## Arguments

- college:

  college

- conference:

  conference

- country:

  country

- date_from:

  date_from

- date_to:

  date_to

- division:

  division

- draft_pick:

  draft_pick

- draft_year:

  draft_year

- height:

  height

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- po_round:

  po_round

- per_mode:

  per_mode

- player_experience:

  player_experience

- player_position:

  player_position

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- weight:

  weight

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: HustleStatsPlayer

**HustleStatsPlayer**

|                               |           |
|-------------------------------|-----------|
| col_name                      | types     |
| PLAYER_ID                     | character |
| PLAYER_NAME                   | character |
| TEAM_ID                       | character |
| TEAM_ABBREVIATION             | character |
| AGE                           | character |
| G                             | character |
| MIN                           | character |
| CONTESTED_SHOTS               | character |
| CONTESTED_SHOTS_2PT           | character |
| CONTESTED_SHOTS_3PT           | character |
| DEFLECTIONS                   | character |
| CHARGES_DRAWN                 | character |
| SCREEN_ASSISTS                | character |
| SCREEN_AST_PTS                | character |
| OFF_LOOSE_BALLS_RECOVERED     | character |
| DEF_LOOSE_BALLS_RECOVERED     | character |
| LOOSE_BALLS_RECOVERED         | character |
| PCT_LOOSE_BALLS_RECOVERED_OFF | character |
| PCT_LOOSE_BALLS_RECOVERED_DEF | character |
| OFF_BOXOUTS                   | character |
| DEF_BOXOUTS                   | character |
| BOX_OUT_PLAYER_TEAM_REBS      | character |
| BOX_OUT_PLAYER_REBS           | character |
| BOX_OUTS                      | character |
| PCT_BOX_OUTS_OFF              | character |
| PCT_BOX_OUTS_DEF              | character |
| PCT_BOX_OUTS_TEAM_REB         | character |
| PCT_BOX_OUTS_REB              | character |

## Details

[Player Hustle Stats](https://www.nba.com/stats/players/hustle)

     nba_leaguehustlestatsplayer(league_id = '00')
     nba_leaguehustlestatsplayer(league_id = '00', team_id = '1610612761')

## See also

Other NBA Hustle Functions:
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_leaguehustlestatsplayerleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayerleaders.md),
[`nba_leaguehustlestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteam.md),
[`nba_leaguehustlestatsteamleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteamleaders.md)

## Author

Saiem Gilani
