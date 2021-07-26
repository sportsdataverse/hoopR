# nba_leaguegamefinder

##### Endpoint URL
>[https://stats.nba.com/stats/leaguegamefinder](https://stats.nba.com/stats/leaguegamefinder)

##### Valid URL
>[https://stats.nba.com/stats/leaguegamefinder?Conference=&DateFrom=&DateTo=&Division=&DraftNumber=&DraftRound=&DraftTeamID=&DraftYear=&EqAST=&EqBLK=&EqDD=&EqDREB=&EqFG3A=&EqFG3M=&EqFG3_PCT=&EqFGA=&EqFGM=&EqFG_PCT=&EqFTA=&EqFTM=&EqFT_PCT=&EqMINUTES=&EqOREB=&EqPF=&EqPTS=&EqREB=&EqSTL=&EqTD=&EqTOV=&GameID=&GtAST=&GtBLK=&GtDD=&GtDREB=&GtFG3A=&GtFG3M=&GtFG3_PCT=&GtFGA=&GtFGM=&GtFG_PCT=&GtFTA=&GtFTM=&GtFT_PCT=&GtMINUTES=&GtOREB=&GtPF=&GtPTS=&GtREB=&GtSTL=&GtTD=&GtTOV=&LeagueID=&Location=&LtAST=&LtBLK=&LtDD=&LtDREB=&LtFG3A=&LtFG3M=&LtFG3_PCT=&LtFGA=&LtFGM=&LtFG_PCT=&LtFTA=&LtFTM=&LtFT_PCT=&LtMINUTES=&LtOREB=&LtPF=&LtPTS=&LtREB=&LtSTL=&LtTD=&LtTOV=&Outcome=&PORound=&PlayerID=&PlayerOrTeam=T&RookieYear=&Season=&SeasonSegment=&SeasonType=&StarterBench=&TeamID=&VsConference=&VsDivision=&VsTeamID=&YearsExperience=](https://stats.nba.com/stats/leaguegamefinder?Conference=&DateFrom=&DateTo=&Division=&DraftNumber=&DraftRound=&DraftTeamID=&DraftYear=&EqAST=&EqBLK=&EqDD=&EqDREB=&EqFG3A=&EqFG3M=&EqFG3_PCT=&EqFGA=&EqFGM=&EqFG_PCT=&EqFTA=&EqFTM=&EqFT_PCT=&EqMINUTES=&EqOREB=&EqPF=&EqPTS=&EqREB=&EqSTL=&EqTD=&EqTOV=&GameID=&GtAST=&GtBLK=&GtDD=&GtDREB=&GtFG3A=&GtFG3M=&GtFG3_PCT=&GtFGA=&GtFGM=&GtFG_PCT=&GtFTA=&GtFTM=&GtFT_PCT=&GtMINUTES=&GtOREB=&GtPF=&GtPTS=&GtREB=&GtSTL=&GtTD=&GtTOV=&LeagueID=&Location=&LtAST=&LtBLK=&LtDD=&LtDREB=&LtFG3A=&LtFG3M=&LtFG3_PCT=&LtFGA=&LtFGM=&LtFG_PCT=&LtFTA=&LtFTM=&LtFT_PCT=&LtMINUTES=&LtOREB=&LtPF=&LtPTS=&LtREB=&LtSTL=&LtTD=&LtTOV=&Outcome=&PORound=&PlayerID=&PlayerOrTeam=T&RookieYear=&Season=&SeasonSegment=&SeasonType=&StarterBench=&TeamID=&VsConference=&VsDivision=&VsTeamID=&YearsExperience=)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
[_**PlayerOrTeam**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerOrTeam) | player_or_team_abbreviation | `^(P)\|(T)$` | `Y` |  | 
[_**YearsExperience**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#YearsExperience) | years_experience_nullable |  |  | `Y` | 
[_**VsTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsTeamID) | vs_team_id_nullable |  |  | `Y` | 
[_**VsDivision**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsDivision) | vs_division_nullable |  |  | `Y` | 
[_**VsConference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#VsConference) | vs_conference_nullable |  |  | `Y` | 
[_**TeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#TeamID) | team_id_nullable |  |  | `Y` | 
[_**StarterBench**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#StarterBench) | starter_bench_nullable |  |  | `Y` | 
[_**SeasonType**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonType) | season_type_nullable |  |  | `Y` | 
[_**SeasonSegment**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#SeasonSegment) | season_segment_nullable |  |  | `Y` | 
[_**Season**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Season) | season_nullable |  |  | `Y` | 
[_**RookieYear**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#RookieYear) | rookie_year_nullable |  |  | `Y` | 
[_**PlayerID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PlayerID) | player_id_nullable |  |  | `Y` | 
[_**PORound**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#PORound) | po_round_nullable |  |  | `Y` | 
[_**Outcome**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Outcome) | outcome_nullable |  |  | `Y` | 
[_**LtTOV**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtTOV) | lt_tov_nullable |  |  | `Y` | 
[_**LtTD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtTD) | lt_td_nullable |  |  | `Y` | 
[_**LtSTL**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtSTL) | lt_stl_nullable |  |  | `Y` | 
[_**LtREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtREB) | lt_reb_nullable |  |  | `Y` | 
[_**LtPTS**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtPTS) | lt_pts_nullable |  |  | `Y` | 
[_**LtPF**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtPF) | lt_pf_nullable |  |  | `Y` | 
[_**LtOREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtOREB) | lt_oreb_nullable |  |  | `Y` | 
[_**LtMINUTES**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtMINUTES) | lt_minutes_nullable |  |  | `Y` | 
[_**LtFT_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFT_PCT) | lt_ft_pct_nullable |  |  | `Y` | 
[_**LtFTM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFTM) | lt_ftm_nullable |  |  | `Y` | 
[_**LtFTA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFTA) | lt_fta_nullable |  |  | `Y` | 
[_**LtFG_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFG_PCT) | lt_fg_pct_nullable |  |  | `Y` | 
[_**LtFGM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFGM) | lt_fgm_nullable |  |  | `Y` | 
[_**LtFGA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFGA) | lt_fga_nullable |  |  | `Y` | 
[_**LtFG3_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFG3_PCT) | lt_fg3_pct_nullable |  |  | `Y` | 
[_**LtFG3M**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFG3M) | lt_fg3m_nullable |  |  | `Y` | 
[_**LtFG3A**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtFG3A) | lt_fg3a_nullable |  |  | `Y` | 
[_**LtDREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtDREB) | lt_dreb_nullable |  |  | `Y` | 
[_**LtDD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtDD) | lt_dd_nullable |  |  | `Y` | 
[_**LtBLK**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtBLK) | lt_blk_nullable |  |  | `Y` | 
[_**LtAST**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LtAST) | lt_ast_nullable |  |  | `Y` | 
[_**Location**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Location) | location_nullable |  |  | `Y` | 
[_**LeagueID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#LeagueID) | league_id_nullable |  |  | `Y` | 
[_**GtTOV**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtTOV) | gt_tov_nullable |  |  | `Y` | 
[_**GtTD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtTD) | gt_td_nullable |  |  | `Y` | 
[_**GtSTL**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtSTL) | gt_stl_nullable |  |  | `Y` | 
[_**GtREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtREB) | gt_reb_nullable |  |  | `Y` | 
[_**GtPTS**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtPTS) | gt_pts_nullable |  |  | `Y` | 
[_**GtPF**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtPF) | gt_pf_nullable |  |  | `Y` | 
[_**GtOREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtOREB) | gt_oreb_nullable |  |  | `Y` | 
[_**GtMINUTES**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtMINUTES) | gt_minutes_nullable |  |  | `Y` | 
[_**GtFT_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFT_PCT) | gt_ft_pct_nullable |  |  | `Y` | 
[_**GtFTM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFTM) | gt_ftm_nullable |  |  | `Y` | 
[_**GtFTA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFTA) | gt_fta_nullable |  |  | `Y` | 
[_**GtFG_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFG_PCT) | gt_fg_pct_nullable |  |  | `Y` | 
[_**GtFGM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFGM) | gt_fgm_nullable |  |  | `Y` | 
[_**GtFGA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFGA) | gt_fga_nullable |  |  | `Y` | 
[_**GtFG3_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFG3_PCT) | gt_fg3_pct_nullable |  |  | `Y` | 
[_**GtFG3M**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFG3M) | gt_fg3m_nullable |  |  | `Y` | 
[_**GtFG3A**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtFG3A) | gt_fg3a_nullable |  |  | `Y` | 
[_**GtDREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtDREB) | gt_dreb_nullable |  |  | `Y` | 
[_**GtDD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtDD) | gt_dd_nullable |  |  | `Y` | 
[_**GtBLK**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtBLK) | gt_blk_nullable |  |  | `Y` | 
[_**GtAST**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GtAST) | gt_ast_nullable |  |  | `Y` | 
[_**GameID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#GameID) | game_id_nullable |  |  | `Y` | 
[_**EqTOV**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqTOV) | eq_tov_nullable |  |  | `Y` | 
[_**EqTD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqTD) | eq_td_nullable |  |  | `Y` | 
[_**EqSTL**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqSTL) | eq_stl_nullable |  |  | `Y` | 
[_**EqREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqREB) | eq_reb_nullable |  |  | `Y` | 
[_**EqPTS**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqPTS) | eq_pts_nullable |  |  | `Y` | 
[_**EqPF**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqPF) | eq_pf_nullable |  |  | `Y` | 
[_**EqOREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqOREB) | eq_oreb_nullable |  |  | `Y` | 
[_**EqMINUTES**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqMINUTES) | eq_minutes_nullable |  |  | `Y` | 
[_**EqFT_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFT_PCT) | eq_ft_pct_nullable |  |  | `Y` | 
[_**EqFTM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFTM) | eq_ftm_nullable |  |  | `Y` | 
[_**EqFTA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFTA) | eq_fta_nullable |  |  | `Y` | 
[_**EqFG_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFG_PCT) | eq_fg_pct_nullable |  |  | `Y` | 
[_**EqFGM**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFGM) | eq_fgm_nullable |  |  | `Y` | 
[_**EqFGA**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFGA) | eq_fga_nullable |  |  | `Y` | 
[_**EqFG3_PCT**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFG3_PCT) | eq_fg3_pct_nullable |  |  | `Y` | 
[_**EqFG3M**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFG3M) | eq_fg3m_nullable |  |  | `Y` | 
[_**EqFG3A**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqFG3A) | eq_fg3a_nullable |  |  | `Y` | 
[_**EqDREB**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqDREB) | eq_dreb_nullable |  |  | `Y` | 
[_**EqDD**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqDD) | eq_dd_nullable |  |  | `Y` | 
[_**EqBLK**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqBLK) | eq_blk_nullable |  |  | `Y` | 
[_**EqAST**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#EqAST) | eq_ast_nullable |  |  | `Y` | 
[_**DraftYear**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftYear) | draft_year_nullable |  |  | `Y` | 
[_**DraftTeamID**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftTeamID) | draft_team_id_nullable |  |  | `Y` | 
[_**DraftRound**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftRound) | draft_round_nullable |  |  | `Y` | 
[_**DraftNumber**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DraftNumber) | draft_number_nullable |  |  | `Y` | 
[_**Division**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Division) | division_simple_nullable |  |  | `Y` | 
[_**DateTo**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateTo) | date_to_nullable |  |  | `Y` | 
[_**DateFrom**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#DateFrom) | date_from_nullable |  |  | `Y` | 
[_**Conference**_](https://hoopR.sportsdataverse.org/docs/NBA/parameters#Conference) | conference_nullable |  |  | `Y` | 

## Data Sets
#### LeagueGameFinderResults `league_game_finder_results`
```text
['SEASON_ID', 'TEAM_ID', 'TEAM_ABBREVIATION', 'TEAM_NAME', 'GAME_ID', 'GAME_DATE', 'MATCHUP', 'WL', 'MIN', 'PTS', 'FGM', 'FGA', 'FG_PCT', 'FG3M', 'FG3A', 'FG3_PCT', 'FTM', 'FTA', 'FT_PCT', 'OREB', 'DREB', 'REB', 'AST', 'STL', 'BLK', 'TOV', 'PF', 'PLUS_MINUS']
```


## JSON
```json
{
    "data_sets": {
        "LeagueGameFinderResults": [
            "SEASON_ID",
            "TEAM_ID",
            "TEAM_ABBREVIATION",
            "TEAM_NAME",
            "GAME_ID",
            "GAME_DATE",
            "MATCHUP",
            "WL",
            "MIN",
            "PTS",
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
            "STL",
            "BLK",
            "TOV",
            "PF",
            "PLUS_MINUS"
        ]
    },
    "endpoint": "LeagueGameFinder",
    "last_validated_date": "2020-08-15",
    "nullable_parameters": [
        "Conference",
        "DateFrom",
        "DateTo",
        "Division",
        "DraftNumber",
        "DraftRound",
        "DraftTeamID",
        "DraftYear",
        "EqAST",
        "EqBLK",
        "EqDD",
        "EqDREB",
        "EqFG3A",
        "EqFG3M",
        "EqFG3_PCT",
        "EqFGA",
        "EqFGM",
        "EqFG_PCT",
        "EqFTA",
        "EqFTM",
        "EqFT_PCT",
        "EqMINUTES",
        "EqOREB",
        "EqPF",
        "EqPTS",
        "EqREB",
        "EqSTL",
        "EqTD",
        "EqTOV",
        "GameID",
        "GtAST",
        "GtBLK",
        "GtDD",
        "GtDREB",
        "GtFG3A",
        "GtFG3M",
        "GtFG3_PCT",
        "GtFGA",
        "GtFGM",
        "GtFG_PCT",
        "GtFTA",
        "GtFTM",
        "GtFT_PCT",
        "GtMINUTES",
        "GtOREB",
        "GtPF",
        "GtPTS",
        "GtREB",
        "GtSTL",
        "GtTD",
        "GtTOV",
        "LeagueID",
        "Location",
        "LtAST",
        "LtBLK",
        "LtDD",
        "LtDREB",
        "LtFG3A",
        "LtFG3M",
        "LtFG3_PCT",
        "LtFGA",
        "LtFGM",
        "LtFG_PCT",
        "LtFTA",
        "LtFTM",
        "LtFT_PCT",
        "LtMINUTES",
        "LtOREB",
        "LtPF",
        "LtPTS",
        "LtREB",
        "LtSTL",
        "LtTD",
        "LtTOV",
        "Outcome",
        "PORound",
        "PlayerID",
        "RookieYear",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "StarterBench",
        "TeamID",
        "VsConference",
        "VsDivision",
        "VsTeamID",
        "YearsExperience"
    ],
    "parameter_patterns": {
        "Conference": null,
        "DateFrom": null,
        "DateTo": null,
        "Division": null,
        "DraftNumber": null,
        "DraftRound": null,
        "DraftTeamID": null,
        "DraftYear": null,
        "EqAST": null,
        "EqBLK": null,
        "EqDD": null,
        "EqDREB": null,
        "EqFG3A": null,
        "EqFG3M": null,
        "EqFG3_PCT": null,
        "EqFGA": null,
        "EqFGM": null,
        "EqFG_PCT": null,
        "EqFTA": null,
        "EqFTM": null,
        "EqFT_PCT": null,
        "EqMINUTES": null,
        "EqOREB": null,
        "EqPF": null,
        "EqPTS": null,
        "EqREB": null,
        "EqSTL": null,
        "EqTD": null,
        "EqTOV": null,
        "GameID": null,
        "GtAST": null,
        "GtBLK": null,
        "GtDD": null,
        "GtDREB": null,
        "GtFG3A": null,
        "GtFG3M": null,
        "GtFG3_PCT": null,
        "GtFGA": null,
        "GtFGM": null,
        "GtFG_PCT": null,
        "GtFTA": null,
        "GtFTM": null,
        "GtFT_PCT": null,
        "GtMINUTES": null,
        "GtOREB": null,
        "GtPF": null,
        "GtPTS": null,
        "GtREB": null,
        "GtSTL": null,
        "GtTD": null,
        "GtTOV": null,
        "LeagueID": null,
        "Location": null,
        "LtAST": null,
        "LtBLK": null,
        "LtDD": null,
        "LtDREB": null,
        "LtFG3A": null,
        "LtFG3M": null,
        "LtFG3_PCT": null,
        "LtFGA": null,
        "LtFGM": null,
        "LtFG_PCT": null,
        "LtFTA": null,
        "LtFTM": null,
        "LtFT_PCT": null,
        "LtMINUTES": null,
        "LtOREB": null,
        "LtPF": null,
        "LtPTS": null,
        "LtREB": null,
        "LtSTL": null,
        "LtTD": null,
        "LtTOV": null,
        "Outcome": null,
        "PORound": null,
        "PlayerID": null,
        "PlayerOrTeam": "^(P)|(T)$",
        "RookieYear": null,
        "Season": null,
        "SeasonSegment": null,
        "SeasonType": null,
        "StarterBench": null,
        "TeamID": null,
        "VsConference": null,
        "VsDivision": null,
        "VsTeamID": null,
        "YearsExperience": null
    },
    "parameters": [
        "Conference",
        "DateFrom",
        "DateTo",
        "Division",
        "DraftNumber",
        "DraftRound",
        "DraftTeamID",
        "DraftYear",
        "EqAST",
        "EqBLK",
        "EqDD",
        "EqDREB",
        "EqFG3A",
        "EqFG3M",
        "EqFG3_PCT",
        "EqFGA",
        "EqFGM",
        "EqFG_PCT",
        "EqFTA",
        "EqFTM",
        "EqFT_PCT",
        "EqMINUTES",
        "EqOREB",
        "EqPF",
        "EqPTS",
        "EqREB",
        "EqSTL",
        "EqTD",
        "EqTOV",
        "GameID",
        "GtAST",
        "GtBLK",
        "GtDD",
        "GtDREB",
        "GtFG3A",
        "GtFG3M",
        "GtFG3_PCT",
        "GtFGA",
        "GtFGM",
        "GtFG_PCT",
        "GtFTA",
        "GtFTM",
        "GtFT_PCT",
        "GtMINUTES",
        "GtOREB",
        "GtPF",
        "GtPTS",
        "GtREB",
        "GtSTL",
        "GtTD",
        "GtTOV",
        "LeagueID",
        "Location",
        "LtAST",
        "LtBLK",
        "LtDD",
        "LtDREB",
        "LtFG3A",
        "LtFG3M",
        "LtFG3_PCT",
        "LtFGA",
        "LtFGM",
        "LtFG_PCT",
        "LtFTA",
        "LtFTM",
        "LtFT_PCT",
        "LtMINUTES",
        "LtOREB",
        "LtPF",
        "LtPTS",
        "LtREB",
        "LtSTL",
        "LtTD",
        "LtTOV",
        "Outcome",
        "PORound",
        "PlayerID",
        "PlayerOrTeam",
        "RookieYear",
        "Season",
        "SeasonSegment",
        "SeasonType",
        "StarterBench",
        "TeamID",
        "VsConference",
        "VsDivision",
        "VsTeamID",
        "YearsExperience"
    ],
    "required_parameters": [
        "PlayerOrTeam"
    ],
    "status": "success"
}
```

Last validated 2020-08-16
