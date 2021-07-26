# LeagueDashPtTeamDefend
##### [nba_api/stats/endpoints/leaguedashptteamdefend.py](https://github.com/swar/nba_api/blob/master/nba_api/stats/endpoints/leaguedashptteamdefend.py)

##### Endpoint URL
>[https://stats.nba.com/stats/leaguedashptteamdefend](https://stats.nba.com/stats/leaguedashptteamdefend)

##### Valid URL
>[https://stats.nba.com/stats/leaguedashptteamdefend?Conference=&DateFrom=&DateTo=&DefenseCategory=Overall&Division=&GameSegment=&LastNGames=&LeagueID=00&Location=&Month=&OpponentTeamID=&Outcome=&PORound=&PerMode=Totals&Period=&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=&VsConference=&VsDivision=](https://stats.nba.com/stats/leaguedashptteamdefend?Conference=&DateFrom=&DateTo=&DefenseCategory=Overall&Division=&GameSegment=&LastNGames=&LeagueID=00&Location=&Month=&OpponentTeamID=&Outcome=&PORound=&PerMode=Totals&Period=&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=&VsConference=&VsDivision=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**DefenseCategory**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DefenseCategory) | defense_category | `^((Overall)\|(3 Pointers)\|(2 Pointers)\|(Less Than 6Ft)\|(Less Than 10Ft)\|(Greater Than 15Ft))?$` | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id | `^\d{2}$` | `Y` |  | 
[_**PerMode**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PerMode) | per_mode_simple | `^(Totals)\|(PerGame)$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable | `^((Atlantic)\|(Central)\|(Northwest)\|(Pacific)\|(Southeast)\|(Southwest)\|(East)\|(West))?$` |  | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable | `^((East)\|(West))?$` |  | `Y` | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id_nullable |  |  | `Y` | 
[_**SeasonSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonSegment) | season_segment_nullable | `^((Post All-Star)\|(Pre All-Star))?$` |  | `Y` | 
[_**Period**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Period) | period_nullable |  |  | `Y` | 
[_**PORound**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PORound) | po_round_nullable |  |  | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable | `^((W)\|(L))?$` |  | `Y` | 
[_**OpponentTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#OpponentTeamID) | opponent_team_id_nullable |  |  | `Y` | 
[_**Month**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Month) | month_nullable |  |  | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable | `^((Home)\|(Road))?$` |  | `Y` | 
[_**LastNGames**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LastNGames) | last_n_games_nullable |  |  | `Y` | 
[_**GameSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameSegment) | game_segment_nullable | `^((First Half)\|(Overtime)\|(Second Half))?$` |  | `Y` | 
[_**Division**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Division) | division_nullable | `^((Atlantic)\|(Central)\|(Northwest)\|(Pacific)\|(Southeast)\|(Southwest)\|(East)\|(West))?$` |  | `Y` | 
[_**DateTo**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateTo) | date_to_nullable |  |  | `Y` | 
[_**DateFrom**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateFrom) | date_from_nullable |  |  | `Y` | 
[_**Conference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Conference) | conference_nullable | `^((East)\|(West))?$` |  | `Y` | 

## Data Sets
#### LeagueDashPtTeamDefend `league_dash_pt_team_defend`
```text
['TEAM_ID', 'TEAM_NAME', 'TEAM_ABBREVIATION', 'GP', 'G', 'FREQ', 'D_FGM', 'D_FGA', 'D_FG_PCT', 'NORMAL_FG_PCT', 'PCT_PLUSMINUS']
```


## JSON
```json
{
    "data_sets": {
        "LeagueDashPtTeamDefend": [
            "TEAM_ID",
            "TEAM_NAME",
            "TEAM_ABBREVIATION",
            "GP",
            "G",
            "FREQ",
            "D_FGM",
            "D_FGA",
            "D_FG_PCT",
            "NORMAL_FG_PCT",
            "PCT_PLUSMINUS"
        ]
    },
    "endpoint": "LeagueDashPtTeamDefend",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "Conference",
        "DateFrom",
        "DateTo",
        "Division",
        "GameSegment",
        "LastNGames",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PORound",
        "Period",
        "SeasonSegment",
        "TeamID",
        "VsConference",
        "VsDivision"
    ],
    "parameter_patterns": {
        "Conference": "^((East)|(West))?$",
        "DateFrom": null,
        "DateTo": null,
        "DefenseCategory": "^((Overall)|(3 Pointers)|(2 Pointers)|(Less Than 6Ft)|(Less Than 10Ft)|(Greater Than 15Ft))?$",
        "Division": "^((Atlantic)|(Central)|(Northwest)|(Pacific)|(Southeast)|(Southwest)|(East)|(West))?$",
        "GameSegment": "^((First Half)|(Overtime)|(Second Half))?$",
        "LastNGames": null,
        "LeagueID": "^\\d{2}$",
        "Location": "^((Home)|(Road))?$",
        "Month": null,
        "OpponentTeamID": null,
        "Outcome": "^((W)|(L))?$",
        "PORound": null,
        "PerMode": "^(Totals)|(PerGame)$",
        "Period": null,
        "Season": null,
        "SeasonSegment": "^((Post All-Star)|(Pre All-Star))?$",
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "TeamID": null,
        "VsConference": "^((East)|(West))?$",
        "VsDivision": "^((Atlantic)|(Central)|(Northwest)|(Pacific)|(Southeast)|(Southwest)|(East)|(West))?$"
    },
    "parameters": [
        "Conference",
        "DateFrom",
        "DateTo",
        "DefenseCategory",
        "Division",
        "GameSegment",
        "LastNGames",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PORound",
        "PerMode",
        "Period",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "TeamID",
        "VsConference",
        "VsDivision"
    ],
    "required_parameters": [
        "DefenseCategory",
        "LeagueID",
        "PerMode",
        "Season",
        "SeasonType"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
