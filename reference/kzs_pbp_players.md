# **Get KZS Play-by-Play Players**

The players the play-by-play feed lists for each side of a final game.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`

## Usage

``` r
kzs_pbp_players(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: The players the play-by-play feed lists for each
side of a final game. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`kzs_pbp_players`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
| team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
| player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. Players listed here are the first (home) team. |
| first_name | character | The home player's (as in the feed) given name. |
| last_name | character | The home player's (as in the feed) family name. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_pbp_players(match_id = 101839)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
