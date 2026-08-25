# **Get NBA Stats API League Hustle Stats Player**

**Get NBA Stats API League Hustle Stats Player**

**Get NBA Stats API League Hustle Stats Player**

**Get NBA Stats API League Hustle Stats Player Leaders**

**Get NBA Stats API League Hustle Stats Team**

**Get NBA Stats API League Hustle Stats Team Leaders**

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

nba_leaguehustlestatsteam(
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

nba_leaguehustlestatsteamleaders(
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

|  |  |  |
|----|----|----|
| col_name | types | description |
| PLAYER_ID | character | Unique player identifier. |
| PLAYER_NAME | character | Player name. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| AGE | character | Player age (in years). |
| G | character | Games played. |
| MIN | character | Minutes played. |
| CONTESTED_SHOTS | character | Defensively contested shots. |
| CONTESTED_SHOTS_2PT | character | Contested two-point shots. |
| CONTESTED_SHOTS_3PT | character | Contested three-point shots. |
| DEFLECTIONS | character | Defensive deflections. |
| CHARGES_DRAWN | character | Charges drawn. |
| SCREEN_ASSISTS | character | Screen assists (resulting in a basket). |
| SCREEN_AST_PTS | character |  |
| OFF_LOOSE_BALLS_RECOVERED | character |  |
| DEF_LOOSE_BALLS_RECOVERED | character |  |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered. |
| PCT_LOOSE_BALLS_RECOVERED_OFF | character |  |
| PCT_LOOSE_BALLS_RECOVERED_DEF | character |  |
| OFF_BOXOUTS | character |  |
| DEF_BOXOUTS | character |  |
| BOX_OUT_PLAYER_TEAM_REBS | character |  |
| BOX_OUT_PLAYER_REBS | character |  |
| BOX_OUTS | character | Box-outs executed. |
| PCT_BOX_OUTS_OFF | character |  |
| PCT_BOX_OUTS_DEF | character |  |
| PCT_BOX_OUTS_TEAM_REB | character |  |
| PCT_BOX_OUTS_REB | character |  |

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

Returns a named list of data frames: HustleStatsTeam

**HustleStatsTeam**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| MIN | character | Minutes played. |
| CONTESTED_SHOTS | character | Defensively contested shots. |
| CONTESTED_SHOTS_2PT | character | Contested two-point shots. |
| CONTESTED_SHOTS_3PT | character | Contested three-point shots. |
| DEFLECTIONS | character | Defensive deflections. |
| CHARGES_DRAWN | character | Charges drawn. |
| SCREEN_ASSISTS | character | Screen assists (resulting in a basket). |
| SCREEN_AST_PTS | character |  |
| OFF_LOOSE_BALLS_RECOVERED | character |  |
| DEF_LOOSE_BALLS_RECOVERED | character |  |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered. |
| PCT_LOOSE_BALLS_RECOVERED_OFF | character |  |
| PCT_LOOSE_BALLS_RECOVERED_DEF | character |  |
| OFF_BOXOUTS | character |  |
| DEF_BOXOUTS | character |  |
| BOX_OUTS | character | Box-outs executed. |
| PCT_BOX_OUTS_OFF | character |  |
| PCT_BOX_OUTS_DEF | character |  |

Returns a named list of data frames: Table5, Table6,
TeamChargesDrawnLeaders, TeamContestedShotsLeaders,
TeamDeflectionsLeaders, TeamLooseBallLeaders, TeamScreenAssistLeaders

**TeamContestedShotsLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| CONTESTED_SHOTS | character | Defensively contested shots. |

**TeamChargesDrawnLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| CHARGES_DRAWN | character | Charges drawn. |

**TeamDeflectionsLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| DEFLECTIONS | character | Defensive deflections. |

**TeamLooseBallLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| LOOSE_BALLS_RECOVERED | character | Loose balls recovered. |

**TeamScreenAssistLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| SCREEN_ASSISTS | character | Screen assists (resulting in a basket). |

**Table5**

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| BOX_OUTS | character | Box-outs executed. |

**Table6**

Same columns as the **Table5** table above.

## Details

[Player Hustle Stats](https://www.nba.com/stats/players/hustle)

     nba_leaguehustlestatsplayer(league_id = '00')
     nba_leaguehustlestatsplayer(league_id = '00', team_id = '1610612761')

[Player Hustle Stats
Leaders](https://www.nba.com/stats/players/hustle-leaders)

     nba_leaguehustlestatsplayerleaders(league_id = '00')

[Team Hustle Stats](https://www.nba.com/stats/teams/hustle)

     nba_leaguehustlestatsteam(league_id = '00')

[Team Hustle Stats
Leaders](https://www.nba.com/stats/teams/hustle-leaders)

     nba_leaguehustlestatsteamleaders(league_id = '00')

## See also

Other NBA Hustle Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md)

## Author

Saiem Gilani
