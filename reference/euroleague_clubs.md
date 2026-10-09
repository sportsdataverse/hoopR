# **EuroLeague Clubs**

**Get the clubs in a season.**

Endpoint:
`GET https://api-live.euroleague.net/v2/competitions/{competition_code}/seasons/{season_code}/clubs`

## Usage

``` r
euroleague_clubs(competition_code, season_code)
```

## Arguments

- competition_code:

  (*character* required): `E` = EuroLeague, `U` = EuroCup (see
  [`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md)).

- season_code:

  (*character* required): Competition code + start year, e.g. `E2025`
  for 2025-26.

## Value

A `hoopR_data` tibble with one row per club:

|  |  |  |
|----|----|----|
| col_name | types | description |
| code | character | EuroLeague code of the entity (competition, season, club, person or venue; Utf8 join key). |
| name | character | Display name. |
| abbreviated_name | character | Abbreviated display name. |
| editorial_name | character | Editorial (long-form) display name. |
| tv_code | character | Three-letter broadcast abbreviation of the club. |
| is_virtual | logical | Whether the club is a placeholder rather than a real club. |
| sponsor | character | Club sponsor. |
| club_permanent_name | character | Permanent club name independent of sponsor naming. |
| club_permanent_alias | character | Permanent club alias independent of sponsor naming. |
| address | character | Street address. |
| website | character | Official website URL. |
| tickets_url | character | Ticketing URL. |
| twitter_account | character | Twitter / X handle. |
| venue_code | character | Code of the venue the club or game plays at (Utf8 join key). |
| city | character | City the club is based in. |
| president | character | Club president. |
| phone | character | Contact phone number. |
| images_crest | character | URL of the club crest image. |
| country_code | character | ISO country code. |
| country_name | character | Country name. |

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it (wrap-only: payloads are not redistributed as release
assets). This function mirrors its sdv-py twin of the same name: same
arguments, defaults and snake_case columns, one row per sdv-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sdv-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

Other Euroleague:
[`euroleague_competitions()`](https://hoopR.sportsdataverse.org/reference/euroleague_competitions.md),
[`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md),
[`euroleague_game_header()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_header.md),
[`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md),
[`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md),
[`euroleague_game_report()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_report.md),
[`euroleague_game_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_stats.md),
[`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md),
[`euroleague_people()`](https://hoopR.sportsdataverse.org/reference/euroleague_people.md),
[`euroleague_player_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_player_stats.md),
[`euroleague_rounds()`](https://hoopR.sportsdataverse.org/reference/euroleague_rounds.md),
[`euroleague_seasons()`](https://hoopR.sportsdataverse.org/reference/euroleague_seasons.md),
[`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md),
[`euroleague_team_stats()`](https://hoopR.sportsdataverse.org/reference/euroleague_team_stats.md)

## Examples

``` r
# \donttest{
  try({
    euroleague_clubs(competition_code = "E", season_code = "E2025")
  })
#> ── EuroLeague clubs from api-live.euroleague.net ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 04:32:35 UTC
#> # A tibble: 20 × 20
#>    code  name         abbreviated_name editorial_name tv_code is_virtual sponsor
#>    <chr> <chr>        <chr>            <chr>          <chr>   <lgl>      <chr>  
#>  1 IST   Anadolu Efe… Anadolu Efes     Efes           EFS     FALSE      Anadol…
#>  2 MCO   AS Monaco    Monaco           Monaco         ASM     FALSE      AS Mon…
#>  3 RED   Crvena Zvez… Crvena Zvezda    Crvena Zvezda  CZV     FALSE      Crvena…
#>  4 DUB   Dubai Baske… Dubai            Dubai          DUB     FALSE      Dubai …
#>  5 MIL   EA7 Emporio… Milan            Milan          EA7     FALSE      EA7 Em…
#>  6 BAR   FC Barcelona Barcelona        Barcelona      BAR     FALSE      FC Bar…
#>  7 MUN   FC Bayern M… Bayern           Bayern         BAY     FALSE      FC Bay…
#>  8 ULK   Fenerbahce … Fenerbahce       Fenerbahce     FBB     FALSE      Fenerb…
#>  9 HTA   Hapoel IBI … Hapoel Tel Aviv  Hapoel Tel Av… HTA     FALSE      Hapoel…
#> 10 BAS   Kosner Bask… Baskonia         Baskonia       KBA     FALSE      Kosner…
#> 11 ASV   LDLC ASVEL … ASVEL            ASVEL          ASV     FALSE      LDLC A…
#> 12 TEL   Maccabi Rap… Maccabi          Maccabi        MTA     FALSE      Maccab…
#> 13 OLY   Olympiacos … Olympiacos       Olympiacos     OLY     FALSE      Olympi…
#> 14 PAN   Panathinaik… Panathinaikos    Panathinaikos  PAO     FALSE      Panath…
#> 15 PRS   Paris Baske… Paris            Paris          PBB     FALSE      Paris …
#> 16 PAR   Partizan Mo… Partizan         Partizan       PAR     FALSE      Partiz…
#> 17 MAD   Real Madrid  Real             Real           RMB     FALSE      Real M…
#> 18 PAM   Valencia Ba… Valencia         Valencia       VBC     FALSE      Valenc…
#> 19 VIR   Virtus Bolo… Virtus           Virtus         VIR     FALSE      Virtus…
#> 20 ZAL   Zalgiris Ka… Zalgiris         Zalgiris       ZAL     FALSE      Zalgir…
#> # ℹ 13 more variables: club_permanent_name <chr>, club_permanent_alias <chr>,
#> #   address <chr>, website <chr>, tickets_url <chr>, twitter_account <chr>,
#> #   venue_code <chr>, city <chr>, president <chr>, phone <chr>,
#> #   images_crest <chr>, country_code <chr>, country_name <chr>
# }
```
