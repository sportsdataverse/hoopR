# nba_leaguehustlestatsteam

##### Endpoint URL
>[https://stats.nba.com/stats/leaguehustlestatsteam](https://stats.nba.com/stats/leaguehustlestatsteam)

##### Valid URL
>[https://stats.nba.com/stats/leaguehustlestatsteam?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&Height=&LeagueID=&Location=&Month=&OpponentTeamID=&Outcome=&PORound=&PerMode=Totals&PlayerExperience=&PlayerPosition=&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=&VsConference=&VsDivision=&Weight=](https://stats.nba.com/stats/leaguehustlestatsteam?College=&Conference=&Country=&DateFrom=&DateTo=&Division=&DraftPick=&DraftYear=&Height=&LeagueID=&Location=&Month=&OpponentTeamID=&Outcome=&PORound=&PerMode=Totals&PlayerExperience=&PlayerPosition=&Season=2019-20&SeasonSegment=&SeasonType=Regular+Season&TeamID=&VsConference=&VsDivision=&Weight=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**PerMode**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PerMode) | per_mode_time | `^(Totals)\|(PerGame)\|(Per48)\|(Per40)\|(Per36)\|(PerMinute)$` | `Y` |  | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season |  | `Y` |  | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_all_star | `^(Regular Season)\|(Pre Season)\|(Playoffs)\|(All Star)$` | `Y` |  | 
[_**Weight**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Weight) | weight_nullable |  |  | `Y` | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable |  |  | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable |  |  | `Y` | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id_nullable |  |  | `Y` | 
[_**SeasonSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonSegment) | season_segment_nullable |  |  | `Y` | 
[_**PlayerPosition**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerPosition) | player_position_nullable |  |  | `Y` | 
[_**PlayerExperience**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerExperience) | player_experience_nullable |  |  | `Y` | 
[_**PORound**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PORound) | po_round_nullable |  |  | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable |  |  | `Y` | 
[_**OpponentTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#OpponentTeamID) | opponent_team_id_nullable |  |  | `Y` | 
[_**Month**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Month) | month_nullable |  |  | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable |  |  | `Y` | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id_nullable |  | `Y` | `Y` | 
[_**Height**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Height) | height_nullable |  |  | `Y` | 
[_**DraftYear**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftYear) | draft_year_nullable |  |  | `Y` | 
[_**DraftPick**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftPick) | draft_pick_nullable |  |  | `Y` | 
[_**Division**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Division) | division_simple_nullable |  |  | `Y` | 
[_**DateTo**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateTo) | date_to_nullable |  |  | `Y` | 
[_**DateFrom**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateFrom) | date_from_nullable |  |  | `Y` | 
[_**Country**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Country) | country_nullable |  |  | `Y` | 
[_**Conference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Conference) | conference_nullable |  |  | `Y` | 
[_**College**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#College) | college_nullable |  |  | `Y` | 

## Data Sets
#### HustleStatsTeam `hustle_stats_team`
```text
['TEAM_ID', 'TEAM_NAME', 'MIN', 'CONTESTED_SHOTS', 'CONTESTED_SHOTS_2PT', 'CONTESTED_SHOTS_3PT', 'DEFLECTIONS', 'CHARGES_DRAWN', 'SCREEN_ASSISTS', 'SCREEN_AST_PTS', 'OFF_LOOSE_BALLS_RECOVERED', 'DEF_LOOSE_BALLS_RECOVERED', 'LOOSE_BALLS_RECOVERED', 'PCT_LOOSE_BALLS_RECOVERED_OFF', 'PCT_LOOSE_BALLS_RECOVERED_DEF', 'OFF_BOXOUTS', 'DEF_BOXOUTS', 'BOX_OUTS', 'PCT_BOX_OUTS_OFF', 'PCT_BOX_OUTS_DEF']
```


## JSON
```json
{
    "data_sets": {
        "HustleStatsTeam": [
            "TEAM_ID",
            "TEAM_NAME",
            "MIN",
            "CONTESTED_SHOTS",
            "CONTESTED_SHOTS_2PT",
            "CONTESTED_SHOTS_3PT",
            "DEFLECTIONS",
            "CHARGES_DRAWN",
            "SCREEN_ASSISTS",
            "SCREEN_AST_PTS",
            "OFF_LOOSE_BALLS_RECOVERED",
            "DEF_LOOSE_BALLS_RECOVERED",
            "LOOSE_BALLS_RECOVERED",
            "PCT_LOOSE_BALLS_RECOVERED_OFF",
            "PCT_LOOSE_BALLS_RECOVERED_DEF",
            "OFF_BOXOUTS",
            "DEF_BOXOUTS",
            "BOX_OUTS",
            "PCT_BOX_OUTS_OFF",
            "PCT_BOX_OUTS_DEF"
        ]
    },
    "endpoint": "LeagueHustleStatsTeam",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "College",
        "Conference",
        "Country",
        "DateFrom",
        "DateTo",
        "Division",
        "DraftPick",
        "DraftYear",
        "Height",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PORound",
        "PlayerExperience",
        "PlayerPosition",
        "SeasonSegment",
        "TeamID",
        "VsConference",
        "VsDivision",
        "Weight"
    ],
    "parameter_patterns": {
        "College": null,
        "Conference": null,
        "Country": null,
        "DateFrom": null,
        "DateTo": null,
        "Division": null,
        "DraftPick": null,
        "DraftYear": null,
        "Height": null,
        "LeagueID": null,
        "Location": null,
        "Month": null,
        "OpponentTeamID": null,
        "Outcome": null,
        "PORound": null,
        "PerMode": "^(Totals)|(PerGame)|(Per48)|(Per40)|(Per36)|(PerMinute)$",
        "PlayerExperience": null,
        "PlayerPosition": null,
        "Season": null,
        "SeasonSegment": null,
        "SeasonType": "^(Regular Season)|(Pre Season)|(Playoffs)|(All Star)$",
        "TeamID": null,
        "VsConference": null,
        "VsDivision": null,
        "Weight": null
    },
    "parameters": [
        "College",
        "Conference",
        "Country",
        "DateFrom",
        "DateTo",
        "Division",
        "DraftPick",
        "DraftYear",
        "Height",
        "LeagueID",
        "Location",
        "Month",
        "OpponentTeamID",
        "Outcome",
        "PORound",
        "PerMode",
        "PlayerExperience",
        "PlayerPosition",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "TeamID",
        "VsConference",
        "VsDivision",
        "Weight"
    ],
    "required_parameters": [
        "LeagueID",
        "PerMode",
        "Season",
        "SeasonType"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
