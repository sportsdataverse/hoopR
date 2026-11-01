# **Get Basketligaen Team Roster**

Current roster of a team, grouped by position.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/athletes/by-team-uuid/{team_uuid}`

## Usage

``` r
sportality_roster(team_uuid)
```

## Arguments

- team_uuid:

  (required) Team uuid: `homeTeamInfo.uuid` / `awayTeamInfo.uuid` in the
  schedule or `teamList[].uuid`. Key space: platform team uuids (not the
  numeric Genius team id).

## Value

A `hoopR_data` tibble: Current roster of a team, grouped by position. An
empty valid answer raises `hoopR_no_data`; the documented columns come
first, in this order (sportsdataverse-py `sportality_roster`), then any
column the API added later:

|  |  |  |
|----|----|----|
| col_name | type | description |
| position | character | Playing position. |
| position_code | character | Position code (G, F, C, or a finer code such as SG on the profile route). Values: `C` = center; `F` = forward; `G` = guard. |
| player_type | character | Record type (athlete). Values: `athlete` = a player. |
| gender | character | Gender of the person as recorded by the site (male in every row seen). |
| uuid | character | Athlete uuid (platform key space). |
| first_name | character | Given (first) name(s) of the player. |
| last_name | character | Family name (surname) of the player. |
| full_name | character | Full display name of the player. |
| nationality | character | ISO 3166-1 alpha-2 country code. |
| jersey_number | integer | Jersey (shirt) number of the player. |
| portrait_url | character | URL of the player's latest rendered portrait. |

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
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md),
[`sportality_season_filter()`](https://hoopR.sportsdataverse.org/reference/sportality_season_filter.md),
[`sportality_sites()`](https://hoopR.sportsdataverse.org/reference/sportality_sites.md),
[`sportality_ssgt_provider()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_provider.md),
[`sportality_ssgt_uuid()`](https://hoopR.sportsdataverse.org/reference/sportality_ssgt_uuid.md),
[`sportality_standings()`](https://hoopR.sportsdataverse.org/reference/sportality_standings.md),
[`sportality_stats_info()`](https://hoopR.sportsdataverse.org/reference/sportality_stats_info.md),
[`sportality_team()`](https://hoopR.sportsdataverse.org/reference/sportality_team.md),
[`sportality_team_played_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_played_games.md),
[`sportality_team_stats()`](https://hoopR.sportsdataverse.org/reference/sportality_team_stats.md),
[`sportality_team_upcoming_games()`](https://hoopR.sportsdataverse.org/reference/sportality_team_upcoming_games.md)

## Examples

``` r
# \donttest{
  try(sportality_roster(team_uuid = "rfo82vr830"))
#> ── Basketligaen Team Roster from basketligaen.dk ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 21:51:03 UTC
#> # A tibble: 14 × 13
#>    position position_code player_type gender uuid       first_name    last_name 
#>    <chr>    <chr>         <chr>       <chr>  <chr>      <chr>         <chr>     
#>  1 Guards   G             athlete     male   cj81dc09w3 Malthe        Aabling   
#>  2 Guards   G             athlete     male   cjcrt5hlho Bryceson      Burns     
#>  3 Guards   G             athlete     male   dmon8irp4j Maxim         Shinkarev 
#>  4 Guards   G             athlete     male   hnrg2dqjcu Oskar Harring Østoft    
#>  5 Guards   G             athlete     male   k1nh3mnqzp Julius        Aabling   
#>  6 Guards   G             athlete     male   khm59ormd2 Sebastian     Reumert   
#>  7 Guards   G             athlete     male   q87tbjqicc Bertil        Anneberg …
#>  8 Guards   G             athlete     male   wtpfbry97z Karl          Heming    
#>  9 Guards   G             athlete     male   zu0qp4mq65 Anders        Jellesmark
#> 10 Forwards F             athlete     male   fjn17iovmg August        Heming    
#> 11 Forwards F             athlete     male   m8ajfnag3m Caden         Fry       
#> 12 Centers  C             athlete     male   fyeh5w7iar Oskar Fløng   Vanner    
#> 13 Centers  C             athlete     male   mqers10jtj Daniel        Stubkjær  
#> 14 Centers  C             athlete     male   wz2bk7trd4 Visti         Thomsen   
#> # ℹ 6 more variables: full_name <chr>, nationality <chr>, jersey_number <int>,
#> #   portrait_url <chr>, height <int>, weight <int>
# }
```
