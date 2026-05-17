# **Get NBA Stats API League Hustle Stats Team Leaders**

**Get NBA Stats API League Hustle Stats Team Leaders**

**Get NBA Stats API League Hustle Stats Team Leaders**

## Usage

``` r
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

|  |  |  |
|----|----|----|
| col_name | types | description |
| TEAM_ID | character | Unique team identifier. |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| RANK | character | Rank. |
| BOX_OUTS | character | Box-outs executed. |

## Details

[Team Hustle Stats
Leaders](https://www.nba.com/stats/teams/hustle-leaders)

     nba_leaguehustlestatsteamleaders(league_id = '00')

## See also

Other NBA Hustle Functions:
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md),
[`nba_leaguehustlestatsplayer()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayer.md),
[`nba_leaguehustlestatsplayerleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsplayerleaders.md),
[`nba_leaguehustlestatsteam()`](https://hoopR.sportsdataverse.org/reference/nba_leaguehustlestatsteam.md)

## Author

Saiem Gilani
