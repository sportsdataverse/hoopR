# **Get NBA Stats API In-Season Tournament Standings**

**Get NBA Stats API In-Season Tournament Standings**

**Get NBA Stats API In-Season Tournament Standings**

## Usage

``` r
nba_iststandings(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  section = "group",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format: '2023-24'

- section:

  Section filter - 'group' or 'knockout'

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: Standings

**Standings**

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| league_id             | character |
| season_year           | character |
| team_id               | character |
| team_city             | character |
| team_name             | character |
| team_abbreviation     | character |
| team_slug             | character |
| conference            | character |
| ist_group             | character |
| clinch_indicator      | character |
| clinched_ist_knockout | character |
| clinched_ist_group    | character |
| clinched_ist_wildcard | character |
| ist_wildcard_rank     | character |
| ist_group_rank        | character |
| ist_knockout_rank     | character |
| wins                  | character |
| losses                | character |
| pct                   | character |
| ist_group_gb          | character |
| ist_wildcard_gb       | character |
| diff                  | character |
| pts                   | character |
| opp_pts               | character |

## Details

     nba_iststandings(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

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
[`nba_leaguestandingsv3()`](https://hoopR.sportsdataverse.org/reference/nba_leaguestandingsv3.md),
[`nba_matchupsrollup()`](https://hoopR.sportsdataverse.org/reference/nba_matchupsrollup.md),
[`nba_playoffpicture()`](https://hoopR.sportsdataverse.org/reference/nba_playoffpicture.md),
[`nba_shotchartleaguewide()`](https://hoopR.sportsdataverse.org/reference/nba_shotchartleaguewide.md)

## Author

Saiem Gilani
