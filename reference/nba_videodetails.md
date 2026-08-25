# **Get NBA Stats API Video Details**

**\[deprecated\]**

NBA Stats no longer returns stable data for this endpoint. This function
is deprecated and now errors when called. Use `nba_videodetailsasset()`
instead.

## Usage

``` r
nba_videodetailsasset(
  ahead_behind = "",
  clutch_time = "",
  context_filter = "",
  context_measure = "FGA",
  date_from = "",
  date_to = "",
  end_period = "",
  end_range = "",
  game_id = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  period = 0,
  player_id = "2544",
  point_diff = "",
  position = "",
  range_type = "",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  start_period = "",
  start_range = "",
  team_id = "1610612747",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_videodetails(
  ahead_behind = "",
  clutch_time = "",
  context_filter = "",
  context_measure = "FGA",
  date_from = "",
  date_to = "",
  end_period = "",
  end_range = "",
  game_id = "",
  game_segment = "",
  last_n_games = 0,
  league_id = "00",
  location = "",
  month = 0,
  opponent_team_id = 0,
  outcome = "",
  period = 0,
  player_id = "2544",
  point_diff = "",
  position = "",
  range_type = "",
  rookie_year = "",
  season = year_to_season(most_recent_nba_season() - 1),
  season_segment = "",
  season_type = "Regular Season",
  start_period = "",
  start_range = "",
  team_id = "1610612747",
  vs_conference = "",
  vs_division = "",
  ...
)

nba_videoevents(game_id = "0021700807", game_event_id = "10", ...)

nba_videostatus(game_date = "2023-03-10", league_id = "00", ...)

nba_videoeventsasset(game_id, game_event_id = 0, ...)
```

## Arguments

- ahead_behind:

  ahead_behind

- clutch_time:

  clutch_time

- context_filter:

  context_filter

- context_measure:

  context_measure

- date_from:

  date_from

- date_to:

  date_to

- end_period:

  end_period

- end_range:

  end_range

- game_id:

  game_id

- game_segment:

  game_segment

- last_n_games:

  last_n_games

- league_id:

  league_id

- location:

  location

- month:

  month

- opponent_team_id:

  opponent_team_id

- outcome:

  outcome

- period:

  period

- player_id:

  player_id

- point_diff:

  point_diff

- position:

  position

- range_type:

  range_type

- rookie_year:

  rookie_year

- season:

  season

- season_segment:

  season_segment

- season_type:

  season_type

- start_period:

  start_period

- start_range:

  start_range

- team_id:

  team_id

- vs_conference:

  vs_conference

- vs_division:

  vs_division

- ...:

  Additional arguments passed to an underlying function like httr.

- game_event_id:

  game_event_id

- game_date:

  game_date

## Value

Return a list of tibbles: videoUrls, playlist

**videoUrls**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| uuid     | character | Uuid.       |
| sdur     | integer   | Sdur.       |
| surl     | character | Surl.       |
| sth      | character | Sth.        |
| mdur     | integer   | Mdur.       |
| murl     | character | Murl.       |
| mth      | character | Mth.        |
| ldur     | integer   | Ldur.       |
| lurl     | character | Lurl.       |
| lth      | character | Lth.        |
| vtt      | character | Vtt.        |
| scc      | character | Scc.        |
| srt      | character | Srt.        |

**playlist**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| gi       | character | Gi.         |
| ei       | integer   | Ei.         |
| y        | integer   | Y.          |
| m        | character | M.          |
| d        | character | D.          |
| gc       | character | Gc.         |
| p        | integer   | P.          |
| dsc      | character | Dsc.        |
| ha       | character | Ha.         |
| hid      | integer   | Hid.        |
| va       | character | Va.         |
| vid      | integer   | Vid.        |
| hpb      | integer   | Hpb.        |
| hpa      | integer   | Hpa.        |
| vpb      | integer   | Vpb.        |
| vpa      | integer   | Vpa.        |
| pta      | integer   | Pta.        |

Return a list of tibbles: videoUrls, playlist

**videoUrls**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| uuid     | character | Uuid.       |
| dur      | logical   | Dur.        |
| stt      | logical   | Stt.        |
| stp      | logical   | Stp.        |
| sth      | logical   | Sth.        |
| stw      | logical   | Stw.        |
| mtt      | logical   | Mtt.        |
| mtp      | logical   | Mtp.        |
| mth      | logical   | Mth.        |
| mtw      | logical   | Mtw.        |
| ltt      | logical   | Ltt.        |
| ltp      | logical   | Ltp.        |
| lth      | logical   | Lth.        |
| ltw      | logical   | Ltw.        |

**playlist**

|          |           |             |
|----------|-----------|-------------|
| col_name | types     | description |
| gi       | character | Gi.         |
| ei       | integer   | Ei.         |
| y        | integer   | Y.          |
| m        | character | M.          |
| d        | character | D.          |
| gc       | character | Gc.         |
| p        | integer   | P.          |
| dsc      | character | Dsc.        |
| ha       | character | Ha.         |
| va       | character | Va.         |
| hpb      | integer   | Hpb.        |
| hpa      | integer   | Hpa.        |
| vpb      | integer   | Vpb.        |
| vpa      | integer   | Vpa.        |
| pta      | integer   | Pta.        |

Return a list of tibbles: videoUrls, playlist

Return a list of tibbles: VideoStatus

**VideoStatus**

|  |  |  |
|----|----|----|
| col_name | types | description |
| GAME_ID | character | Unique game identifier. |
| GAME_DATE | character | Game date (YYYY-MM-DD). |
| VISITOR_TEAM_ID | character |  |
| VISITOR_TEAM_CITY | character |  |
| VISITOR_TEAM_NAME | character |  |
| VISITOR_TEAM_ABBREVIATION | character |  |
| HOME_TEAM_ID | character | Unique identifier for the home team. |
| HOME_TEAM_CITY | character | Home team city / location. |
| HOME_TEAM_NAME | character | Home team name. |
| HOME_TEAM_ABBREVIATION | character |  |
| GAME_STATUS | character | Game status label. |
| GAME_STATUS_TEXT | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| IS_AVAILABLE | character |  |
| PT_XYZ_AVAILABLE | character | Pt xyz available. |

Returns a named list containing video event asset data (structure varies
by response)

## Details

     nba_videodetailsasset(player_id = '2544', team_id = '1610612747')

     nba_videodetails(player_id = '2544', team_id = '1610612747')

     nba_videoevents(game_id = '0021700807', game_event_id = '10')

     nba_videostatus(game_date = '2023-03-10', league_id = '00')

(Possibly Defunct)

     nba_videoeventsasset(game_id = '0021700807', game_event_id = 10)

## Author

Saiem Gilani
