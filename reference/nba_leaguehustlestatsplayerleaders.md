# **Get NBA Stats API League Hustle Stats Player Leaders**

**Get NBA Stats API League Hustle Stats Player Leaders**

**Get NBA Stats API League Hustle Stats Player Leaders**

## Usage

``` r
nba_leaguehustlestatsplayerleaders(
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

Returns a named list of data frames: PlayerChargesDrawnLeaders,
PlayerContestedShotsLeaders, PlayerDeflectionsLeaders,
PlayerLooseBallLeaders, PlayerScreenAssistLeaders, Table5

**PlayerContestedShotsLeaders**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE               | character | Player age (in years).                |
| RANK              | character | Rank.                                 |
| CONTESTED_SHOTS   | character | Defensively contested shots.          |

**PlayerChargesDrawnLeaders**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE               | character | Player age (in years).                |
| RANK              | character | Rank.                                 |
| CHARGES_DRAWN     | character | Charges drawn.                        |

**PlayerDeflectionsLeaders**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE               | character | Player age (in years).                |
| RANK              | character | Rank.                                 |
| DEFLECTIONS       | character | Defensive deflections.                |

**PlayerLooseBallLeaders**

|                       |           |                                       |
|-----------------------|-----------|---------------------------------------|
| col_name              | types     | description                           |
| PLAYER_ID             | character | Unique player identifier.             |
| PLAYER_NAME           | character | Player name.                          |
| TEAM_ID               | character | Unique team identifier.               |
| TEAM_ABBREVIATION     | character | Short team abbreviation (e.g. 'LAS'). |
| AGE                   | character | Player age (in years).                |
| RANK                  | character | Rank.                                 |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered.                |

**PlayerScreenAssistLeaders**

|                   |           |                                         |
|-------------------|-----------|-----------------------------------------|
| col_name          | types     | description                             |
| PLAYER_ID         | character | Unique player identifier.               |
| PLAYER_NAME       | character | Player name.                            |
| TEAM_ID           | character | Unique team identifier.                 |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').   |
| AGE               | character | Player age (in years).                  |
| RANK              | character | Rank.                                   |
| SCREEN_ASSISTS    | character | Screen assists (resulting in a basket). |

**Table5**

|                   |           |                                       |
|-------------------|-----------|---------------------------------------|
| col_name          | types     | description                           |
| PLAYER_ID         | character | Unique player identifier.             |
| PLAYER_NAME       | character | Player name.                          |
| TEAM_ID           | character | Unique team identifier.               |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE               | character | Player age (in years).                |
| RANK              | character | Rank.                                 |
| BOX_OUTS          | character | Box-outs executed.                    |

## Details

[Player Hustle Stats
Leaders](https://www.nba.com/stats/players/hustle-leaders)

     nba_leaguehustlestatsplayerleaders(league_id = '00')

## See also

Other NBA Hustle Functions:
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_leaguehustlestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayer.md),
[`nba_leaguehustlestatsteamleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteamleaders.md),
[`nba_leaguehustlestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteam.md)

## Author

Saiem Gilani
