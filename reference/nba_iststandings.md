# **Get NBA Stats API League Game Log**

**Get NBA Stats API League Game Log**

**Get NBA Stats API League Game Log**

**Get NBA Stats API League Standings**

**Get NBA Stats API League Standings**

**Get NBA Stats API League Standings V3**

**Get NBA Stats API League Standings V3**

**Get NBA Stats API Playoff Picture**

**Get NBA Stats API Playoff Picture**

**Get NBA Stats API League Game Streak Finder**

**Get NBA Stats API League Game Streak Finder**

**Get NBA Stats API In-Season Tournament Standings**

**Get NBA Stats API In-Season Tournament Standings**

## Usage

``` r
nba_leaguegamelog(
  counter = 0,
  date_from = "",
  date_to = "",
  direction = "ASC",
  league_id = "00",
  player_or_team = "T",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  sorter = "DATE",
  ...
)

nba_leaguestandings(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  season_year = "",
  ...
)

nba_leaguestandingsv3(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  season_year = "",
  ...
)

nba_playoffpicture(league_id = "00", season_id = "22022", ...)

nba_leaguegamefinder(
  conference = "",
  date_from = "",
  date_to = "",
  division = "",
  draft_year = "",
  draft_team_id = "",
  draft_round = "",
  draft_number = "",
  et_ast = "",
  et_blk = "",
  et_dd = "",
  et_dreb = "",
  et_fg3a = "",
  et_fg3m = "",
  et_fg3_pct = "",
  et_fga = "",
  et_fgm = "",
  et_fg_pct = "",
  et_fta = "",
  et_ftm = "",
  et_ft_pct = "",
  et_minutes = "",
  et_oreb = "",
  et_pf = "",
  et_pts = "",
  et_reb = "",
  et_stl = "",
  et_td = "",
  et_tov = "",
  game_id = "",
  gt_ast = "",
  gt_blk = "",
  gt_dd = "",
  gt_dreb = "",
  gt_fg3a = "",
  gt_fg3m = "",
  gt_fg3_pct = "",
  gt_fga = "",
  gt_fgm = "",
  gt_fg_pct = "",
  gt_fta = "",
  gt_ftm = "",
  gt_ft_pct = "",
  gt_minutes = "",
  gt_oreb = "",
  gt_pf = "",
  gt_pts = "",
  gt_reb = "",
  gt_stl = "",
  gt_td = "",
  gt_tov = "",
  league_id = "00",
  location = "",
  lt_ast = "",
  lt_blk = "",
  lt_dd = "",
  lt_dreb = "",
  lt_fg3a = "",
  lt_fg3m = "",
  lt_fg3_pct = "",
  lt_fga = "",
  lt_fgm = "",
  lt_fg_pct = "",
  lt_fta = "",
  lt_ftm = "",
  lt_ft_pct = "",
  lt_minutes = "",
  lt_oreb = "",
  lt_pf = "",
  lt_pts = "",
  lt_reb = "",
  lt_stl = "",
  lt_td = "",
  lt_tov = "",
  outcome = "",
  po_round = "",
  player_id = "",
  player_or_team = "T",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  starter_bench = "",
  team_id = "",
  vs_conference = "",
  vs_division = "",
  vs_team_id = "",
  years_experience = "",
  ...
)

nba_iststandings(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  section = "group",
  ...
)
```

## Arguments

- counter:

  counter

- date_from:

  date_from

- date_to:

  date_to

- direction:

  direction

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- player_or_team:

  player_or_team

- season:

  Season - format: '2023-24'

- season_type:

  season_type

- sorter:

  sorter

- ...:

  Additional arguments passed to an underlying function like httr.

- season_year:

  season_year

- season_id:

  season_id

- conference:

  conference

- division:

  division

- draft_year:

  draft_year

- draft_team_id:

  draft_team_id

- draft_round:

  draft_round

- draft_number:

  draft_number

- et_ast:

  et_ast

- et_blk:

  et_blk

- et_dd:

  et_dd

- et_dreb:

  et_dreb

- et_fg3a:

  et_fg3a

- et_fg3m:

  et_fg3m

- et_fg3_pct:

  et_fg3_pct

