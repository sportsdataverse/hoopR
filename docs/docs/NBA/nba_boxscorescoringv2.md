# nba_boxscorescoringv2

##### Endpoint URL
>[https://stats.nba.com/stats/boxscorescoringv2](https://stats.nba.com/stats/boxscorescoringv2)

##### Valid URL
>[https://stats.nba.com/stats/boxscorescoringv2?EndPeriod=1&EndRange=0&GameID=0021700807&RangeType=0&StartPeriod=1&StartRange=0](https://stats.nba.com/stats/boxscorescoringv2?EndPeriod=1&EndRange=0&GameID=0021700807&RangeType=0&StartPeriod=1&StartRange=0)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**EndPeriod**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EndPeriod) | end_period |  | `Y` |  | 
[_**EndRange**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EndRange) | end_range |  | `Y` |  | 
[_**GameID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameID) | game_id | `^\d{10}$` | `Y` |  | 
[_**RangeType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RangeType) | range_type |  | `Y` |  | 
[_**StartPeriod**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#StartPeriod) | start_period |  | `Y` |  | 
[_**StartRange**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#StartRange) | start_range |  | `Y` |  | 

## Data Sets
#### sqlPlayersScoring `sql_players_scoring`
```text
['GAME_ID', 'TEAM_ID', 'TEAM_ABBREVIATION', 'TEAM_CITY', 'PLAYER_ID', 'PLAYER_NAME', 'START_POSITION', 'COMMENT', 'MIN', 'PCT_FGA_2PT', 'PCT_FGA_3PT', 'PCT_PTS_2PT', 'PCT_PTS_2PT_MR', 'PCT_PTS_3PT', 'PCT_PTS_FB', 'PCT_PTS_FT', 'PCT_PTS_OFF_TOV', 'PCT_PTS_PAINT', 'PCT_AST_2PM', 'PCT_UAST_2PM', 'PCT_AST_3PM', 'PCT_UAST_3PM', 'PCT_AST_FGM', 'PCT_UAST_FGM']
```

#### sqlTeamsScoring `sql_teams_scoring`
```text
['GAME_ID', 'TEAM_ID', 'TEAM_NAME', 'TEAM_ABBREVIATION', 'TEAM_CITY', 'MIN', 'PCT_FGA_2PT', 'PCT_FGA_3PT', 'PCT_PTS_2PT', 'PCT_PTS_2PT_MR', 'PCT_PTS_3PT', 'PCT_PTS_FB', 'PCT_PTS_FT', 'PCT_PTS_OFF_TOV', 'PCT_PTS_PAINT', 'PCT_AST_2PM', 'PCT_UAST_2PM', 'PCT_AST_3PM', 'PCT_UAST_3PM', 'PCT_AST_FGM', 'PCT_UAST_FGM']
```


## JSON
```json
{
    "data_sets": {
        "sqlPlayersScoring": [
            "GAME_ID",
            "TEAM_ID",
            "TEAM_ABBREVIATION",
            "TEAM_CITY",
            "PLAYER_ID",
            "PLAYER_NAME",
            "START_POSITION",
            "COMMENT",
            "MIN",
            "PCT_FGA_2PT",
            "PCT_FGA_3PT",
            "PCT_PTS_2PT",
            "PCT_PTS_2PT_MR",
            "PCT_PTS_3PT",
            "PCT_PTS_FB",
            "PCT_PTS_FT",
            "PCT_PTS_OFF_TOV",
            "PCT_PTS_PAINT",
            "PCT_AST_2PM",
            "PCT_UAST_2PM",
            "PCT_AST_3PM",
            "PCT_UAST_3PM",
            "PCT_AST_FGM",
            "PCT_UAST_FGM"
        ],
        "sqlTeamsScoring": [
            "GAME_ID",
            "TEAM_ID",
            "TEAM_NAME",
            "TEAM_ABBREVIATION",
            "TEAM_CITY",
            "MIN",
            "PCT_FGA_2PT",
            "PCT_FGA_3PT",
            "PCT_PTS_2PT",
            "PCT_PTS_2PT_MR",
            "PCT_PTS_3PT",
            "PCT_PTS_FB",
            "PCT_PTS_FT",
            "PCT_PTS_OFF_TOV",
            "PCT_PTS_PAINT",
            "PCT_AST_2PM",
            "PCT_UAST_2PM",
            "PCT_AST_3PM",
            "PCT_UAST_3PM",
            "PCT_AST_FGM",
            "PCT_UAST_FGM"
        ]
    },
    "endpoint": "BoxScoreScoringV2",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [],
    "parameter_patterns": {
        "EndPeriod": null,
        "EndRange": null,
        "GameID": "^\\d{10}$",
        "RangeType": null,
        "StartPeriod": null,
        "StartRange": null
    },
    "parameters": [
        "EndPeriod",
        "EndRange",
        "GameID",
        "RangeType",
        "StartPeriod",
        "StartRange"
    ],
    "required_parameters": [
        "EndPeriod",
        "EndRange",
        "GameID",
        "RangeType",
        "StartPeriod",
        "StartRange"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
