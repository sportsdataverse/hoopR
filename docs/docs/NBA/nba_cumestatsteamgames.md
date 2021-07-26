# CumeStatsTeamGames
##### [nba_api/stats/endpoints/cumestatsteamgames.py](https://github.com/swar/nba_api/blob/master/nba_api/stats/endpoints/cumestatsteamgames.py)

##### Endpoint URL
>[https://stats.nba.com/stats/cumestatsteamgames](https://stats.nba.com/stats/cumestatsteamgames)

##### Valid URL
>[https://stats.nba.com/stats/cumestatsteamgames?LeagueID=00&Location=&Outcome=&Season=2019-20&SeasonID=&SeasonType=Regular+Season&TeamID=1610612739&VsConference=&VsDivision=&VsTeamID=](https://stats.nba.com/stats/cumestatsteamgames?LeagueID=00&Location=&Outcome=&Season=2019-20&SeasonID=&SeasonType=Regular+Season&TeamID=1610612739&VsConference=&VsDivision=&VsTeamID=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id |  | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id |  | `Y` |  | 
[_**VsTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsTeamID) | vs_team_id_nullable |  |  | `Y` | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable |  |  | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable |  |  | `Y` | 
[_**SeasonID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonID) | season_id_nullable |  |  | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable |  |  | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable |  |  | `Y` | 

## Data Sets
#### CumeStatsTeamGames `cume_stats_team_games`
```text
['MATCHUP', 'GAME_ID']
```


## JSON
```json
{
    "data_sets": {
        "CumeStatsTeamGames": [
            "MATCHUP",
            "GAME_ID"
        ]
    },
    "endpoint": "CumeStatsTeamGames",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "Location",
        "Outcome",
        "SeasonID",
        "VsConference",
        "VsDivision",
        "VsTeamID"
    ],
    "parameter_patterns": {
        "LeagueID": null,
        "Location": null,
        "Outcome": null,
        "Season": null,
        "SeasonID": null,
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "TeamID": null,
        "VsConference": null,
        "VsDivision": null,
        "VsTeamID": null
    },
    "parameters": [
        "LeagueID",
        "Location",
        "Outcome",
        "Season",
        "SeasonID",
        "SeasonType",
        "TeamID",
        "VsConference",
        "VsDivision",
        "VsTeamID"
    ],
    "required_parameters": [
        "LeagueID",
        "Season",
        "SeasonType",
        "TeamID"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
