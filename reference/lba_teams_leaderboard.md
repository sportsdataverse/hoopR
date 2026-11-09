# **Get LBA Teams Leaderboard**

Season team leaderboards, offensive or defensive, one row per team and
category.

Endpoint:
`GET https://www.legabasket.it/api/statistics/get-teams-statistics-by-type`
(`cs_id=1&type=<board>&s=<season>`)

## Usage

``` r
lba_teams_leaderboard(board, season = NULL)
```

## Arguments

- board:

  (required) Board: teams_offensive or teams_defensive. One of
  `"teams_offensive"`, `"teams_defensive"`.

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

## Value

A `hoopR_data` tibble: Season team leaderboards, offensive or defensive,
one row per team and category. The columns are always these, in this
order (sportsdataverse-py `lba_teams_leaderboard`); a column the site
adds later is appended after them:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = 2026-27): the row's START year + 1. |
| category | character | Category of this row (the `cat` param, e.g. `points`). |
| name | character | Given name (players) / team name (teams). |
| sponsor_name | character | Sponsor name (empty or null in the samples). |
| short_name | character | Short name of the team, e.g. BC Roma. |
| tv_name | character | Short team name for TV graphics. |
| year | integer | Season START year (2026 = 2026-27); sdv END year = year + 1. |
| logo_key | character | Image key: the image is `{cdn_url}/{key}`, resized copies `{cdn_url}/variants/{key}/thumb` or `/large` (the site's getApiImageUrl). |
| attempts | integer | Shots attempted in the zone, parsed from num. |
| total_played_matches | integer | Games the team has played, counted for the leaderboard. |
| total_points | integer | Points scored (offensive) or allowed (defensive) in the season. |
| minutes | integer | Minutes per game (players: decimal string `28.67`) / total minutes (teams: integer). |
| score_40_min | double | Value per 40 minutes. |
| score | double | Value in the category under the `ob` order (default `avg` = per game); players send a decimal string, teams a number. |
| team_id | integer | Team id (team-season). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_teams_leaderboard(board = "teams_offensive", season = 2027)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