- et_fga:

  et_fga

- et_fgm:

  et_fgm

- et_fg_pct:

  et_fg_pct

- et_fta:

  et_fta

- et_ftm:

  et_ftm

- et_ft_pct:

  et_ft_pct

- et_minutes:

  et_minutes

- et_oreb:

  et_oreb

- et_pf:

  et_pf

- et_pts:

  et_pts

- et_reb:

  et_reb

- et_stl:

  et_stl

- et_td:

  et_td

- et_tov:

  et_tov

- game_id:

  game_id

- gt_ast:

  gt_ast

- gt_blk:

  gt_blk

- gt_dd:

  gt_dd

- gt_dreb:

  gt_dreb

- gt_fg3a:

  gt_fg3a

- gt_fg3m:

  gt_fg3m

- gt_fg3_pct:

  gt_fg3_pct

- gt_fga:

  gt_fga

- gt_fgm:

  gt_fgm

- gt_fg_pct:

  gt_fg_pct

- gt_fta:

  gt_fta

- gt_ftm:

  gt_ftm

- gt_ft_pct:

  gt_ft_pct

- gt_minutes:

  gt_minutes

- gt_oreb:

  gt_oreb

- gt_pf:

  gt_pf

- gt_pts:

  gt_pts

- gt_reb:

  gt_reb

- gt_stl:

  gt_stl

- gt_td:

  gt_td

- gt_tov:

  gt_tov

- location:

  location

- lt_ast:

  lt_ast

- lt_blk:

  lt_blk

- lt_dd:

  lt_dd

- lt_dreb:

  lt_dreb

- lt_fg3a:

  lt_fg3a

- lt_fg3m:

  lt_fg3m

- lt_fg3_pct:

  lt_fg3_pct

- lt_fga:

  lt_fga

- lt_fgm:

  lt_fgm

- lt_fg_pct:

  lt_fg_pct

- lt_fta:

  lt_fta

- lt_ftm:

  lt_ftm

- lt_ft_pct:

  lt_ft_pct

- lt_minutes:

  lt_minutes

- lt_oreb:

  lt_oreb

- lt_pf:

  lt_pf

- lt_pts:

  lt_pts

- lt_reb:

  lt_reb

- lt_stl:

  lt_stl

- lt_td:

  lt_td

- lt_tov:

  lt_tov

- outcome:

  outcome

- po_round:

  po_round

- player_id:

  player_id

- rookie_year:

  rookie_year

- season_segment:

  season_segment

- starter_bench:

  starter_bench

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- vs_team_id:

  vs_team_id

- years_experience:

  years_experience

- section:

  Section filter - 'group' or 'knockout'

## Value

Return a named list of data frames: LeagueGameLog

**LeagueGameLog**

|  |  |  |
|----|----|----|
| col_name | types | description |
| SEASON_ID | character | Unique season identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| GAME_ID | character | Unique game identifier. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| MATCHUP | character | Matchup. |
| WL | character | Wl. |
| MIN | character | Minutes played. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| TOV | character | Turnovers. |
| PF | character | Personal fouls. |
| PTS | character | Points scored. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |
| VIDEO_AVAILABLE | character | Video available. |

Return a named list of data frames: Standings

**Standings**

