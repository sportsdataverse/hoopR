# **Get Basketligaen Standings**

Standings of an ssgt (gameday widget).

Endpoint:
`GET https://www.basketligaen.dk/api/gameday/team-standings/{ssgt_uuid}`

## Usage

``` r
sportality_standings(ssgt_uuid)
```

## Arguments

- ssgt_uuid:

  (required) ssgt uuid: one season + series + game type, e.g. xs07bd3fmp
  = 2026/2027 regular season. Directory: `/statistics-v2/layout-info`
  `seasonSeriesGameTypeTeams[].ssgtUuid`.

## Value

A `hoopR_data` tibble: Standings of an ssgt (gameday widget). An empty
valid answer raises `hoopR_no_data`; the documented columns come first,
in this order (sportsdataverse-py `sportality_standings`), then any
column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Genius team id (Int64): in gameday bodies, an integer in standings and stats tables. |
| team_uuid | character | Platform team uuid. |
| team_code | character | Platform team code (HOL, RAN). |
| team_name | character | Name of the team. |
| rank | integer | Rank in the standings table, 1 = first. |
| gp | integer | Number of games played. |
| w | integer | Number of wins. |
| l | integer | Number of losses. |
| tp | integer | League table points (2 per win). |
| for | integer | Points scored by the team (points for). |
| ga | integer | Points conceded. |
| plus_minus | integer | Point difference. |
| strk | integer | Current streak as a signed integer: positive = wins in a row, negative = losses in a row. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

Other Basketligaen Functions:
[`sportality_athlete_career()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_career.md),
[`sportality_athlete_details()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_details.md),
[`sportality_athlete_profile()`](https://hoopR.sportsdataverse.org/reference/sportality_athlete_profile.md),
[`sportality_boxscore()`](https://hoopR.sportsdataverse.org/reference/sportality_boxscore.md),
[`sportality_game_header()`](https://hoopR.sportsdataverse.org/reference/sportality_game_header.md),
[`sportality_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportality_game_overview.md),
[`sportality_game_summary()`](https://hoopR.sportsdataverse.org/reference/sportality_game_summary.md),
[`sportality_last_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_last_game_day.md),
[`sportality_layout_info()`](https://hoopR.sportsdataverse.org/reference/sportality_layout_info.md),
[`sportality_next_game_day()`](https://hoopR.sportsdataverse.org/reference/sportality_next_game_day.md),
[`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md),
[`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md),
[`sportality_player_crosswalk()`](https://hoopR.sportsdataverse.org/reference/sportality_player_crosswalk.md),
[`sportality_player_h2h()`](https://hoopR.sportsdataverse.org/reference/sportality_player_h2h.md),
[`sportality_post_game_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_post_game_team_stats.md),
[`sportality_roster()`](https://hoopR.sportsdataverse.org/reference/sportality_roster.md),
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_standings(ssgt_uuid = "xs07bd3fmp"))
#> ── Basketligaen Standings from basketligaen.dk ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:34:06 UTC
#> # A tibble: 12 × 13
#>    team_id team_uuid  team_code team_name     rank    gp     w     l    tp `for`
#>      <int> <chr>      <chr>     <chr>        <int> <int> <int> <int> <int> <int>
#>  1   22255 iutrlqp3ef TFN       Team FOG Næ…     1     8     8     0    16   830
#>  2   22248 ktcu9aaala BAK       Bakken Bears     2     7     7     0    14   739
#>  3   22249 hip2m60a45 HIC       Horsens IC       3     8     6     2    12   701
#>  4   22256 kgmhwo9l5d SVE       Svendborg R…     4     8     6     2    12   729
#>  5   22250 gvvuxe9ysw RAN       Randers Cim…     5     8     5     3    10   762
#>  6  156486 ka7lusvmtn BCC       BC Copenhag…     6     7     4     3     8   573
#>  7  153747 rfo82vr830 HOL       Holbæk-Sten…     7     8     3     5     6   609
#>  8  199228 nuzzapynfd GLX       Gladsaxe Ba…     8     8     2     6     4   623
#>  9  114932 ozojzoejir VBH       Værløse Blu…     9     8     2     6     4   659
#> 10  187013 wv1lcxg0u2 BKV       BK Vejen        10     8     2     6     4   648
#> 11  140898 kgejfzwwbd BMS       BMS Herlev      11     8     1     7     2   616
#> 12  130088 swr1d65lew BAC       Bears Acade…    12     8     1     7     2   619
#> # ℹ 3 more variables: ga <int>, plus_minus <int>, strk <int>
# }
```
