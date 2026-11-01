# **Get ACB Player Data**

Player biography: birth, nationality, height, current team and social
links.

One row. `birth_date` is a date (the API sends DD-MM-YYYY); `height_m`
is metres (the API sends `'2,20'`, a decimal comma); `birth_country` /
`nationality` are Spanish with ISO alpha-2 in `*_iso`; `licensing` is
the licence code as sent (for example `EUR` or `JFL`; meanings
unverified). The current team columns are the player's team entry for
the edition.

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/player-data`

## Usage

``` r
acb_player_data(player_id)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_player_data`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ACB licence number of the player. |
| player_name | character | Display (sporting) name ('Edy Tavares') |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| is_license_active | logical | True when the licence is active in the current season. |
| licensing | character | Licence code (for example EUR, JFL); meaning unverified. |
| birth_date | Date | Birth date (the API sends DD-MM-YYYY). |
| birth_place | character | Birth place (town or city) as sent. |
| birth_country | character | Birth country as sent, a Spanish name. |
| birth_country_iso | character | ISO 3166-1 alpha-2 code of the birth country; null for an unseen name. |
| nationality | character | Nationality as sent, a Spanish country name. |
| nationality_iso | character | ISO 3166-1 alpha-2 code of nationality; null for an unseen name. |
| height_m | double | Height in metres (the API sends '2,20', a decimal comma). |
| player_number | integer | Current shirt number (integer). |
| team_id | integer | Current team's season-team entry id. |
| club_id | integer | Current team's stable club id. |
| team | character | Current team name for the edition. |
| team_abbr | character | Current team abbreviation. |
| edition_id | integer | Season id the player record was read for (START year - 1935). |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| instagram | character | Instagram handle; null when none. |
| twitter | character | X / Twitter handle; null when none. |
| facebook | character | Facebook handle; null when none. |
| youtube | character | YouTube handle; null when none. |
| tiktok | character | TikTok handle; null when none. |
| pronunciation_url | character | URL of an audio clip of the name; null when none. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

Other ACB Functions:
[`acb_box_info()`](https://hoopR.sportsdataverse.org/reference/acb_box_info.md),
[`acb_bracket()`](https://hoopR.sportsdataverse.org/reference/acb_bracket.md),
[`acb_bracket_games()`](https://hoopR.sportsdataverse.org/reference/acb_bracket_games.md),
[`acb_calendar()`](https://hoopR.sportsdataverse.org/reference/acb_calendar.md),
[`acb_career_stints()`](https://hoopR.sportsdataverse.org/reference/acb_career_stints.md),
[`acb_career_trophies()`](https://hoopR.sportsdataverse.org/reference/acb_career_trophies.md),
[`acb_club_data()`](https://hoopR.sportsdataverse.org/reference/acb_club_data.md),
[`acb_competition_current()`](https://hoopR.sportsdataverse.org/reference/acb_competition_current.md),
[`acb_competition_editions()`](https://hoopR.sportsdataverse.org/reference/acb_competition_editions.md),
[`acb_competition_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_competition_rounds.md),
[`acb_competition_weeks()`](https://hoopR.sportsdataverse.org/reference/acb_competition_weeks.md),
[`acb_current_roster()`](https://hoopR.sportsdataverse.org/reference/acb_current_roster.md),
[`acb_lead_stats()`](https://hoopR.sportsdataverse.org/reference/acb_lead_stats.md),
[`acb_lead_tracker()`](https://hoopR.sportsdataverse.org/reference/acb_lead_tracker.md),
[`acb_league_zones()`](https://hoopR.sportsdataverse.org/reference/acb_league_zones.md),
[`acb_lineup()`](https://hoopR.sportsdataverse.org/reference/acb_lineup.md),
[`acb_match_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_match_advanced_stats.md),
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md),
[`acb_match_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_match_leaders.md),
[`acb_matchlist()`](https://hoopR.sportsdataverse.org/reference/acb_matchlist.md),
[`acb_next_matches()`](https://hoopR.sportsdataverse.org/reference/acb_next_matches.md),
[`acb_pbp()`](https://hoopR.sportsdataverse.org/reference/acb_pbp.md),
[`acb_period_scores()`](https://hoopR.sportsdataverse.org/reference/acb_period_scores.md),
[`acb_player_advanced_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_advanced_stats.md),
[`acb_player_box()`](https://hoopR.sportsdataverse.org/reference/acb_player_box.md),
[`acb_player_matches()`](https://hoopR.sportsdataverse.org/reference/acb_player_matches.md),
[`acb_player_stats()`](https://hoopR.sportsdataverse.org/reference/acb_player_stats.md),
[`acb_player_totals()`](https://hoopR.sportsdataverse.org/reference/acb_player_totals.md),
[`acb_quickfacts()`](https://hoopR.sportsdataverse.org/reference/acb_quickfacts.md),
[`acb_round_matches()`](https://hoopR.sportsdataverse.org/reference/acb_round_matches.md),
[`acb_search()`](https://hoopR.sportsdataverse.org/reference/acb_search.md),
[`acb_season_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_season_leaders.md),
[`acb_serie()`](https://hoopR.sportsdataverse.org/reference/acb_serie.md),
[`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md),
[`acb_standings()`](https://hoopR.sportsdataverse.org/reference/acb_standings.md),
[`acb_standings_rounds()`](https://hoopR.sportsdataverse.org/reference/acb_standings_rounds.md),
[`acb_team_box()`](https://hoopR.sportsdataverse.org/reference/acb_team_box.md),
[`acb_team_comparison()`](https://hoopR.sportsdataverse.org/reference/acb_team_comparison.md),
[`acb_team_leaders()`](https://hoopR.sportsdataverse.org/reference/acb_team_leaders.md),
[`acb_team_matches()`](https://hoopR.sportsdataverse.org/reference/acb_team_matches.md),
[`acb_team_records()`](https://hoopR.sportsdataverse.org/reference/acb_team_records.md),
[`acb_team_stats()`](https://hoopR.sportsdataverse.org/reference/acb_team_stats.md),
[`acb_team_totals()`](https://hoopR.sportsdataverse.org/reference/acb_team_totals.md),
[`acb_teams()`](https://hoopR.sportsdataverse.org/reference/acb_teams.md)

## Examples

``` r
# \donttest{
  try(acb_player_data(player_id = 20209407))
#> ── ACB Player Data from api2.acb.com ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:37:41 UTC
#> # A tibble: 1 × 28
#>   player_id player_name first_name last_name shirt_number game_role
#>       <int> <chr>       <chr>      <chr>     <chr>        <chr>    
#> 1  20209407 Edy Tavares Walter     Tavares   22           Pívot    
#> # ℹ 22 more variables: is_license_active <lgl>, licensing <chr>,
#> #   birth_date <date>, birth_place <chr>, birth_country <chr>,
#> #   birth_country_iso <chr>, nationality <chr>, nationality_iso <chr>,
#> #   height_m <dbl>, player_number <int>, team_id <int>, club_id <int>,
#> #   team <chr>, team_abbr <chr>, edition_id <int>, season <int>,
#> #   instagram <chr>, twitter <chr>, facebook <chr>, youtube <chr>,
#> #   tiktok <chr>, pronunciation_url <chr>
# }
```