|                         |           |                              |
|-------------------------|-----------|------------------------------|
| col_name                | types     | description                  |
| LeagueID                | character |                              |
| SeasonID                | character |                              |
| TeamID                  | character | Teamid.                      |
| TeamCity                | character | Teamcity.                    |
| TeamName                | character | Teamname.                    |
| Conference              | character | Conference.                  |
| ConferenceRecord        | character |                              |
| PlayoffRank             | character |                              |
| ClinchIndicator         | character |                              |
| Division                | character | Team division.               |
| DivisionRecord          | character |                              |
| DivisionRank            | character |                              |
| WINS                    | character | Total wins.                  |
| LOSSES                  | character | Total losses.                |
| WinPCT                  | character |                              |
| LeagueRank              | character |                              |
| Record                  | character | Record string (e.g. '12-4'). |
| HOME                    | character | Home.                        |
| ROAD                    | character | Road.                        |
| L10                     | character |                              |
| Last10Home              | character |                              |
| Last10Road              | character |                              |
| OT                      | character | Ot.                          |
| ThreePTSOrLess          | character |                              |
| TenPTSOrMore            | character |                              |
| LongHomeStreak          | character |                              |
| strLongHomeStreak       | character |                              |
| LongRoadStreak          | character |                              |
| strLongRoadStreak       | character |                              |
| LongWinStreak           | character |                              |
| LongLossStreak          | character |                              |
| CurrentHomeStreak       | character |                              |
| strCurrentHomeStreak    | character |                              |
| CurrentRoadStreak       | character |                              |
| strCurrentRoadStreak    | character |                              |
| CurrentStreak           | character |                              |
| strCurrentStreak        | character |                              |
| ConferenceGamesBack     | character |                              |
| DivisionGamesBack       | character |                              |
| ClinchedConferenceTitle | character |                              |
| ClinchedDivisionTitle   | character |                              |
| ClinchedPlayoffBirth    | character |                              |
| EliminatedConference    | character |                              |
| EliminatedDivision      | character |                              |
| AheadAtHalf             | character |                              |
| BehindAtHalf            | character |                              |
| TiedAtHalf              | character |                              |
| AheadAtThird            | character |                              |
| BehindAtThird           | character |                              |
| TiedAtThird             | character |                              |
| Score100PTS             | character |                              |
| OppScore100PTS          | character |                              |
| OppOver500              | character |                              |
| LeadInFGPCT             | character |                              |
| LeadInReb               | character |                              |
| FewerTurnovers          | character |                              |
| PointsPG                | character |                              |
| OppPointsPG             | character |                              |
| DiffPointsPG            | character |                              |
| vsEast                  | character |                              |
| vsAtlantic              | character |                              |
| vsCentral               | character |                              |
| vsSoutheast             | character |                              |
| vsWest                  | character |                              |
| vsNorthwest             | character |                              |
| vsPacific               | character |                              |
| vsSouthwest             | character |                              |
| Jan                     | character |                              |
| Feb                     | character |                              |
| Mar                     | character |                              |
| Apr                     | character |                              |
| May                     | character |                              |
| Jun                     | character |                              |
| Jul                     | character |                              |
| Aug                     | character |                              |
| Sep                     | character |                              |
| Oct                     | character |                              |
| Nov                     | character |                              |
| Dec                     | character |                              |
| PreAS                   | character |                              |
| PostAS                  | character |                              |

Return a named list of data frames: Standings

**Standings**

