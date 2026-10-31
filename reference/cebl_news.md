# **Get CEBL News**

News articles in one language. The API answered an empty list on every
probe, so this raises `hoopR_no_data`.

Endpoint: `GET https://api.data.cebl.ca/news/articles/{language}/`

## Usage

``` r
cebl_news(language, team_source_id = NULL)
```

## Arguments

- language:

  (required) Language code, e.g. `en`; every language tried answered an
  empty list.

- team_source_id:

  (default `NULL`) CEBL team id: only that team's articles.

## Value

A `hoopR_data` tibble: News articles in one language. The API answered
an empty list on every probe, so this raises `hoopR_no_data`. An empty
valid answer raises `hoopR_no_data`; the columns are always these, in
this order (sportsdataverse-py `cebl_news`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| news_id | integer | CEBL news article id; null when the API gives none. Unobserved: the route answered an empty list on every probe. |
| language | character | Language code of the request ('en'); the body does not echo it. |
| title | character | Article headline (upstream schema; unobserved, the route answered an empty list on every probe). |
| published_at_utc | POSIXct | Publication time in UTC (upstream schema; unobserved, no article was ever served). |
| image_url | character | Article image URL (upstream schema; unobserved, no article was ever served). |
| html_content | character | Article body as HTML (upstream schema; unobserved, no article was ever served). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md).

     cebl_news(language = "en")

## See also

Other CEBL Functions:
[`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md),
[`cebl_player()`](https://hoopR.sportsdataverse.org/reference/cebl_player.md),
[`cebl_player_gamelog()`](https://hoopR.sportsdataverse.org/reference/cebl_player_gamelog.md),
[`cebl_player_leaders()`](https://hoopR.sportsdataverse.org/reference/cebl_player_leaders.md),
[`cebl_player_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_player_seasons.md),
[`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md),
[`cebl_roster()`](https://hoopR.sportsdataverse.org/reference/cebl_roster.md),
[`cebl_seasons()`](https://hoopR.sportsdataverse.org/reference/cebl_seasons.md),
[`cebl_standings()`](https://hoopR.sportsdataverse.org/reference/cebl_standings.md),
[`cebl_team_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_team_stats.md),
[`cebl_teams()`](https://hoopR.sportsdataverse.org/reference/cebl_teams.md)
