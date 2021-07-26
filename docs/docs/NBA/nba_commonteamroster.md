# CommonTeamRoster
##### [nba_api/stats/endpoints/commonteamroster.py](https://github.com/swar/nba_api/blob/master/nba_api/stats/endpoints/commonteamroster.py)

##### Endpoint URL
>[https://stats.nba.com/stats/commonteamroster](https://stats.nba.com/stats/commonteamroster)

##### Valid URL
>[https://stats.nba.com/stats/commonteamroster?LeagueID=&Season=2019-20&TeamID=1610612739](https://stats.nba.com/stats/commonteamroster?LeagueID=&Season=2019-20&TeamID=1610612739)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id |  | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id_nullable |  |  | `Y` | 

## Data Sets
#### Coaches `coaches`
```text
['TEAM_ID', 'SEASON', 'COACH_ID', 'FIRST_NAME', 'LAST_NAME', 'COACH_NAME', 'IS_ASSISTANT', 'COACH_TYPE', 'SORT_SEQUENCE']
```

#### CommonTeamRoster `common_team_roster`
```text
['TeamID', 'SEASON', 'LeagueID', 'PLAYER', 'PLAYER_SLUG', 'NUM', 'POSITION', 'HEIGHT', 'WEIGHT', 'BIRTH_DATE', 'AGE', 'EXP', 'SCHOOL', 'PLAYER_ID']
```


## JSON
```json
{
    "data_sets": {
        "Coaches": [
            "TEAM_ID",
            "SEASON",
            "COACH_ID",
            "FIRST_NAME",
            "LAST_NAME",
            "COACH_NAME",
            "IS_ASSISTANT",
            "COACH_TYPE",
            "SORT_SEQUENCE"
        ],
        "CommonTeamRoster": [
            "TeamID",
            "SEASON",
            "LeagueID",
            "PLAYER",
            "PLAYER_SLUG",
            "NUM",
            "POSITION",
            "HEIGHT",
            "WEIGHT",
            "BIRTH_DATE",
            "AGE",
            "EXP",
            "SCHOOL",
            "PLAYER_ID"
        ]
    },
    "endpoint": "CommonTeamRoster",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "LeagueID"
    ],
    "parameter_patterns": {
        "LeagueID": null,
        "Season": null,
        "TeamID": null
    },
    "parameters": [
        "LeagueID",
        "Season",
        "TeamID"
    ],
    "required_parameters": [
        "Season",
        "TeamID"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