|                         |           |                              |
|-------------------------|-----------|------------------------------|
| col_name                | types     | description                  |
| LeagueID                | character |                              |
| SeasonID                | character |                              |
| TeamID                  | character | Teamid.                      |
| TeamCity                | character | Teamcity.                    |
| TeamName                | character | Teamname.                    |
| TeamSlug                | character |                              |
| Conference              | character | Conference.                  |
| ConferenceRecord        | character |                              |
| PlayoffRank             | character |                              |
| ClinchIndicator         | character |                              |
| Division                | character | Team division.               |
| DivisionRecord          | character |                              |
| DivisionRank            | character |                              |
| WINS                    | character | Total wins.                  |
| LOSSES                  | character | Total losses.                |
| WinPCT                  | character |                              |
| LeagueRank              | character |                              |
| Record                  | character | Record string (e.g. '12-4'). |
| HOME                    | character | Home.                        |
| ROAD                    | character | Road.                        |
| L10                     | character |                              |
| Last10Home              | character |                              |
| Last10Road              | character |                              |
| OT                      | character | Ot.                          |
| ThreePTSOrLess          | character |                              |
| TenPTSOrMore            | character |                              |
| LongHomeStreak          | character |                              |
| strLongHomeStreak       | character |                              |
| LongRoadStreak          | character |                              |
| strLongRoadStreak       | character |                              |
| LongWinStreak           | character |                              |
| LongLossStreak          | character |                              |
| CurrentHomeStreak       | character |                              |
| strCurrentHomeStreak    | character |                              |
| CurrentRoadStreak       | character |                              |
| strCurrentRoadStreak    | character |                              |
| CurrentStreak           | character |                              |
| strCurrentStreak        | character |                              |
| ConferenceGamesBack     | character |                              |
| DivisionGamesBack       | character |                              |
| ClinchedConferenceTitle | character |                              |
| ClinchedDivisionTitle   | character |                              |
| ClinchedPlayoffBirth    | character |                              |
| ClinchedPlayIn          | character |                              |
| EliminatedConference    | character |                              |
| EliminatedDivision      | character |                              |
| AheadAtHalf             | character |                              |
| BehindAtHalf            | character |                              |
| TiedAtHalf              | character |                              |
| AheadAtThird            | character |                              |
| BehindAtThird           | character |                              |
| TiedAtThird             | character |                              |
| Score100PTS             | character |                              |
| OppScore100PTS          | character |                              |
| OppOver500              | character |                              |
| LeadInFGPCT             | character |                              |
| LeadInReb               | character |                              |
| FewerTurnovers          | character |                              |
| PointsPG                | character |                              |
| OppPointsPG             | character |                              |
| DiffPointsPG            | character |                              |
| vsEast                  | character |                              |
| vsAtlantic              | character |                              |
| vsCentral               | character |                              |
| vsSoutheast             | character |                              |
| vsWest                  | character |                              |
| vsNorthwest             | character |                              |
| vsPacific               | character |                              |
| vsSouthwest             | character |                              |
| Jan                     | character |                              |
| Feb                     | character |                              |
| Mar                     | character |                              |
| Apr                     | character |                              |
| May                     | character |                              |
| Jun                     | character |                              |
| Jul                     | character |                              |
| Aug                     | character |                              |
| Sep                     | character |                              |
| Oct                     | character |                              |
| Nov                     | character |                              |
| Dec                     | character |                              |
| Score_80_Plus           | character |                              |
| Opp_Score_80_Plus       | character |                              |
| Score_Below_80          | character |                              |
| Opp_Score_Below_80      | character |                              |
| TotalPoints             | character |                              |
| OppTotalPoints          | character |                              |
| DiffTotalPoints         | character |                              |

Return a named list of data frames: EastConfPlayoffPicture,
EastConfRemainingGames, EastConfStandings, WestConfPlayoffPicture,
WestConfRemainingGames, WestConfStandings

**EastConfPlayoffPicture**

|                                   |           |             |
|-----------------------------------|-----------|-------------|
| col_name                          | types     | description |
| CONFERENCE                        | character | Conference. |
| HIGH_SEED_RANK                    | character |             |
| HIGH_SEED_TEAM                    | character |             |
| HIGH_SEED_TEAM_ID                 | character |             |
| LOW_SEED_RANK                     | character |             |
| LOW_SEED_TEAM                     | character |             |
| LOW_SEED_TEAM_ID                  | character |             |
| HIGH_SEED_SERIES_W                | character |             |
| HIGH_SEED_SERIES_L                | character |             |
| HIGH_SEED_SERIES_REMAINING_G      | character |             |
| HIGH_SEED_SERIES_REMAINING_HOME_G | character |             |
| HIGH_SEED_SERIES_REMAINING_AWAY_G | character |             |

**WestConfPlayoffPicture**

Same columns as the **EastConfPlayoffPicture** table above.

**EastConfStandings**

|  |  |  |
|----|----|----|
| col_name | types | description |
| CONFERENCE | character | Conference. |
| RANK | character | Rank. |
| TEAM | character | Team-side label or team identifier. |
| TEAM_SLUG | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| TEAM_ID | character | Unique team identifier. |
| WINS | character | Total wins. |
| LOSSES | character | Total losses. |
| PCT | character | Pct. |
| DIV | character |  |
| CONF | character | character. |
| HOME | character | Home. |
| AWAY | character |  |
| GB | character |  |
| GR_OVER_500 | character |  |
| GR_OVER_500_HOME | character |  |
| GR_OVER_500_AWAY | character |  |
| GR_UNDER_500 | character |  |
| GR_UNDER_500_HOME | character |  |
| GR_UNDER_500_AWAY | character |  |
| RANKING_CRITERIA | character |  |
| CLINCHED_PLAYOFFS | character |  |
| CLINCHED_CONFERENCE | character |  |
| CLINCHED_DIVISION | character |  |
| ELIMINATED_PLAYOFFS | character |  |
| SOSA_REMAINING | character |  |

