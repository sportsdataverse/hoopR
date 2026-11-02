# **Get EASL Teams**

The 12 ACTIVE EASL teams (historical teams resolve only through
easl_team).

Endpoint: `GET https://easl.joshricha.com/api/v1/teams`

## Usage

``` r
easl_teams()
```

## Value

A `hoopR_data` tibble: The 12 ACTIVE EASL teams (historical teams
resolve only through easl_team). An empty answer raises `hoopR_no_data`;
the columns are always these, in this order (sportsdataverse-py
`easl_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| team_row_id | integer | The sync server's own integer row id of the team (not a DataCore id; inactive teams interleave, so ids of /teams rows have gaps). |
| team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
| name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
| name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
| code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
| code_local | character | Alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
| standard | character | Competition standard: ELITE. |
| age_group | character | Age group: SENIOR; null on some inactive teams. |
| gender | character | Competition gender of the team: MALE (the EASL is a men's competition). |
| status | character | ACTIVE for teams in the current season (the only ones /teams lists), INACTIVE for historical teams (only via `/teams/{teamId}`). |
| primary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
| secondary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
| tertiary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
| logo | character | Club logo URL on the Sportradar DataCore asset CDN (images.dc.connect.sportradar.com/b1e0z/...). |
| website | character | Club website URL; most clubs have none. Null on some rows. |
| facebook_username | character | Club Facebook handle; most clubs have none. Null on some rows. |
| twitter_username | character | Club X / Twitter handle; most clubs have none. Null on some rows. |
| instagram_username | character | Club Instagram handle; some clubs have none. Null on some rows. |
| wikipedia_url | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| organization_id | character | DataCore organisation id: b1e0z (EASL). |
| created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
| updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player()`](https://hoopR.sportsdataverse.org/reference/easl_player.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md)

## Examples

``` r
# \donttest{
  try(easl_teams())
#> ── EASL Teams from easl.joshricha.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-02 01:51:24 UTC
#> # A tibble: 12 × 22
#>    team_row_id team_id          name  name_native code_latin code_local standard
#>          <int> <chr>            <chr> <chr>       <chr>      <chr>      <chr>   
#>  1           1 0548e9a7-99e0-1… Alva… NA           NA        NA         ELITE   
#>  2           2 27492b3f-5ada-1… Hong… Hong Kong … "HKE"      HKE        ELITE   
#>  3          21 6c173781-a6bf-1… Maca… Macau Hou … "MHC"      MHC        ELITE   
#>  4           4 71f8b351-5acf-1… Busa… Busan KCC … "KCC"      KCC        ELITE   
#>  5           7 86515908-b0f5-1… Taip… NA          "TFB"      富邦勇士   ELITE   
#>  6          10 865db37a-b0f5-1… Ryuk… 琉球ゴールデンキング… ""         RGK        ELITE   
#>  7          22 992dc7e4-a6c0-1… TSG … TSG Ghosth… "TSG"      TSG        ELITE   
#>  8          23 9f419ff5-a6be-1… Abra… Abra Weave… "ABR"      ABR        ELITE   
#>  9          24 a6c6b0a0-a6c0-1… Naga… Nagasaki V… "NAG"      NAG        ELITE   
#> 10          25 b9a6e682-a6bf-1… Goya… Goyang Son… "SON"      SON        ELITE   
#> 11          17 cbf7cf59-99df-1… Sout… NA           NA        BRO        ELITE   
#> 12          20 f170040e-5ad9-1… Taoy… Taoyuan Pa… ""         TPP        ELITE   
#> # ℹ 15 more variables: age_group <chr>, gender <chr>, status <chr>,
#> #   primary_color <chr>, secondary_color <chr>, tertiary_color <chr>,
#> #   logo <chr>, website <chr>, facebook_username <chr>, twitter_username <chr>,
#> #   instagram_username <chr>, wikipedia_url <chr>, organization_id <chr>,
#> #   created_at <chr>, updated_at <chr>
# }
```
