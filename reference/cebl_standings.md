# **Get CEBL Standings**

Standings of one season, one row per team: record, home/away splits,
games behind, streak.

Endpoint: `GET https://api.data.cebl.ca/teams/{season}/`

## Usage

``` r
cebl_standings(season)
```

## Arguments

- season:

  (required) Season: the calendar year it is played in (May to August) =
  the sdv END year (2025 = the 2025 season). The CEBL's first season
  is 2019. A season with no data answers `hoopR_no_data`.

## Value

A `hoopR_data` tibble: Standings of one season, one row per team:
record, home/away splits, games behind, streak. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `cebl_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
| team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
| name_en | character | Team full name in English ('Niagara River Lions'). |
| short_name_en | character | Team short name in English, usually the city ('Niagara'). |
| name_fr | character | Team full name in French ('River Lions de Niagara'). |
| short_name_fr | character | Team short name in French, usually the city. |
| conference | character | Conference: EAST or WEST. |
| position | integer | Rank in the team's conference standings (1 = first), not a playing position. |
| played | integer | Regular-season games played (24 a team in 2025). |
| wins | integer | Regular-season games won. |
| win_percentage | double | Win fraction, 0-1 (0.583), not a percentage; the API sends a decimal string. |
| home_wins | integer | Regular-season home games won. |
| away_wins | integer | Regular-season away games won. |
| losses | integer | Regular-season games lost. |
| home_losses | integer | Regular-season home games lost. |
| away_losses | integer | Regular-season away games lost. |
| games_behind | double | Games behind the conference leader; the API sends a decimal string ('0.0'). |
| points_difference | integer | Points scored minus points allowed over the season. An integer. |
| last_five | character | Record in the last 5 games, 'W-L' ('4-1'). |
| streak | character | Current streak: W or L and its length ('W4', 'L1'). |
| logo_url | character | Team logo URL (icon with the team name) on Google Cloud Storage. |
| icon_url | character | Team icon URL (without the team name) on Google Cloud Storage. |
| tickets_url_en | character | Ticket-sales page for the team's home games (English). |
| tickets_url_fr | character | Ticket-sales page for the team's home games (French). |
| website_url_en | character | The team's own website (English). |
| website_url_fr | character | The team's own website (French). |
| shop_url_en | character | The team's merchandise shop (English). |
| shop_url_fr | character | The team's merchandise shop (French). |
| stats_url_en | character | The team's stats page on cebl.ca (`https://cebl.ca/stats/{slug}`). |
| stats_url_fr | character | The team's stats page on the French cebl.ca (`https://cebl.ca/fr-ca/stats/{slug}`). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_news()`](https://hoopR.sportsdataverse.org/reference/cebl_news.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)

## Examples

``` r
# \donttest{
  try(cebl_standings(season = 2025))
#> ── CEBL Standings from the CEBL Stats API ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:42:56 UTC
#> # A tibble: 10 × 30
#>    season team_id name_en         short_name_en name_fr short_name_fr conference
#>     <int>   <int> <chr>           <chr>         <chr>   <chr>         <chr>     
#>  1   2025      14 Niagara River … Niagara       River … Niagara       EAST      
#>  2   2025      16 Vancouver Band… Vancouver     Les Ba… Vancouver     WEST      
#>  3   2025      17 Calgary Surge   Calgary       Surge … Calgary       WEST      
#>  4   2025      20 Ottawa BlackJa… Ottawa        BlackJ… Ottawa        EAST      
#>  5   2025      18 Edmonton Sting… Edmonton      Stinge… Edmonton      WEST      
#>  6   2025      22 Scarborough Sh… Scarborough   Shooti… Scarborough   EAST      
#>  7   2025      21 Montreal Allia… Montreal      Allian… Montréal      EAST      
#>  8   2025      24 Winnipeg Sea B… Winnipeg      Sea Be… Winnipeg      WEST      
#>  9   2025      19 Brampton Honey… Brampton      Honey … Brampton      EAST      
#> 10   2025      15 Saskatchewan R… Saskatchewan  Rattle… Saskatchewan  WEST      
#> # ℹ 23 more variables: position <int>, played <int>, wins <int>,
#> #   win_percentage <dbl>, home_wins <int>, away_wins <int>, losses <int>,
#> #   home_losses <int>, away_losses <int>, games_behind <dbl>,
#> #   points_difference <int>, last_five <chr>, streak <chr>, logo_url <chr>,
#> #   icon_url <chr>, tickets_url_en <chr>, tickets_url_fr <chr>,
#> #   website_url_en <chr>, website_url_fr <chr>, shop_url_en <chr>,
#> #   shop_url_fr <chr>, stats_url_en <chr>, stats_url_fr <chr>
# }
```
