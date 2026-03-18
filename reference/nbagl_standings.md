# **Get Current G League Standings from NBA API**

Retrieves G-League standings via the NBA Stats API standings endpoint.

## Usage

``` r
nbagl_standings(
  league_id = "20",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  season_year = "",
  ...
)
```

## Arguments

- league_id:

  League - default: '20' (G-League).

- season:

  Season - format 2020-21.

- season_type:

  Season Type - Regular Season, Playoffs, All-Star.

- season_year:

  Season year filter (optional).

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: Standings

**Standings**

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| LeagueID            | character |
| SeasonID            | character |
| TeamID              | character |
| TeamCity            | character |
| TeamName            | character |
| TeamSlug            | character |
| Conference          | character |
| ConferenceRecord    | character |
| PlayoffRank         | character |
| Division            | character |
| WINS                | character |
| LOSSES              | character |
| WinPCT              | character |
| LeagueRank          | character |
| Record              | character |
| HOME                | character |
| ROAD                | character |
| CurrentStreak       | character |
| strCurrentStreak    | character |
| ConferenceGamesBack | character |
| DivisionGamesBack   | character |
| LeagueGamesBack     | character |
| ClinchedPostSeason  | character |
| NEUTRAL             | character |

## Details

     nbagl_standings(season = most_recent_nba_season() - 1)

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md)

## Author

Billy Fryer
