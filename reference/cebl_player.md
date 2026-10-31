# **Get CEBL Player**

One player's profile and current team: name, nationality, birth date,
position, jersey.

Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/`

## Usage

``` r
cebl_player(player_id)
```

## Arguments

- player_id:

  (required) CEBL player id (global across seasons and teams), e.g.
  570965 (Javonte Smart); `player_id` in cebl_player_stats.

## Value

A `hoopR_data` tibble: One player's profile and current team: name,
nationality, birth date, position, jersey. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `cebl_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | CEBL player id (its own key space). Joins /players/{player_id}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
| full_name | character | Player's full name. |
| nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
| birth_date | Date | Date of birth, YYYY-MM-DD (players' public bio field); null when unknown. |
| age | integer | Age in whole years on the day of the request (computed by the API); null when the birth date is unknown. |
| position | character | Playing position: G (guard), F (forward), C (center), or a combination such as 'C/F'; null when unknown. |
| jersey_number | character | Jersey number, as a string of up to 2 characters ('0', '00' and '1' are distinct); null when unknown. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The player's latest team. |
| team_name_en | character | Full English name of the player's team. |
| team_short_name_en | character | Short English name (city) of the player's team. |
| team_name_fr | character | Full French name of the player's team. |
| team_short_name_fr | character | Short French name (city) of the player's team. |
| team_icon_url | character | Icon URL (without the name) of the player's team. |
| team_stats_url_en | character | cebl.ca stats page of the player's team (English). |
| team_stats_url_fr | character | cebl.ca stats page of the player's team (French). |
| photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_player(player_id = 570965)

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
