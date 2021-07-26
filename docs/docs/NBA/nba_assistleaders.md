# AssistLeaders
##### [nba_api/stats/endpoints/assistleaders.py](https://github.com/swar/nba_api/blob/master/nba_api/stats/endpoints/assistleaders.py)

##### Endpoint URL
>[https://stats.nba.com/stats/assistleaders](https://stats.nba.com/stats/assistleaders)

##### Valid URL
>[https://stats.nba.com/stats/assistleaders?LeagueID=00&PerMode=Totals&PlayerOrTeam=Team&Season=2019-20&SeasonType=Regular+Season](https://stats.nba.com/stats/assistleaders?LeagueID=00&PerMode=Totals&PlayerOrTeam=Team&Season=2019-20&SeasonType=Regular+Season)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id | `^\d{2}$` | `Y` |  | 
[_**PerMode**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PerMode) | per_mode_simple | `^(Totals)\|(PerGame)$` | `Y` |  | 
[_**PlayerOrTeam**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerOrTeam) | player_or_team | `^(Player)\|(Team)$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season | `^(\d{4}-\d{2})$` | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_playoffs | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(Pre-Season)$` | `Y` |  | 

## Data Sets
#### AssistLeaders `assist_leaders`
```text
['RANK', 'TEAM_ID', 'TEAM_ABBREVIATION', 'TEAM_NAME', 'AST']
```


## JSON
```json
{
    "data_sets": {
        "AssistLeaders": [
            "RANK",
            "TEAM_ID",
            "TEAM_ABBREVIATION",
            "TEAM_NAME",
            "AST"
        ]
    },
    "endpoint": "AssistLeaders",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [],
    "parameter_patterns": {
        "LeagueID": "^\\d{2}$",
        "PerMode": "^(Totals)|(PerGame)$",
        "PlayerOrTeam": "^(Player)|(Team)$",
        "Season": "^(\\d{4}-\\d{2})$",
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(Pre-Season)$"
    },
    "parameters": [
        "LeagueID",
        "PerMode",
        "PlayerOrTeam",
        "Season",
        "SeasonType"
    ],
    "required_parameters": [
        "LeagueID",
        "PerMode",
        "PlayerOrTeam",
        "Season",
        "SeasonType"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
