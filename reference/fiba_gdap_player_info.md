# **FIBA GDAP: player info**

A player's bio and per-game averages with ranks at a competition.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapplayerinfobycompetitionid`

## Usage

``` r
fiba_gdap_player_info(player_id, comp, return_parsed = TRUE)
```

## Arguments

- player_id:

  (integer, required) Required. FIBA person id (global): personId of a
  roster row, pId in play-by-play, P\_`<id>` in the game-page box

- comp:

  (integer, required) Required. FIBA competition id (GDAP key space),
  one per edition: competition.competitionId of any game row (208182 =
  World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL 2024-25). Find
  it with fiba_gdap_editions or fiba_gdap_games_between.

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble (the raw JSON list when `return_parsed = FALSE`)
with the following columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | FIBA person id, global across competitions and roles (player, coach, official): roster personId = play-by-play pId = game-page P\_`<id>` = gdapPlayerId. |
| competition_id | integer | FIBA competition id (GDAP key space): one per edition (2023 World Cup = 208182, BCL 2024-25 = 208850); gdapCompetitionId. |
| competition_team_id | integer | Competition team id: one per team per competition (Germany = 279569 at the 2023 World Cup, 281545 at Paris 2024). Joins getgdapcompetitionteamrosterbyteamid / getgdapcompetitionteamstatisticsbyteamid gdapTeamId; not an organisationId. |
| organisation_id | integer | Organisation id, stable across competitions and seasons: the national federation for a national team (64 = Germany), the club for a club team (396 = Filou Oostende). Same key space as nationalFederationId, clubId, play-by-play oId and the game page's T\_`<id>`. |
| first_name | character | Given name(s) as registered with FIBA. |
| last_name | character | Last name (officials: upper case). |
| height_cm | integer | Height in centimetres. |
| height_ft_in | character | Height, feet and inches string. |
| club_name | character | Club at the time of the competition. |
| club_code | character | Club abbreviation; always null in the samples, values unverified. |
| is_player_free_agent | logical | True when the player had no club. |
| points_per_game | double | The player's average points per game played. |
| rank_points_per_game | double | Rank in the competition by points per game (1 = highest). |
| rebounds_per_game | double | The player's average rebounds per game played. |
| rank_rebounds_per_game | double | Rank in the competition by rebounds per game (1 = highest). |
| assists_per_game | double | The player's average assists per game played. |
| rank_assists_per_game | double | Rank in the competition by assists per game (1 = highest). |
| points_per_game_per_competition_category | double | Average points per game across the competition category, the comparison baseline (unverified). |
| rebounds_per_game_per_competition_category | double | Average rebounds per game across the competition category, the comparison baseline (unverified). |
| assists_per_game_per_competition_category | double | Average assists per game across the competition category, the comparison baseline (unverified). |
| birth_date | character | Date of birth, YYYY-MM-DD. |
| nationalities | character | Nationalities (FIBA codes on player info; country objects on rosters and officials). Stored as a JSON string. |
| social_media_website | character | Website URL; always null in the samples, values unverified. |
| social_media_twitter | character | X/Twitter handle; always null in the samples, values unverified. |
| social_media_facebook | character | Facebook handle or URL; always null in the samples, values unverified. |
| social_media_instagram | character | Instagram handle; always null in the samples, values unverified. |
| social_media_youtube | character | YouTube handle; always null in the samples, values unverified. |
| social_networks | character | Social-network handles. Stored as a JSON string. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_player_info(player_id = 211501, comp = 208182)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
