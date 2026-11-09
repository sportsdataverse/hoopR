# **Get ACB Search**

Search players, teams and coaches by name.

One row per hit; `kind` is player, team or coach. The sample holds
players only (`teams` and `coaches` came back empty), so the team and
coach row shapes are unverified. `person_id` is the licence number for
players and coaches (a team hit carries its team entry id).

Endpoint: `GET https://api2.acb.com/api/seasondata/Search/search`

## Usage

``` r
acb_search(search_term, limit = NULL)
```

## Arguments

- search_term:

  (required) Name fragment (accent-insensitive on the player rows); a
  blank term is refused.

- limit:

  (default `NULL`) Maximum results per kind (players, teams, coaches). A
  whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py `acb_search`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| kind | character | player, team or coach. |
| person_id | integer | ACB licence number (players, coaches) or the team entry id (teams). |
| name | character | Display name (nickname) of a player or coach; the team name of a team. |
| short_name | character | Short display name ('T. Martin'). |
| first_name | character | Legal first name(s) |
| last_name | character | Legal last name(s) |
| shirt_number | character | Shirt number, a string (” or null when unknown) |
| game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or ” in many rows |
| is_license_active | logical | The licence is active in the current season |
| club_id | integer | Stable club id of a team hit; null for players. |
| edition_id | integer | Season id of the record; null in search results. |
| season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_search(limit = 5, search_term = "tavares")

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
