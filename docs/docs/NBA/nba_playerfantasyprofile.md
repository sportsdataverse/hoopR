# nba_playerfantasyprofile

##### Endpoint URL
>[https://stats.nba.com/stats/playerfantasyprofile](https://stats.nba.com/stats/playerfantasyprofile)

##### Valid URL
>[https://stats.nba.com/stats/playerfantasyprofile?LeagueID=&MeasureType=Base&PaceAdjust=N&PerMode=Totals&PlayerID=2544&PlusMinus=N&Rank=N&Season=2019-20&SeasonType=Regular+Season](https://stats.nba.com/stats/playerfantasyprofile?LeagueID=&MeasureType=Base&PaceAdjust=N&PerMode=Totals&PlayerID=2544&PlusMinus=N&Rank=N&Season=2019-20&SeasonType=Regular+Season)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**MeasureType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#MeasureType) | measure_type_base | `^(Base)$` | `Y` |  | 
[_**PaceAdjust**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PaceAdjust) | pace_adjust_no | `^(N)$` | `Y` |  | 
[_**PerMode**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PerMode) | per_mode36 | `^(Totals)\|(PerGame)\|(Per36)$` | `Y` |  | 
[_**PlayerID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerID) | player_id |  | `Y` |  | 
[_**PlusMinus**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlusMinus) | plus_minus_no | `^(N)$` | `Y` |  | 
[_**Rank**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Rank) | rank_no | `^(N)$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_playoffs | `^(Regular Season)\|(Pre Season)\|(Playoffs)$` | `Y` |  | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id_nullable |  |  | `Y` | 

## Data Sets
#### DaysRestModified `days_rest_modified`
```text
['GROUP_SET', 'GROUP_VALUE', 'SEASON_YEAR', 'GP', 'W', 'L', 'W_PCT', 'MIN', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'TOV', 'STL', 'BLK', 'BLKA', 'PF', 'PFD', 'PTS', 'PLUS_MINUS', 'DD2', 'TD3', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS']
```

#### LastNGames `last_n_games`
```text
['GROUP_SET', 'GROUP_VALUE', 'GP', 'W', 'L', 'W_PCT', 'MIN', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'TOV', 'STL', 'BLK', 'BLKA', 'PF', 'PFD', 'PTS', 'PLUS_MINUS', 'DD2', 'TD3', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS']
```

#### Location `location`
```text
['GROUP_SET', 'GROUP_VALUE', 'GP', 'W', 'L', 'W_PCT', 'MIN', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'TOV', 'STL', 'BLK', 'BLKA', 'PF', 'PFD', 'PTS', 'PLUS_MINUS', 'DD2', 'TD3', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS']
```

#### Opponent `opponent`
```text
['GROUP_SET', 'GROUP_VALUE', 'GP', 'W', 'L', 'W_PCT', 'MIN', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'TOV', 'STL', 'BLK', 'BLKA', 'PF', 'PFD', 'PTS', 'PLUS_MINUS', 'DD2', 'TD3', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS']
```

#### Overall `overall`
```text
['GROUP_SET', 'GROUP_VALUE', 'GP', 'W', 'L', 'W_PCT', 'MIN', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'TOV', 'STL', 'BLK', 'BLKA', 'PF', 'PFD', 'PTS', 'PLUS_MINUS', 'DD2', 'TD3', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS']
```


## JSON
```json
{
    "data_sets": {
        "DaysRestModified": [
            "GROUP_SET",
            "GROUP_VALUE",
            "SEASON_YEAR",
            "GP",
            "W",
            "L",
            "W_PCT",
            "MIN",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT",
            "FTM",
            "FTA",
            "FT_PCT",
            "OREB",
            "DREB",
            "REB",
            "AST",
            "TOV",
            "STL",
            "BLK",
            "BLKA",
            "PF",
            "PFD",
            "PTS",
            "PLUS_MINUS",
            "DD2",
            "TD3",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS"
        ],
        "LastNGames": [
            "GROUP_SET",
            "GROUP_VALUE",
            "GP",
            "W",
            "L",
            "W_PCT",
            "MIN",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT",
            "FTM",
            "FTA",
            "FT_PCT",
            "OREB",
            "DREB",
            "REB",
            "AST",
            "TOV",
            "STL",
            "BLK",
            "BLKA",
            "PF",
            "PFD",
            "PTS",
            "PLUS_MINUS",
            "DD2",
            "TD3",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS"
        ],
        "Location": [
            "GROUP_SET",
            "GROUP_VALUE",
            "GP",
            "W",
            "L",
            "W_PCT",
            "MIN",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT",
            "FTM",
            "FTA",
            "FT_PCT",
            "OREB",
            "DREB",
            "REB",
            "AST",
            "TOV",
            "STL",
            "BLK",
            "BLKA",
            "PF",
            "PFD",
            "PTS",
            "PLUS_MINUS",
            "DD2",
            "TD3",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS"
        ],
        "Opponent": [
            "GROUP_SET",
            "GROUP_VALUE",
            "GP",
            "W",
            "L",
            "W_PCT",
            "MIN",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT",
            "FTM",
            "FTA",
            "FT_PCT",
            "OREB",
            "DREB",
            "REB",
            "AST",
            "TOV",
            "STL",
            "BLK",
            "BLKA",
            "PF",
            "PFD",
            "PTS",
            "PLUS_MINUS",
            "DD2",
            "TD3",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS"
        ],
        "Overall": [
            "GROUP_SET",
            "GROUP_VALUE",
            "GP",
            "W",
            "L",
            "W_PCT",
            "MIN",
            "FGM",
            "FGA",
            "FG_PCT",
            "FG3M",
            "FG3A",
            "FG3_PCT",
            "FTM",
            "FTA",
            "FT_PCT",
            "OREB",
            "DREB",
            "REB",
            "AST",
            "TOV",
            "STL",
            "BLK",
            "BLKA",
            "PF",
            "PFD",
            "PTS",
            "PLUS_MINUS",
            "DD2",
            "TD3",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS"
        ]
    },
    "endpoint": "PlayerFantasyProfile",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "LeagueID"
    ],
    "parameter_patterns": {
        "LeagueID": null,
        "MeasureType": "^(Base)$",
        "PaceAdjust": "^(N)$",
        "PerMode": "^(Totals)|(PerGame)|(Per36)$",
        "PlayerID": null,
        "PlusMinus": "^(N)$",
        "Rank": "^(N)$",
        "Season": null,
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)$"
    },
    "parameters": [
        "LeagueID",
        "MeasureType",
        "PaceAdjust",
        "PerMode",
        "PlayerID",
        "PlusMinus",
        "Rank",
        "Season",
        "SeasonType"
    ],
    "required_parameters": [
        "MeasureType",
        "PaceAdjust",
        "PerMode",
        "PlayerID",
        "PlusMinus",
        "Rank",
        "Season",
        "SeasonType"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
