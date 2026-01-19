# **Get NBA Stats API League Standings V3**

**Get NBA Stats API League Standings V3**

**Get NBA Stats API League Standings V3**

## Usage

``` r
nba_leaguestandingsv3(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  season_year = "",
  ...
)
```

## Arguments

- league_id:

  league_id

- season:

  season

- season_type:

  season_type

- season_year:

  season_year

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: Standings

**Standings**

|                         |           |
|-------------------------|-----------|
| col_name                | types     |
| LeagueID                | character |
| SeasonID                | character |
| TeamID                  | character |
| TeamCity                | character |
| TeamName                | character |
| TeamSlug                | character |
| Conference              | character |
| ConferenceRecord        | character |
| PlayoffRank             | character |
| ClinchIndicator         | character |
| Division                | character |
| DivisionRecord          | character |
| DivisionRank            | character |
| WINS                    | character |
| LOSSES                  | character |
| WinPCT                  | character |
| LeagueRank              | character |
| Record                  | character |
| HOME                    | character |
| ROAD                    | character |
| L10                     | character |
| Last10Home              | character |
| Last10Road              | character |
| OT                      | character |
| ThreePTSOrLess          | character |
| TenPTSOrMore            | character |
| LongHomeStreak          | character |
| strLongHomeStreak       | character |
| LongRoadStreak          | character |
| strLongRoadStreak       | character |
| LongWinStreak           | character |
| LongLossStreak          | character |
| CurrentHomeStreak       | character |
| strCurrentHomeStreak    | character |
| CurrentRoadStreak       | character |
| strCurrentRoadStreak    | character |
| CurrentStreak           | character |
| strCurrentStreak        | character |
| ConferenceGamesBack     | character |
| DivisionGamesBack       | character |
| ClinchedConferenceTitle | character |
| ClinchedDivisionTitle   | character |
| ClinchedPlayoffBirth    | character |
| ClinchedPlayIn          | character |
| EliminatedConference    | character |
| EliminatedDivision      | character |
| AheadAtHalf             | character |
| BehindAtHalf            | character |
| TiedAtHalf              | character |
| AheadAtThird            | character |
| BehindAtThird           | character |
| TiedAtThird             | character |
| Score100PTS             | character |
| OppScore100PTS          | character |
| OppOver500              | character |
| LeadInFGPCT             | character |
| LeadInReb               | character |
| FewerTurnovers          | character |
| PointsPG                | character |
| OppPointsPG             | character |
| DiffPointsPG            | character |
| vsEast                  | character |
| vsAtlantic              | character |
| vsCentral               | character |
| vsSoutheast             | character |
| vsWest                  | character |
| vsNorthwest             | character |
| vsPacific               | character |
| vsSouthwest             | character |
| Jan                     | character |
| Feb                     | character |
| Mar                     | character |
| Apr                     | character |
| May                     | character |
| Jun                     | character |
| Jul                     | character |
| Aug                     | character |
| Sep                     | character |
| Oct                     | character |
| Nov                     | character |
| Dec                     | character |
| Score_80_Plus           | character |
| Opp_Score_80_Plus       | character |
| Score_Below_80          | character |
| Opp_Score_Below_80      | character |
| TotalPoints             | character |
| OppTotalPoints          | character |
| DiffTotalPoints         | character |

## Details

[League Standings](https://www.nba.com/standings)

     nba_leaguestandingsv3(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA League Functions:
[`nba_leaguedashlineups()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashlineups.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerbiostats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerbiostats.md),
[`nba_leaguedashplayerclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerclutch.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashplayershotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayershotlocations.md),
[`nba_leaguedashplayerstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerstats.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamclutch()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamclutch.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_leaguedashteamshotlocations()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamshotlocations.md),
[`nba_leaguedashteamstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamstats.md),
[`nba_leaguegamefinder()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamefinder.md),
[`nba_leaguegamelog()`](https://hoopR.sportsdataverse.org/reference/nba_leaguegamelog.md),
[`nba_leaguelineupviz()`](https://hoopR.sportsdataverse.org/reference/nba_leaguelineupviz.md),
[`nba_leagueplayerondetails()`](https://hoopR.sportsdataverse.org/reference/nba_leagueplayerondetails.md),
[`nba_leagueseasonmatchups()`](https://hoopR.sportsdataverse.org/reference/nba_leagueseasonmatchups.md),
[`nba_leaguestandings()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandings.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_playoffpicture()`](https://hoopR.sportsdataverse.org/reference/nba_playoffpicture.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md)

## Author

Saiem Gilani
