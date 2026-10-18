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
this order (sdv-py `cebl_news`):

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

- CEBL own API, owner-approved gray area: these wrappers read the
  league's own FastAPI service (api.data.cebl.ca, the backend of the
  CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle
  ships to every browser. The key is not issued to third parties and no
  developer terms were found; cebl.ca's terms of use were not reviewed.
  The runtime reads the key from the bundle at run time, falls back to a
  documented constant, never prints it, and raises `hoopR_asset_fetch`
  with a 'key rotated?' hint on a persistent 401. www.cebl.ca/robots.txt
  disallows nothing. Payloads are not redistributed as release assets;
  requests are spaced at least 1 s apart.

- Season is the calendar year (May to August) = the sdv END year: no
  mapping. The first season is 2019. An unknown season, team or player
  answers an empty list, which the runtime raises as `hoopR_no_data`.
  Ids are CEBL's own; a relocated franchise has two team ids (cebl_teams
  lists all 15).

- This API has no box-score, play-by-play or shot route. They live in
  Genius LiveStats (organisation CEBL, see the genius family):
  cebl_games and cebl_player_gamelog carry the Genius match id as
  genius_match_id, parsed from the stats URLs (derived, not fetched; the
  match of a cancelled game may have no data). home_team_id is Genius
  team 1 and away_team_id team 2 (checked on match 2600563).

- Some completed schedule rows have null scores (2026), and a cancelled
  game has status CANELLED (the API's spelling) with null or zero
  scores. The schedule lists unplayed games too, so no wrapper refuses
  an unfinished game. Aggregates are decimal strings upstream and double
  here. Players' names, nationality and birth date are the public bio;
  no contact data is served.

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty
  list, an all-null profile: an unknown season, team or player),
  `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and
  `hoopR_asset_fetch` (a key the API still refuses after one re-read,
  any other non-200, a non-JSON body, an error envelope, a body for
  another season, team or player), all inheriting `hoopR_error`. HTTP
  500 is the API's answer to a bad id and is not retried. Wrappers
  raise; they never return an empty frame.

- Deliberate divergence: a string column that the API sends as an
  object, or a list of objects, carries compact JSON here
  (`{"name":"TSN"}`), where sdv-py's String cast writes Python's
  `str(dict)` repr (`{'name': 'TSN'}`). No string column of the
  committed fixtures carries an object.

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
