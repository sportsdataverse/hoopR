# nba_draftboard

##### Endpoint URL
>[https://stats.nba.com/stats/draftboard](https://stats.nba.com/stats/draftboard)

##### Valid URL
>[https://stats.nba.com/stats/draftboard?College=&LeagueID=00&OverallPick=&RoundNum=&RoundPick=&Season=2019&TeamID=&TopX=](https://stats.nba.com/stats/draftboard?College=&LeagueID=00&OverallPick=&RoundNum=&RoundPick=&Season=2019&TeamID=&TopX=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id | `^\d{2}$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season_year | `^\d{4}$` | `Y` |  | 
[_**TopX**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TopX) | topx_nullable |  |  | `Y` | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id_nullable |  |  | `Y` | 
[_**RoundPick**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RoundPick) | round_pick_nullable |  |  | `Y` | 
[_**RoundNum**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RoundNum) | round_num_nullable |  |  | `Y` | 
[_**OverallPick**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#OverallPick) | overall_pick_nullable |  |  | `Y` | 
[_**College**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#College) | college_nullable |  |  | `Y` | 

## Data Sets
#### DraftBoard `draft_board`
```text
['PERSON_ID', 'PLAYER_NAME', 'SEASON', 'ROUND_NUMBER', 'ROUND_PICK', 'OVERALL_PICK', 'TEAM_ID', 'TEAM_CITY', 'TEAM_NAME', 'TEAM_ABBREVIATION', 'ORGANIZATION', 'ORGANIZATION_TYPE', 'HEIGHT', 'WEIGHT', 'POSITION', 'JERSEY_NUMBER', 'BIRTHDATE', 'AGE']
```


## JSON
```json
{
    "data_sets": {
        "DraftBoard": [
            "PERSON_ID",
            "PLAYER_NAME",
            "SEASON",
            "ROUND_NUMBER",
            "ROUND_PICK",
            "OVERALL_PICK",
            "TEAM_ID",
            "TEAM_CITY",
            "TEAM_NAME",
            "TEAM_ABBREVIATION",
            "ORGANIZATION",
            "ORGANIZATION_TYPE",
            "HEIGHT",
            "WEIGHT",
            "POSITION",
            "JERSEY_NUMBER",
            "BIRTHDATE",
            "AGE"
        ]
    },
    "endpoint": "DraftBoard",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "College",
        "OverallPick",
        "RoundNum",
        "RoundPick",
        "TeamID",
        "TopX"
    ],
    "parameter_patterns": {
        "College": null,
        "LeagueID": "^\\d{2}$",
        "OverallPick": null,
        "RoundNum": null,
        "RoundPick": null,
        "Season": "^\\d{4}$",
        "TeamID": null,
        "TopX": null
    },
    "parameters": [
        "College",
        "LeagueID",
        "OverallPick",
        "RoundNum",
        "RoundPick",
        "Season",
        "TeamID",
        "TopX"
    ],
    "required_parameters": [
        "LeagueID",
        "Season"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
