# **TBF Team Player Stats**

Season player statistics of one team-season: totals, percentages and
per-game averages.

Endpoint:
`GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-statistic`

## Usage

``` r
tbf_team_player_stats(season, team_process_id, competition = "bsl")
```

## Arguments

- season:

  Required. Season END year (2027 = the 2026-2027 season). TBF keys a
  league-season by internal season and activity ids; the runtime reads
  them from the league's season list by the END year of the label. A
  year the list lacks raises `hoopR_no_data`.

- team_process_id:

  Required. Team-season id (team registration), e.g. 265995 = Tofas in
  BSL 2026-27; team_process_id in
  [`tbf_teams()`](https://hoopR.sportsdataverse.org/reference/tbf_teams.md)
  and
  [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md).
  New for every club in every league-season; not the stable club_id.

- competition:

  TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl
  (women's Super Ligi). The top flight was named TBL until 2007-08 and
  is listed under bsl.

## Value

A `hoopR_data` tibble. One row per player. Every column below is always
present (a zero-row tibble keeps them and their types); an answer with
nothing in it raises `hoopR_no_data`, as in sportsdataverse-py.

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
| competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
| team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
| person_id | integer | TBF person id (code; key space: TBF persons, stable across seasons and clubs). |
| jersey_number | character | Shirt number (oyuncuNo) as a string. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| games | integer | Games played (macSayisi). |
| seconds_played | integer | Season total time on court in seconds (sureToplam 'hh:mm:ss'). |
| points | integer | Season total points (sayiToplam; the API sends it as a string). |
| fg_made | integer | Season field goals made (agBasarili; sent as a string). |
| fg_attempted | integer | Season field goals attempted (agDeneme). |
| fg2_made | integer | Season two-point field goals made (puan20Toplam). |
| fg2_attempted | integer | Season two-point field goals attempted (puan21Toplam). |
| fg3_made | integer | Season three-point field goals made (puan30Toplam). |
| fg3_attempted | integer | Season three-point field goals attempted (puan31Toplam). |
| ft_made | integer | Season free throws made (sA0Toplam). |
| ft_attempted | integer | Season free throws attempted (sA1Toplam). |
| def_rebounds | integer | Season defensive rebounds (drToplam). |
| off_rebounds | integer | Season offensive rebounds (hrToplam). |
| rebounds | integer | Season total rebounds (trToplam). |
| assists | integer | Season assists (asistToplam). |
| blocks | integer | Season blocks (blokToplam). |
| steals | integer | Season steals (topCalmaToplam). |
| turnovers | integer | Season turnovers (topKaybiToplam). |
| fouls | integer | Season personal fouls (faulToplam). |
| plus_minus | double | Season plus/minus contribution (oyunaKatki = contribution to the game), a decimal string. |
| efficiency | integer | Season efficiency rating total (vpToplam, verimlilik puani). |
| fg_pct | double | Field-goal percentage 0-100 with two decimals (agYuzdesi). |
| fg2_pct | double | Two-point percentage 0-100 with two decimals (ikilikYuzdesi). |
| fg3_pct | double | Three-point percentage 0-100 with two decimals (uclukYuzdesi). |
| ft_pct | double | Free-throw percentage 0-100 with two decimals (serbestAtisYuzdesi). |
| seconds_per_game | integer | Average time on court per game in seconds (sureOrtalama 'hh:mm:ss'). |
| points_per_game | double | Points per game (sayiOrtalama). |
| rebounds_per_game | double | Rebounds per game (trOrtalama). |
| assists_per_game | double | Assists per game (asistOrtalama). |
| steals_per_game | double | Steals per game (topCalmaOrtalama). |
| blocks_per_game | double | Blocks per game (blokOrtalama). |
| turnovers_per_game | double | Turnovers per game (topKaybiOrtalama). |
| efficiency_per_game | double | Efficiency rating per game (vpOrtalama). |

## Details

Official TBF app API, unofficial for SportsDataverse: the backend of the
Turkish Basketball Federation's mobile app (miniappapi.tbf.org.tr),
which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
robots.txt answers 404 on the host, and the runtime spaces requests at
least 1 s apart. TBF's terms were not reviewed; check them before you
republish the data. The vendor's origin hosts (nikayazilim.com) serve
the same data without Cloudflare but are deliberately not used,
redirects are never followed, and www.tbf.org.tr's interactive Turnstile
is neither used nor automated.

Coverage: season and competition are parameters (`bsl` Basketbol Super
Ligi, back to 1966-67 in the league list; `tbl` second tier; `kbsl`
women, both from 2015-16). Game wrappers serve FINISHED games only (an
unfinished game raises `hoopR_asset_fetch`). Box scores exist from
2006-07 (no starters flagged that season); play-by-play and shots from
2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
game carries a Genius LiveStats id (`genius_id`, joins the `genius`
family) from 2018-19 on some seasons and on every game of 2025-26 and
later. Birth dates, contact details, photos and logos are dropped. Names
and category labels are Turkish; the column descriptions give the
English gloss.

Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404,
an unknown game or player, a season the league list lacks, an empty
list, a finished game before 2025-26 asked for play-by-play or shots);
`hoopR_bad_request` for an invalid argument or HTTP 400 / 422;
`hoopR_asset_fetch` when the fetch failed or the answer is not the one
asked for (an unfinished game, a body for another game, season, league
or team, an error envelope, a redirect, a partial page or a changed
capped list). All inherit `hoopR_error`. Timestamps are Turkey local
time (`Europe/Istanbul`).

     tbf_team_player_stats(season = 2027, team_process_id = 265995)

## See also

[family_tbf](https://hoopR.sportsdataverse.org/reference/family_tbf.md)
lists every function in this family.
