# **Get G League Player Data Base from NBA API**

Retrieves G-League player index data via the NBA Stats API player index
endpoint.

## Usage

``` r
nbagl_players(
  college = "",
  country = "",
  draft_pick = "",
  draft_round = "",
  draft_year = "",
  height = "",
  historical = 1,
  league_id = "20",
  player_position = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  team_id = "0",
  weight = "",
  active = "",
  all_star = "",
  ...
)
```

## Arguments

- college:

  College filter.

- country:

  Country filter.

- draft_pick:

  Draft pick filter.

- draft_round:

  Draft round filter.

- draft_year:

  Draft year filter.

- height:

  Height filter.

- historical:

  Historical flag.

- league_id:

  League - default: '20' (G-League).

- player_position:

  Player position filter.

- season:

  Season - format 2020-21.

- season_type:

  Season Type - Regular Season, Playoffs, All-Star.

- team_id:

  Team ID filter.

- weight:

  Weight filter.

- active:

  Active status filter.

- all_star:

  All-Star filter.

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayerIndex

**PlayerIndex**

|  |  |  |
|----|----|----|
| col_name | types | description |
| PERSON_ID | character | Unique player identifier (V3 endpoints). |
| PLAYER_LAST_NAME | character |  |
| PLAYER_FIRST_NAME | character |  |
| PLAYER_SLUG | character | URL-safe player identifier. |
| TEAM_ID | character | Unique team identifier. |
| TEAM_SLUG | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| TEAM_CITY | character | Team city or region (e.g. 'Las Vegas'). |
| TEAM_NAME | character | Full team display name (e.g. 'Las Vegas Aces'). |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS'). |
| JERSEY_NUMBER | character |  |
| POSITION | character | Listed roster position (G, F, C, etc.). |
| HEIGHT | character | Player height (string e.g. '6-2' or inches). |
| WEIGHT | character | Player weight in pounds. |
| COLLEGE | character | College or school attended. |
| COUNTRY | character | Country (full name or code). |
| DRAFT_YEAR | character | Draft year (4-digit). |
| DRAFT_ROUND | character | Round of the draft selection. |
| DRAFT_NUMBER | character |  |
| ROSTER_STATUS | character |  |

## Details

     nbagl_players()

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
