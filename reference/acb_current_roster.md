# **Get ACB Current Roster**

A club's players and staff for an edition (default: the current one).

One row per person; `role` is player or staff (head coach and
assistants). `person_id` is the ACB licence number (a player's
`player_id`). `height_cm` is the player's height in centimetres (null
for staff); `age` is the age now; `nationality` is Spanish and
`nationality_iso` its ISO alpha-2 code. `temporary_roster` is true while
the roster is provisional. Absence lists are not parsed.

Endpoint:
`GET https://api2.acb.com/api/seasondata/TeamProfile/current-roster`

## Usage

``` r
acb_current_roster(club_id, competition_id = NULL, season = NULL)
```

## Arguments

- club_id:

  (required) ACB club id (integer), stable across seasons and sponsor
  names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket). Not the
  season-team `team_id`. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year (2027 = 2026-27; the first ACB
  season, 1983-84, is 1984). `acb_runtime` sends the API's `editionId` =
  season - 1936. Omitted = the current season. A whole number; a whole
  double is accepted.

## Value

A `hoopR_data` tibble with one row per person. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_current_roster")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_current_roster(club_id = 2, season = 2027))
#> ── ACB Current Roster from api2.acb.com ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:51:34 UTC
#> # A tibble: 19 × 17
#>    club_id role   person_id person_name        first_name last_name shirt_number
#>      <int> <chr>      <int> <chr>              <chr>      <chr>     <chr>       
#>  1       2 player  30003361 Kevin Punter       Kevin      Punter    0           
#>  2       2 player  30005355 Umoja Gibson       Umoja      Gibson    1           
#>  3       2 player  30005378 Tyrese Martin      Tyrese     Martin    2           
#>  4       2 player  30005361 Stanley Umude      Stanley    Umude     3           
#>  5       2 player  30003340 Justin Robinson    Justin     Robinson  5           
#>  6       2 player  20209919 Darío Brizuela     Darío      Brizuela  8           
#>  7       2 player  30001332 Agustín Ubal       Agustín    Ubal      10          
#>  8       2 player  30005357 Olivier Nkamhoua   Olivier    Nkamhoua  13          
#>  9       2 player  30000093 Juan Núñez         Juan       Núñez     17          
#> 10       2 player  30005377 Tosan Evbuomwan    Torisesan  Evbuomwan 20          
#> 11       2 player  20212243 Olek Balcerowski   Aleksander Balcerow… 22          
#> 12       2 player  30005476 Justin Minaya      Justin     Minaya    24          
#> 13       2 player  30005356 Josh Nebo          Joshua     Nebo      32          
#> 14       2 player  30004602 Abdu Kone          Abdrahama… Kone      34          
#> 15       2 player  20212265 Joel Parra         Joel       Parra     44          
#> 16       2 player  30005447 Yoan Makoundou     Yoan       Makoundou 55          
#> 17       2 staff   30005390 Aleksander Sekulic Aleksander Sekulic   1           
#> 18       2 staff   30005459 Jurica Zuza        Jurica     Zuza      2           
#> 19       2 staff   30005460 Jernej Valentincic Jernej     Valentin… 3           
#> # ℹ 10 more variables: game_role <chr>, licensing <chr>, age <int>,
#> #   nationality <chr>, nationality_iso <chr>, height_cm <int>,
#> #   is_license_active <lgl>, edition_id <int>, season <int>,
#> #   temporary_roster <lgl>
# }
```
