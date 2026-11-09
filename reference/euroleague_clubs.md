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

A `hoopR_data` tibble with one row per club. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "euroleague_clubs")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Unofficial, keyless API, not supported by Euroleague Basketball; hoopR
only wraps it. This function mirrors its sportsdataverse-py twin of the
same name: same arguments, defaults and snake_case columns, one row per
sportsdataverse-py row.

A failed request raises a classed condition instead of returning an
empty frame, mirroring sportsdataverse-py's error vocabulary: a 404 is
`hoopR_no_data`, a 400 / 422 is `hoopR_invalid_request`, any other
failure (another status, a transport error, a non-JSON body) is
`hoopR_fetch_error`; all three inherit `hoopR_error`.

## See also

[family_euroleague](https://hoopR.sportsdataverse.org/reference/family_euroleague.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try({
    euroleague_clubs(competition_code = "E", season_code = "E2025")
  })
#> ── EuroLeague clubs from api-live.euroleague.net ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:59 UTC
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
