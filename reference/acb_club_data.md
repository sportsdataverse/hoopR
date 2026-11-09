# **Get ACB Club Data**

Club profile: arena, contacts and links.

One row: the club's current team entry, the arena (name, address,
capacity), foundation year, contact details and social links. Several
fields are null for many clubs.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/club-data`

## Usage

``` r
acb_club_data(club_id)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_club_data`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
| club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
| team | character | Team name that season (sponsor names change) |
| team_abbr | character | Three-letter abbreviation (BAR, RMB) |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
| edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
| stadium_name | character | Arena name (the club's home venue). |
| stadium_address | character | Arena street address. |
| stadium_capacity | integer | Arena capacity. |
| president | character | Club president's name; null for most clubs. |
| foundation_year | integer | Year the club was founded. |
| web_url | character | Club website URL. |
| ticketing_url | character | Club ticket shop URL. |
| merchandising_url | character | Club merchandise shop URL (the API's merchanUrl). |
| instagram_url | character | Club Instagram URL. |
| twitter_url | character | Club X / Twitter URL. |
| facebook_url | character | Club Facebook URL. |
| youtube_url | character | Club YouTube URL. |
| tiktok_url | character | Club TikTok URL. |
| validated | logical | True when the club profile is validated by the league. |
| temporary_roster | logical | True while the club's roster is provisional. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_club_data(club_id = 2)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
