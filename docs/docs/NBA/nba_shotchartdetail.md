# nba_shotchartdetail

##### Endpoint URL
>[https://stats.nba.com/stats/shotchartdetail](https://stats.nba.com/stats/shotchartdetail)

##### Valid URL
>[https://stats.nba.com/stats/shotchartdetail?AheadBehind=&ClutchTime=&ContextFilter=&ContextMeasure=PTS&DateFrom=&DateTo=&EndPeriod=&EndRange=&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&Period=0&PlayerID=2544&PlayerPosition=&PointDiff=&Position=&RangeType=&RookieYear=&Season=&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=&StartRange=&TeamID=1610612739&VsConference=&VsDivision=](https://stats.nba.com/stats/shotchartdetail?AheadBehind=&ClutchTime=&ContextFilter=&ContextMeasure=PTS&DateFrom=&DateTo=&EndPeriod=&EndRange=&GameID=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&Period=0&PlayerID=2544&PlayerPosition=&PointDiff=&Position=&RangeType=&RookieYear=&Season=&SeasonSegment=&SeasonType=Regular+Season&StartPeriod=&StartRange=&TeamID=1610612739&VsConference=&VsDivision=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**ContextMeasure**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#ContextMeasure) | context_measure_simple | `^((PTS)\|(FGM)\|(FGA)\|(FG_PCT)\|(FG3M)\|(FG3A)\|(FG3_PCT)\|(PF)\|(EFG_PCT)\|(TS_PCT)\|(PTS_FB)\|(PTS_OFF_TOV)\|(PTS_2ND_CHANCE)\|(PF))?$` | `Y` |  | 
[_**LastNGames**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LastNGames) | last_n_games |  | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id |  | `Y` |  | 
[_**Month**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Month) | month |  | `Y` |  | 
[_**OpponentTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#OpponentTeamID) | opponent_team_id |  | `Y` |  | 
[_**Period**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Period) | period |  | `Y` |  | 
[_**PlayerID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerID) | player_id |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id |  | `Y` |  | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable | `^((Atlantic)\|(Central)\|(Northwest)\|(Pacific)\|(Southeast)\|(Southwest)\|(East)\|(West))?$` | `Y` | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable | `^((East)\|(West))?$` | `Y` | `Y` | 
[_**StartRange**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#StartRange) | start_range_nullable |  |  | `Y` | 
[_**StartPeriod**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#StartPeriod) | start_period_nullable |  |  | `Y` | 
[_**SeasonSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonSegment) | season_segment_nullable | `^((Post All-Star)\|(Pre All-Star))?$` | `Y` | `Y` | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season_nullable |  |  | `Y` | 
[_**RookieYear**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RookieYear) | rookie_year_nullable |  | `Y` | `Y` | 
[_**RangeType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RangeType) | range_type_nullable |  |  | `Y` | 
[_**Position**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Position) | position_nullable |  |  | `Y` | 
[_**PointDiff**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PointDiff) | point_diff_nullable |  |  | `Y` | 
[_**PlayerPosition**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerPosition) | player_position_nullable | `^((Guard)\|(Center)\|(Forward))?$` | `Y` | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable | `^((W)\|(L))?$` | `Y` | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable | `^((Home)\|(Road))?$` | `Y` | `Y` | 
[_**GameSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameSegment) | game_segment_nullable | `^((First Half)\|(Overtime)\|(Second Half))?$` | `Y` | `Y` | 
[_**GameID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameID) | game_id_nullable | `^(\d{10})?$` | `Y` | `Y` | 
[_**EndRange**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EndRange) | end_range_nullable |  |  | `Y` | 
[_**EndPeriod**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EndPeriod) | end_period_nullable |  |  | `Y` | 
[_**DateTo**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateTo) | date_to_nullable |  | `Y` | `Y` | 
[_**DateFrom**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateFrom) | date_from_nullable |  | `Y` | `Y` | 
[_**ContextFilter**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#ContextFilter) | context_filter_nullable |  |  | `Y` | 
[_**ClutchTime**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#ClutchTime) | clutch_time_nullable | `^((Last 5 Minutes)\|(Last 4 Minutes)\|(Last 3 Minutes)\|(Last 2 Minutes)\|(Last 1 Minute)\|(Last 30 Seconds)\|(Last 10 Seconds))?$` |  | `Y` | 
[_**AheadBehind**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#AheadBehind) | ahead_behind_nullable | `^((Ahead or Behind)\|(Ahead or Tied)\|(Behind or Tied))?$` |  | `Y` | 

## Data Sets
#### LeagueAverages `league_averages`
```text
['GRID_TYPE', 'SHOT_ZONE_BASIC', 'SHOT_ZONE_AREA', 'SHOT_ZONE_RANGE', 'FGA', 'FGM', 'FG_PCT']
```

#### Shot_Chart_Detail `shot_chart_detail`
```text
['GRID_TYPE', 'GAME_ID', 'GAME_EVENT_ID', 'PLAYER_ID', 'PLAYER_NAME', 'TEAM_ID', 'TEAM_NAME', 'PERIOD', 'MINUTES_REMAINING', 'SECONDS_REMAINING', 'EVENT_TYPE', 'ACTION_TYPE', 'SHOT_TYPE', 'SHOT_ZONE_BASIC', 'SHOT_ZONE_AREA', 'SHOT_ZONE_RANGE', 'SHOT_DISTANCE', 'LOC_X', 'LOC_Y', 'SHOT_ATTEMPTED_FLAG', 'SHOT_MADE_FLAG', 'GAME_DATE', 'HTM', 'VTM']
```


## JSON
```json
{
    "data_sets": {
        "LeagueAverages": [
            "GRID_TYPE",
            "SHOT_ZONE_BASIC",
            "SHOT_ZONE_AREA",
            "SHOT_ZONE_RANGE",
            "FGA",
            "FGM",
            "FG_PCT"
        ],
        "Shot_Chart_Detail": [
            "GRID_TYPE",
            "GAME_ID",
            "GAME_EVENT_ID",
            "PLAYER_ID",
            "PLAYER_NAME",
            "TEAM_ID",
            "TEAM_NAME",
            "PERIOD",
            "MINUTES_REMAINING",
            "SECONDS_REMAINING",
            "EVENT_TYPE",
            "ACTION_TYPE",
            "SHOT_TYPE",
            "SHOT_ZONE_BASIC",
            "SHOT_ZONE_AREA",
            "SHOT_ZONE_RANGE",
            "SHOT_DISTANCE",
            "LOC_X",
            "LOC_Y",
            "SHOT_ATTEMPTED_FLAG",
            "SHOT_MADE_FLAG",
            "GAME_DATE",
            "HTM",
            "VTM"
        ]
    },
    "endpoint": "ShotChartDetail",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "AheadBehind",
        "ClutchTime",
        "ContextFilter",
        "DateFrom",
        "DateTo",
        "EndPeriod",
        "EndRange",
        "GameID",
        "GameSegment",
        "Location",
        "Outcome",
        "PlayerPosition",
        "PointDiff",
        "Position",
        "RangeType",
        "RookieYear",
        "Season",
        "SeasonSegment",
        "StartPeriod",
        "StartRange",
        "VsConference",
        "VsDivision"
    ],
    "parameter_patterns": {
        "AheadBehind": "^((Ahead or Behind)|(Ahead or Tied)|(Behind or Tied))?$",
        "ClutchTime": "^((Last 5 Minutes)|(Last 4 Minutes)|(Last 3 Minutes)|(Last 2 Minutes)|(Last 1 Minute)|(Last 30 Seconds)|(Last 10 Seconds))?$",
        "ContextFilter": null,
        "ContextMeasure": "^((PTS)|(FGM)|(FGA)|(FG_PCT)|(FG3M)|(FG3A)|(FG3_PCT)|(PF)|(EFG_PCT)|(TS_PCT)|(PTS_FB)|(PTS_OFF_TOV)|(PTS_2ND_CHANCE)|(PF))?$",
        "DateFrom": null,
        "DateTo": null,
        "EndPeriod": null,
        "EndRange": null,
        "GameID": "^(\\d{10})?$",
        "GameSegment": "^((First Half)|(Overtime)|(Second Half))?$",
        "LastNGames": null,
        "LeagueID": null,
        "Location": "^((Home)|(Road))?$",
        "Month": null,
        "OpponentTeamID": null,
        "Outcome": "^((W)|(L))?$",
        "Period": null,
        "PlayerID": null,
        "PlayerPosition": "^((Guard)|(Center)|(Forward))?$",
        "PointDiff": null,
        "Position": null,
        "RangeType": null,
        "RookieYear": null,
        "Season": null,
        "SeasonSegment": "^((Post All-Star)|(Pre All-Star))?$",
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "StartPeriod": null,
        "StartRange": null,
        "TeamID": null,
        "VsConference": "^((East)|(West))?$",
        "VsDivision": "^((Atlantic)|(Central)|(Northwest)|(Pacific)|(Southeast)|(Southwest)|(East)|(West))?$"
    },
    "parameters": [
        "AheadBehind",
        "ClutchTime",
        "ContextFilter",
        "ContextMeasure",
        "DateFrom",
        "DateTo",
        "EndPeriod",
        "EndRange",
        "GameID",
        "GameSegment",
        "LastNGames",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "Period",
        "PlayerID",
        "PlayerPosition",
        "PointDiff",
        "Position",
        "RangeType",
        "RookieYear",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "StartPeriod",
        "StartRange",
        "TeamID",
        "VsConference",
        "VsDivision"
    ],
    "required_parameters": [
        "ContextMeasure",
        "DateFrom",
        "DateTo",
        "GameID",
        "GameSegment",
        "LastNGames",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "Period",
        "PlayerID",
        "PlayerPosition",
        "RookieYear",
        "SeasonSegment",
        "SeasonType",
        "TeamID",
        "VsConference",
        "VsDivision"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
