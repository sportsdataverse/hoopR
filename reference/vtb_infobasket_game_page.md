# **Get VTB Infobasket Game Page**

Thin header of a finished game (use vtb_infobasket_game for teams, box
score and plays).

Endpoint: `GET https://org.infobasket.su/Widget/GamePage/{game_id}`

## Usage

``` r
vtb_infobasket_game_page(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble: Thin header of a finished game (use
vtb_infobasket_game for teams, box score and plays). The columns are
always these, in this order (sportsdataverse-py
`vtb_infobasket_game_page`); an empty valid answer raises
`hoopR_no_data`, a valid body with no rows for this frame is a zero-row
tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| comp_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_short_name_ru | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| league_short_name_en | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| gender | integer | Competition gender: 0 on every VTB sample (men). Other values unverified. |
| comp_id | integer | Always 0 on this thin header; use vtb_infobasket_game for the stage. |
| league_id | integer | Season-level competition id of the game (50714 = VTB 2025-26); 0 in GamePage. |
| game_id | integer | Infobasket game id (GameID); equals the v2 API `matchId`. Joins to /Widget/GetOnline/{gameId} and /Widget/GamePage/{gameId}. The scope check compares it with the request. |
| game_date | character | Game date as an ISO 8601 string in Moscow time (+03:00), midnight. |
| game_time | character | Tip-off as an ISO 8601 string in Moscow time (+03:00). |
| game_date_time | character | Tip-off as an ISO 8601 string in Moscow time (+03:00). |
| game_number | character | Game number within the competition, e.g. 'RS-002' (RS = regular season); playoff games use the series code. |
| game_region | integer | Region (city) id of the game. |
| game_arena | integer | Arena id of the game. Infobasket arena id; equals the v2 API `venueId` (11687 = SK Basket-Hall, Krasnodar). |
| game_rules | integer | Rules code (1 in the samples; unverified). |
| game_forfeit | integer | 1 when the game was forfeited, else 0. |
| game_attendance | integer | Spectators at the game (null when not recorded). |
| game_status | integer | Game status: 0 planned, 1 completed, 2 live (the site's widget code). Samples are completed games. |
| game_stats_status | integer | Stats status of the game; 0 in the samples. |
| game_time_moscow_string | character | Tip-off time in Moscow time, 'HH:MM'. |
| region_name_ru | character | City or region in Russian. |
| region_name_en | character | City or region in English. |
| arena_name_ru | character | Arena name in Russian. |
| arena_name_en | character | Arena name in English. |
| arena_full_name_ru | character | Arena full name in Russian. |
| arena_full_name_en | character | Arena full name in English. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

     vtb_infobasket_game_page(game_id = 921391)

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.
