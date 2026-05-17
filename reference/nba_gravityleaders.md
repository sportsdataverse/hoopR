# **Get NBA Stats API Gravity Leaders**

**Get NBA Stats API Gravity Leaders**

**Get NBA Stats API Gravity Leaders**

## Usage

``` r
nba_gravityleaders(
  league_id = "00",
  season = year_to_season(most_recent_nba_season() - 1),
  season_type = "Regular Season",
  ...
)
```

## Arguments

- league_id:

  League - default: '00'. Other options include '10': WNBA, '20':
  G-League

- season:

  Season - format: '2023-24'

- season_type:

  Season Type - 'Regular Season', 'Playoffs'

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: GravityLeaders

**GravityLeaders**

|  |  |  |
|----|----|----|
| col_name | types | description |
| playerid | character | Playerid. |
| firstname | character | Firstname. |
| lastname | character | Lastname. |
| teamid | character | Teamid. |
| teamabbreviation | character | Teamabbreviation. |
| teamname | character | Teamname. |
| teamcity | character | Teamcity. |
| frames | character | Frames. |
| gravityscore | character | Gravityscore. |
| avggravityscore | character | Avggravityscore. |
| onballperimeterframes | character | Onballperimeterframes. |
| onballperimetergravityscore | character | Onballperimetergravityscore. |
| avgonballperimetergravityscore | character | Avgonballperimetergravityscore. |
| offballperimeterframes | character | Offballperimeterframes. |
| offballperimetergravityscore | character | Offballperimetergravityscore. |
| avgoffballperimetergravityscore | character | Avgoffballperimetergravityscore. |
| onballinteriorframes | character | Onballinteriorframes. |
| onballinteriorgravityscore | character | Onballinteriorgravityscore. |
| avgonballinteriorgravityscore | character | Avgonballinteriorgravityscore. |
| offballinteriorframes | character | Offballinteriorframes. |
| offballinteriorgravityscore | character | Offballinteriorgravityscore. |
| avgoffballinteriorgravityscore | character | Avgoffballinteriorgravityscore. |
| gamesplayed | character | Gamesplayed. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| pts | character | Points scored. |
| reb | character | Total rebounds. |
| ast | character | Assists. |

## Details

     nba_gravityleaders(season = year_to_season(most_recent_nba_season() - 1))

## See also

Other NBA Leaders Functions:
[`nba_alltimeleadersgrids()`](https://hoopR.sportsdataverse.org/reference/nba_alltimeleadersgrids.md),
[`nba_assistleaders()`](https://hoopR.sportsdataverse.org/reference/nba_assistleaders.md),
[`nba_assisttracker()`](https://hoopR.sportsdataverse.org/reference/nba_assisttracker.md),
[`nba_defensehub()`](https://hoopR.sportsdataverse.org/reference/nba_defensehub.md),
[`nba_dunkscoreleaders()`](https://hoopR.sportsdataverse.org/reference/nba_dunkscoreleaders.md),
[`nba_homepageleaders()`](https://hoopR.sportsdataverse.org/reference/nba_homepageleaders.md),
[`nba_homepagev2()`](https://hoopR.sportsdataverse.org/reference/nba_homepagev2.md),
[`nba_leaderstiles()`](https://hoopR.sportsdataverse.org/reference/nba_leaderstiles.md),
[`nba_leagueleaders()`](https://hoopR.sportsdataverse.org/reference/nba_leagueleaders.md)

## Author

Saiem Gilani
