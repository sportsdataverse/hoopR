# nba_playerfantasyprofilebargraph

##### Endpoint URL
>[https://stats.nba.com/stats/playerfantasyprofilebargraph](https://stats.nba.com/stats/playerfantasyprofilebargraph)

##### Valid URL
>[https://stats.nba.com/stats/playerfantasyprofilebargraph?LeagueID=&PlayerID=2544&Season=2019-20&SeasonType=](https://stats.nba.com/stats/playerfantasyprofilebargraph?LeagueID=&PlayerID=2544&Season=2019-20&SeasonType=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**PlayerID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerID) | player_id |  | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star_nullable | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` |  | `Y` | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id_nullable |  |  | `Y` | 

## Data Sets
#### LastFiveGamesAvg `last_five_games_avg`
```text
['PLAYER_ID', 'PLAYER_NAME', 'TEAM_ID', 'TEAM_ABBREVIATION', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS', 'PTS', 'REB', 'AST', 'FG3M', 'FT_PCT', 'STL', 'BLK', 'TOV', 'FG_PCT']
```

#### SeasonAvg `season_avg`
```text
['PLAYER_ID', 'PLAYER_NAME', 'TEAM_ID', 'TEAM_ABBREVIATION', 'FAN_DUEL_PTS', 'NBA_FANTASY_PTS', 'PTS', 'REB', 'AST', 'FG3M', 'FT_PCT', 'STL', 'BLK', 'TOV', 'FG_PCT']
```


## JSON
```json
{
    "data_sets": {
        "LastFiveGamesAvg": [
            "PLAYER_ID",
            "PLAYER_NAME",
            "TEAM_ID",
            "TEAM_ABBREVIATION",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS",
            "PTS",
            "REB",
            "AST",
            "FG3M",
            "FT_PCT",
            "STL",
            "BLK",
            "TOV",
            "FG_PCT"
        ],
        "SeasonAvg": [
            "PLAYER_ID",
            "PLAYER_NAME",
            "TEAM_ID",
            "TEAM_ABBREVIATION",
            "FAN_DUEL_PTS",
            "NBA_FANTASY_PTS",
            "PTS",
            "REB",
            "AST",
            "FG3M",
            "FT_PCT",
            "STL",
            "BLK",
            "TOV",
            "FG_PCT"
        ]
    },
    "endpoint": "PlayerFantasyProfileBarGraph",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "LeagueID",
        "SeasonType"
    ],
    "parameter_patterns": {
        "LeagueID": null,
        "PlayerID": null,
        "Season": null,
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$"
    },
    "parameters": [
        "LeagueID",
        "PlayerID",
        "Season",
        "SeasonType"
    ],
    "required_parameters": [
        "PlayerID",
        "Season"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
