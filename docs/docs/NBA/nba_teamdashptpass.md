# nba_teamdashptpass

##### Endpoint URL
>[https://stats.nba.com/stats/teamdashptpass](https://stats.nba.com/stats/teamdashptpass)

##### Valid URL
>[https://stats.nba.com/stats/teamdashptpass?DateFrom=&DateTo=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=1610612739&VsConference=&VsDivision=](https://stats.nba.com/stats/teamdashptpass?DateFrom=&DateTo=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=1610612739&VsConference=&VsDivision=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**LastNGames**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LastNGames) | last_n_games |  | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id |  | `Y` |  | 
[_**Month**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Month) | month |  | `Y` |  | 
[_**OpponentTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#OpponentTeamID) | opponent_team_id |  | `Y` |  | 
[_**PerMode**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PerMode) | per_mode_simple | `^(Totals)\|(PerGame)$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id |  | `Y` |  | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable | `^((Atlantic)\|(Central)\|(Northwest)\|(Pacific)\|(Southeast)\|(Southwest)\|(East)\|(West))?$` | `Y` | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable | `^((East)\|(West))?$` | `Y` | `Y` | 
[_**SeasonSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonSegment) | season_segment_nullable | `^((Post All-Star)\|(Pre All-Star))?$` | `Y` | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable | `^((W)\|(L))?$` | `Y` | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable | `^((Home)\|(Road))?$` | `Y` | `Y` | 
[_**DateTo**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateTo) | date_to_nullable |  | `Y` | `Y` | 
[_**DateFrom**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateFrom) | date_from_nullable |  | `Y` | `Y` | 

## Data Sets
#### PassesMade `passes_made`
```text
['TEAM_ID', 'TEAM_NAME', 'PASS_TYPE', 'G', 'PASS_FROM', 'PASS_TEAMMATE_PLAYER_ID', 'FREQUENCY', 'PASS', 'AST', 'FGM', 'FGA', 'FG_PCT', 'FG2M', 'FG2A', 'FG2_PCT', 'FG3M', 'FG3A', 'FG3_PCT']
```

#### PassesReceived `passes_received`
```text
['TEAM_ID', 'TEAM_NAME', 'PASS_TYPE', 'G', 'PASS_TO', 'PASS_TEAMMATE_PLAYER_ID', 'FREQUENCY', 'PASS', 'AST', 'FGM', 'FGA', 'FG_PCT', 'FG2M', 'FG2A', 'FG2_PCT', 'FG3M', 'FG3A', 'FG3_PCT']
```


## JSON
```json
{
    "data_sets": {
        "PassesMade": [
            "TEAM_ID",
            "TEAM_NAME",
            "PASS_TYPE",
            "G",
            "PASS_FROM",
            "PASS_TEAMMATE_PLAYER_ID",
            "FREQUENCY",
            "PASS",
            "AST",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG2M",
            "FG2A",
            "FG2_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT"
        ],
        "PassesReceived": [
            "TEAM_ID",
            "TEAM_NAME",
            "PASS_TYPE",
            "G",
            "PASS_TO",
            "PASS_TEAMMATE_PLAYER_ID",
            "FREQUENCY",
            "PASS",
            "AST",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG2M",
            "FG2A",
            "FG2_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT"
        ]
    },
    "endpoint": "TeamDashPtPass",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "DateFrom",
        "DateTo",
        "Location",
        "Outcome",
        "SeasonSegment",
        "VsConference",
        "VsDivision"
    ],
    "parameter_patterns": {
        "DateFrom": null,
        "DateTo": null,
        "LastNGames": null,
        "LeagueID": null,
        "Location": "^((Home)|(Road))?$",
        "Month": null,
        "OpponentTeamID": null,
        "Outcome": "^((W)|(L))?$",
        "PerMode": "^(Totals)|(PerGame)$",
        "Season": null,
        "SeasonSegment": "^((Post All-Star)|(Pre All-Star))?$",
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "TeamID": null,
        "VsConference": "^((East)|(West))?$",
        "VsDivision": "^((Atlantic)|(Central)|(Northwest)|(Pacific)|(Southeast)|(Southwest)|(East)|(West))?$"
    },
    "parameters": [
        "DateFrom",
        "DateTo",
        "LastNGames",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PerMode",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "TeamID",
        "VsConference",
        "VsDivision"
    ],
    "required_parameters": [
        "DateFrom",
        "DateTo",
        "LastNGames",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PerMode",
        "Season",
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
