# nba_gamerotation

##### Endpoint URL
>[https://stats.nba.com/stats/gamerotation](https://stats.nba.com/stats/gamerotation)

##### Valid URL
>[https://stats.nba.com/stats/gamerotation?GameID=0021700807&LeagueID=00](https://stats.nba.com/stats/gamerotation?GameID=0021700807&LeagueID=00)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**GameID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameID) | game_id | `^\d{10}$` | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id |  | `Y` |  | 

## Data Sets
#### AwayTeam `away_team`
```text
['GAME_ID', 'TEAM_ID', 'TEAM_CITY', 'TEAM_NAME', 'PERSON_ID', 'PLAYER_FIRST', 'PLAYER_LAST', 'IN_TIME_REAL', 'OUT_TIME_REAL', 'PLAYER_PTS', 'PT_DIFF', 'USG_PCT']
```

#### HomeTeam `home_team`
```text
['GAME_ID', 'TEAM_ID', 'TEAM_CITY', 'TEAM_NAME', 'PERSON_ID', 'PLAYER_FIRST', 'PLAYER_LAST', 'IN_TIME_REAL', 'OUT_TIME_REAL', 'PLAYER_PTS', 'PT_DIFF', 'USG_PCT']
```


## JSON
```json
{
    "data_sets": {
        "AwayTeam": [
            "GAME_ID",
            "TEAM_ID",
            "TEAM_CITY",
            "TEAM_NAME",
            "PERSON_ID",
            "PLAYER_FIRST",
            "PLAYER_LAST",
            "IN_TIME_REAL",
            "OUT_TIME_REAL",
            "PLAYER_PTS",
            "PT_DIFF",
            "USG_PCT"
        ],
        "HomeTeam": [
            "GAME_ID",
            "TEAM_ID",
            "TEAM_CITY",
            "TEAM_NAME",
            "PERSON_ID",
            "PLAYER_FIRST",
            "PLAYER_LAST",
            "IN_TIME_REAL",
            "OUT_TIME_REAL",
            "PLAYER_PTS",
            "PT_DIFF",
            "USG_PCT"
        ]
    },
    "endpoint": "GameRotation",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [],
    "parameter_patterns": {
        "GameID": "^\\d{10}$",
        "LeagueID": null
    },
    "parameters": [
        "GameID",
        "LeagueID"
    ],
    "required_parameters": [
        "GameID",
        "LeagueID"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
