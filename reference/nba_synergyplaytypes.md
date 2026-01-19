# **Get NBA Stats API Synergy Play Type Stats**

**Get NBA Stats API Synergy Play Type Stats**

**Get NBA Stats API Synergy Play Type Stats**

## Usage

``` r
nba_synergyplaytypes(
  league_id = "00",
  per_mode = "PerGame",
  play_type = "Isolation",
  player_or_team = "P",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  type_grouping = "Offensive",
  ...
)
```

## Arguments

- league_id:

  league_id

- per_mode:

  per_mode

- play_type:

  play_type - 'Isolation', 'Transition', 'PRBallHandler', 'PRRollman',
  'Postup', 'Spotup', 'Handoff', 'Cut', 'OffScreen', 'OffRebound',
  'Misc'

- player_or_team:

  player_or_team ('P' or 'T')

- season:

  season

- season_type:

  season_type

- type_grouping:

  type_grouping - Offensive, Defensive

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Return a named list of data frames: SynergyPlayType

**SynergyPlayType**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| SEASON_ID         | character |
| PLAYER_ID         | character |
| PLAYER_NAME       | character |
| TEAM_ID           | character |
| TEAM_ABBREVIATION | character |
| TEAM_NAME         | character |
| PLAY_TYPE         | character |
| TYPE_GROUPING     | character |
| PERCENTILE        | character |
| GP                | character |
| POSS_PCT          | character |
| PPP               | character |
| FG_PCT            | character |
| FT_POSS_PCT       | character |
| TOV_POSS_PCT      | character |
| SF_POSS_PCT       | character |
| PLUSONE_POSS_PCT  | character |
| SCORE_POSS_PCT    | character |
| EFG_PCT           | character |
| POSS              | character |
| PTS               | character |
| FGM               | character |
| FGA               | character |
| FGMX              | character |

## Details

[Synergy Play Type Stats](https://www.nba.com/stats/teams/isolation)

     nba_synergyplaytypes(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Player Tracking Functions:
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_playerdashptshotdefend()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshotdefend.md),
[`nba_playerdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptshots.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md)

## Author

Saiem Gilani
