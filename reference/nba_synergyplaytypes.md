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

Column schemas omitted from help to keep the package under the CRAN 5 MB
installed-size limit. See the package source at
`tools/docs/nba_playerdashboard_columns.md` for full column tables.

## Details

[Synergy Play Type Stats](https://www.nba.com/stats/teams/isolation)

     nba_synergyplaytypes(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Player Tracking Functions:
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_leaguedashoppptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashoppptshot.md),
[`nba_leaguedashplayerptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashplayerptshot.md),
[`nba_leaguedashptdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptdefend.md),
[`nba_leaguedashptstats()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptstats.md),
[`nba_leaguedashptteamdefend()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashptteamdefend.md),
[`nba_leaguedashteamptshot()`](https://hoopR.sportsdataverse.org/reference/nba_leaguedashteamptshot.md),
[`nba_playerdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptpass.md),
[`nba_playerdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_playerdashptreb.md),
[`nba_teamdashptpass()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptpass.md),
[`nba_teamdashptreb()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptreb.md),
[`nba_teamdashptshots()`](https://hoopR.sportsdataverse.org/reference/nba_teamdashptshots.md),
[`nba_tracking_aggregate()`](https://hoopR.sportsdataverse.org/reference/nba_tracking_aggregate.md)

## Author

Saiem Gilani