**WestConfStandings**

Same columns as the **EastConfStandings** table above.

**EastConfRemainingGames**

|                  |           |                                     |
|------------------|-----------|-------------------------------------|
| col_name         | types     | description                         |
| TEAM             | character | Team-side label or team identifier. |
| TEAM_ID          | character | Unique team identifier.             |
| REMAINING_G      | character |                                     |
| REMAINING_HOME_G | character |                                     |
| REMAINING_AWAY_G | character |                                     |

**WestConfRemainingGames**

Same columns as the **EastConfRemainingGames** table above.

Return a named list of data frames: LeagueGameFinderResults

**LeagueGameFinderResults**

|  |  |  |
|----|----|----|
| col_name | types | description |
| SEASON_ID | character | Unique season identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| GAME_ID | character | Unique game identifier. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| MATCHUP | character | Matchup. |
| WL | character | Wl. |
| MIN | character | Minutes played. |
| PTS | character | Points scored. |
| FGM | character | Field goals made. |
| FGA | character | Field goal attempts. |
| FG_PCT | character | Field goal percentage (0-1). |
| FG3M | character | Three-point field goals made. |
| FG3A | character | Three-point field goal attempts. |
| FG3_PCT | character | Three-point field goal percentage (0-1). |
| FTM | character | Free throws made. |
| FTA | character | Free throw attempts. |
| FT_PCT | character | Free throw percentage (0-1). |
| OREB | character | Offensive rebounds. |
| DREB | character | Defensive rebounds. |
| REB | character | Total rebounds. |
| AST | character | Assists. |
| STL | character | Steals. |
| BLK | character | Blocks. |
| TOV | character | Turnovers. |
| PF | character | Personal fouls. |
| PLUS_MINUS | character | Plus/minus point differential while on court. |

Returns a named list of data frames: Standings

**Standings**

|  |  |  |
|----|----|----|
| col_name | types | description |
| league_id | character | League identifier ('10' = WNBA). |
| season_year | character | Season year string ('YYYY-YY' format). |
| team_id | character | Unique team identifier. |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| conference | character | Conference. |
| ist_group | character | Ist group. |
| clinch_indicator | character | Playoff clinch indicator (e.g. 'x' clinched playoff, 'e' eliminated). |
| clinched_ist_knockout | character | Clinched ist knockout. |
| clinched_ist_group | character | Clinched ist group. |
| clinched_ist_wildcard | character | Clinched ist wildcard. |
| ist_wildcard_rank | character | League/season rank for ist wildcard. |
| ist_group_rank | character | League/season rank for ist group. |
| ist_knockout_rank | character | League/season rank for ist knockout. |
| wins | character | Total wins. |
| losses | character | Total losses. |
| pct | character | Pct. |
| ist_group_gb | character | Ist group gb. |
| ist_wildcard_gb | character | Ist wildcard gb. |
| diff | character | Diff. |
| pts | character | Points scored. |
| opp_pts | character | Opponent points. |

## Details

[Player/Team Boxscores](https://www.nba.com/stats/players/boxscores)

     nba_leaguegamelog(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[League Standings](https://www.nba.com/standings)

     nba_leaguestandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

[League Standings](https://www.nba.com/standings)

     nba_leaguestandingsv3(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

     nba_playoffpicture(league_id = '00', season_id = paste0(2, most_recent_nba_season() - 1))

     nba_leaguegamefinder(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

     nba_iststandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_fantasywidget()`](https://hoopR.sportsdataverse.org/reference/nba_fantasywidget.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_shotchartdetail()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartdetail.md)

Other NBA Game Finder Functions:
[`nba_playerindex()`](https://hoopR.sportsdataverse.org/reference/nba_infographicfanduelplayer.md),
[`nba_teams()`](https://hoopR.sportsdataverse.org/reference/nba_teamplayeronoffdetails.md)

## Author

Saiem Gilani
