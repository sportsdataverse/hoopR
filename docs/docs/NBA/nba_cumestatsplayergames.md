# CumeStatsPlayerGames
##### [nba_api/stats/endpoints/cumestatsplayergames.py](https://github.com/swar/nba_api/blob/master/nba_api/stats/endpoints/cumestatsplayergames.py)

##### Endpoint URL
>[https://stats.nba.com/stats/cumestatsplayergames](https://stats.nba.com/stats/cumestatsplayergames)

##### Valid URL
>[https://stats.nba.com/stats/cumestatsplayergames?LeagueID=00&Location=&Outcome=&PlayerID=2544&Season=2019-20&SeasonType=Regular+Season&VsConference=&VsDivision=&VsTeamID=](https://stats.nba.com/stats/cumestatsplayergames?LeagueID=00&Location=&Outcome=&PlayerID=2544&Season=2019-20&SeasonType=Regular+Season&VsConference=&VsDivision=&VsTeamID=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id |  | `Y` |  | 
[_**PlayerID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerID) | player_id |  | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**VsTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsTeamID) | vs_team_id_nullable |  |  | `Y` | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable |  |  | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable |  |  | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable |  |  | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable |  |  | `Y` | 

## Data Sets
#### CumeStatsPlayerGames `cume_stats_player_games`
```text
['MATCHUP', 'GAME_ID']
```


## JSON
```json
{
    "data_sets": {
        "CumeStatsPlayerGames": [
            "MATCHUP",
            "GAME_ID"
        ]
    },
    "endpoint": "CumeStatsPlayerGames",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "Location",
        "Outcome",
        "VsConference",
        "VsDivision",
        "VsTeamID"
    ],
    "parameter_patterns": {
        "LeagueID": null,
        "Location": null,
        "Outcome": null,
        "PlayerID": null,
        "Season": null,
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "VsConference": null,
        "VsDivision": null,
        "VsTeamID": null
    },
    "parameters": [
        "LeagueID",
        "Location",
        "Outcome",
        "PlayerID",
        "Season",
        "SeasonType",
        "VsConference",
        "VsDivision",
        "VsTeamID"
    ],
    "required_parameters": [
        "LeagueID",
        "PlayerID",
        "Season",
        "SeasonType"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
