# International Basketball Data in R: EuroLeague, FIBA and 40+ Leagues with hoopR

**`hoopR` is not only the NBA and college basketball.** It also reads
the public data feeds of the EuroLeague, FIBA’s national-team and club
competitions and dozens of domestic leagues on six continents: 682
functions in 35 function families in this version. This guide maps each
league to its function prefix, says what data it offers, and shows the
call pattern so you can go from “I want Spanish league play-by-play” to
a data frame quickly.

The code below is not run when this site is built: these functions call
live league websites, which can be slow, rate-limited or blocked from
the cloud servers that build documentation. Run the examples on your own
machine. New to `hoopR`? Start with [Getting Started with
hoopR](https://hoopR.sportsdataverse.org/articles/getting-started-hoopR.md).

## How are the international functions organized?

Three patterns cover almost everything:

1.  **League families** named after the league or its data provider:
    `acb_*()` for Spain’s Liga Endesa, `kbl_*()` for Korea, `lba_*()`
    for Italy, and so on. Each family has its own identifiers (match
    ids, game keys, round ids), so you usually start from a schedule
    function and pass its ids to the game functions.
2.  **Platform families** for data providers that power many leagues:
    `genius_*()` (Genius Sports, pick the league with `org`),
    `atrium_*()` (Sportradar Atrium, pick the site with `website_id`),
    `nbl_rosetta_*()` (the Australian NBL’s stats API, pick `org`) and
    `fiba_gdap_*()` (FIBA’s data platform, pick the competition with
    `comp`).
3.  **Competition shortcuts** that wrap a platform for one league with a
    common set of verbs, typically `*_schedule()`, `*_pbp()`,
    `*_shots()`, `*_player_box()` and `*_team_box()`: `fiba_wc_*()` for
    the World Cup, `slb_*()` for the UK’s Super League Basketball,
    `lnb_*()` for France, and more. They take an END-year `season` (2026
    = 2025-26), like the rest of `hoopR`.

Every family is listed in the [International
Basketball](https://hoopR.sportsdataverse.org/reference/index.html#international-basketball)
and [Euroleague
Data](https://hoopR.sportsdataverse.org/reference/index.html#euroleague-data)
sections of the reference, with a return-column table on each function
page.

## Which leagues are covered?

“pbp” is play-by-play, “shots” is shot locations, “box” is player and
team box scores.

| League / competition | Country or region | Prefix | Schedule | pbp | Shots | Box | Key functions |
|----|----|----|----|----|----|----|----|
| EuroLeague, EuroCup | Europe | `euroleague_` | yes | yes | yes | yes | [`euroleague_games()`](https://hoopR.sportsdataverse.org/reference/euroleague_games.md), [`euroleague_game_pbp()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_pbp.md), [`euroleague_game_points()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_points.md), [`euroleague_game_boxscore()`](https://hoopR.sportsdataverse.org/reference/euroleague_game_boxscore.md), [`euroleague_standings()`](https://hoopR.sportsdataverse.org/reference/euroleague_standings.md) |
| FIBA national-team and club events (GDAP) | Worldwide | `fiba_gdap_`, `fiba_gamepage_` | yes | yes | yes | yes | [`fiba_gdap_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_schedule.md), [`fiba_gdap_editions()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_editions.md), [`fiba_gamepage_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_pbp.md), [`fiba_gamepage_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_shots.md), [`fiba_gamepage_box_players()`](https://hoopR.sportsdataverse.org/reference/fiba_gamepage_box_players.md) |
| FIBA World Cup | Worldwide | `fiba_wc_` | yes | yes | yes | yes | [`fiba_wc_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md), [`fiba_wc_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md), [`fiba_wc_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md), [`fiba_wc_player_box()`](https://hoopR.sportsdataverse.org/reference/fiba_wc_competition.md) |
| Olympic basketball | Worldwide | `fiba_oly_` | yes | yes | yes | yes | [`fiba_oly_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_oly_competition.md), [`fiba_oly_pbp()`](https://hoopR.sportsdataverse.org/reference/fiba_oly_competition.md) |
| EuroBasket, AmeriCup, Asia Cup, AfroBasket | Continental | `fiba_eurobasket_`, `fiba_americup_`, `fiba_asiacup_`, `fiba_afrobasket_` | yes | yes | yes | yes | [`fiba_eurobasket_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_eurobasket_competition.md) and the same verbs |
| Basketball Champions League, BCL Americas, Intercontinental Cup | FIBA club competitions | `fiba_bcl_`, `fiba_bcla_`, `fiba_icup_` | yes | yes | yes | yes | [`fiba_bcl_schedule()`](https://hoopR.sportsdataverse.org/reference/fiba_bcl_competition.md), [`fiba_bcl_shots()`](https://hoopR.sportsdataverse.org/reference/fiba_bcl_competition.md) |
| Genius Sports leagues (any `org`) | Many | `genius_` | yes | yes | yes | yes | [`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md), [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md), [`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md), [`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md) |
| Super League Basketball | United Kingdom | `slb_` | yes | yes | yes | yes | [`slb_schedule()`](https://hoopR.sportsdataverse.org/reference/slb_competition.md), [`slb_pbp()`](https://hoopR.sportsdataverse.org/reference/slb_competition.md) |
| Basketball Africa League (BAL) | Africa | `bal_` | yes | yes | yes | yes | [`bal_schedule()`](https://hoopR.sportsdataverse.org/reference/bal_competition.md), [`bal_pbp()`](https://hoopR.sportsdataverse.org/reference/bal_competition.md) |
| NZNBL | New Zealand | `nznbl_` | yes | yes | yes | yes | [`nznbl_schedule()`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md), [`nznbl_pbp()`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md) |
| Greek Basket League (ESAKE) | Greece | `esake_` | yes | yes | yes | yes | [`esake_schedule()`](https://hoopR.sportsdataverse.org/reference/esake_competition.md), [`esake_pbp()`](https://hoopR.sportsdataverse.org/reference/esake_competition.md) |
| Liga Nationala de Baschet Masculin | Romania | `lnbm_` | yes | yes | yes | yes | [`lnbm_schedule()`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md) |
| Liga Uruguaya de Basquetbol | Uruguay | `lub_` | yes | yes | yes | yes | [`lub_schedule()`](https://hoopR.sportsdataverse.org/reference/lub_competition.md) |
| Sportradar Atrium sites (any `website_id`) | Many, incl. Austria and Montenegro | `atrium_` | yes | yes | yes | yes | [`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md), [`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md), [`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md), [`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md) |
| LNB (Betclic Elite) | France | `lnb_` | yes | yes | yes | yes | [`lnb_schedule()`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md), [`lnb_pbp()`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md), [`lnb_shots()`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md) |
| LNBP (and Copa, LNBP Femenil) | Mexico | `lnbp_` | yes | yes | yes | yes | [`lnbp_schedule()`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md) |
| NBL1 (Atrium) | Australia | `nbl1_` | yes | yes | yes | yes | [`nbl1_schedule()`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md) |
| Liga Mayor de Baloncesto | El Salvador | `lmb_` | yes | yes | yes | yes | [`lmb_schedule()`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md) |
| LPB / LPBF | Panama | `lpb_` | yes | yes | yes | yes | [`lpb_schedule()`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md) |
| NBL, WNBL, NBL1 (Rosetta API) | Australia | `nbl_rosetta_` | yes | yes | no | yes | [`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md), [`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md), [`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md) |
| BBL, DBBL | Germany | `scb_` | yes | yes | no | yes | [`scb_games()`](https://hoopR.sportsdataverse.org/reference/scb_games.md), [`scb_game_actions()`](https://hoopR.sportsdataverse.org/reference/scb_game_actions.md), [`scb_game_players()`](https://hoopR.sportsdataverse.org/reference/scb_game_players.md) |
| Primera FEB, Segunda FEB, Liga Femenina | Spain | `feb_` | yes | yes | yes | yes | [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md), [`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md), [`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md), [`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md) |
| Liga Endesa (ACB), Copa del Rey, Supercopa | Spain | `acb_` | yes | yes | yes | yes | [`acb_matchlist()`](https://hoopR.sportsdataverse.org/reference/acb_matchlist.md), [`acb_pbp()`](https://hoopR.sportsdataverse.org/reference/acb_pbp.md), [`acb_shots()`](https://hoopR.sportsdataverse.org/reference/acb_shots.md), [`acb_player_box()`](https://hoopR.sportsdataverse.org/reference/acb_player_box.md) |
| BSL, KBSL (TBF) | Turkey | `tbf_` | yes | yes | yes | yes | [`tbf_schedule()`](https://hoopR.sportsdataverse.org/reference/tbf_schedule.md), [`tbf_pbp()`](https://hoopR.sportsdataverse.org/reference/tbf_pbp.md), [`tbf_shots()`](https://hoopR.sportsdataverse.org/reference/tbf_shots.md) |
| ABA League, ABA League 2 | Adriatic region | `aba_` | yes | yes | yes | yes | [`aba_calendar()`](https://hoopR.sportsdataverse.org/reference/aba_calendar.md), [`aba_pbp()`](https://hoopR.sportsdataverse.org/reference/aba_pbp.md), [`aba_shots()`](https://hoopR.sportsdataverse.org/reference/aba_shots.md), [`aba_box_players()`](https://hoopR.sportsdataverse.org/reference/aba_box_players.md) |
| B.LEAGUE (B1, B2, B3) | Japan | `bleague_` | yes | yes | yes | yes | [`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md), [`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md), [`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md) |
| BNXT League (SportPress) | Belgium, Netherlands | `sportpress_` | yes | see reference | no | yes | [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md), [`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md) |
| Chinese Basketball Association | China | `cba_` | yes | yes | yes | yes | [`cba_schedule_month()`](https://hoopR.sportsdataverse.org/reference/cba_schedule_month.md), [`cba_pbp()`](https://hoopR.sportsdataverse.org/reference/cba_pbp.md), [`cba_player_box()`](https://hoopR.sportsdataverse.org/reference/cba_player_box.md), [`cba_game_team_shots()`](https://hoopR.sportsdataverse.org/reference/cba_game_team_shots.md) |
| Canadian Elite Basketball League | Canada | `cebl_` (also `genius_` with `org = "CEBL"`) | yes | via Genius | via Genius | yes | [`cebl_games()`](https://hoopR.sportsdataverse.org/reference/cebl_games.md), [`cebl_player_stats()`](https://hoopR.sportsdataverse.org/reference/cebl_player_stats.md) |
| Basketligaen (Sportality) | Denmark | `sportality_` | yes | yes | no | yes | [`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md), [`sportality_pbp()`](https://hoopR.sportsdataverse.org/reference/sportality_pbp.md), [`sportality_player_box()`](https://hoopR.sportsdataverse.org/reference/sportality_player_box.md) |
| East Asia Super League | East Asia | `easl_` | yes | yes | no | yes | [`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md), [`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md), [`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md) |
| Israeli Premier League (IBBA) | Israel | `ibba_` | yes | yes | no | yes | [`ibba_games()`](https://hoopR.sportsdataverse.org/reference/ibba_games.md), [`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md), [`ibba_box_score()`](https://hoopR.sportsdataverse.org/reference/ibba_box_score.md) |
| Korean Basketball League | South Korea | `kbl_` | yes | yes | yes | yes | [`kbl_schedule()`](https://hoopR.sportsdataverse.org/reference/kbl_schedule.md), [`kbl_pbp()`](https://hoopR.sportsdataverse.org/reference/kbl_pbp.md), [`kbl_shots()`](https://hoopR.sportsdataverse.org/reference/kbl_shots.md) |
| KZS leagues | Slovenia | `kzs_` | yes | yes | no | yes | [`kzs_matches()`](https://hoopR.sportsdataverse.org/reference/kzs_matches.md), [`kzs_pbp()`](https://hoopR.sportsdataverse.org/reference/kzs_pbp.md), [`kzs_box_score()`](https://hoopR.sportsdataverse.org/reference/kzs_box_score.md) |
| Lega Basket Serie A | Italy | `lba_` | yes | yes | yes | yes | [`lba_calendar()`](https://hoopR.sportsdataverse.org/reference/lba_calendar.md), [`lba_pbp()`](https://hoopR.sportsdataverse.org/reference/lba_pbp.md), [`lba_shots()`](https://hoopR.sportsdataverse.org/reference/lba_shots.md), [`lba_box_score()`](https://hoopR.sportsdataverse.org/reference/lba_box_score.md) |
| Lietuvos krepsinio lyga | Lithuania | `lkl_` | yes | yes | yes | yes | [`lkl_results()`](https://hoopR.sportsdataverse.org/reference/lkl_results.md), [`lkl_pbp()`](https://hoopR.sportsdataverse.org/reference/lkl_pbp.md), [`lkl_shots()`](https://hoopR.sportsdataverse.org/reference/lkl_shots.md) |
| P. LEAGUE+ | Taiwan | `pleague_` | yes | yes | yes | yes | [`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md), [`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md), [`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md) |
| Taipei Professional Basketball League | Taiwan | `tpbl_` | yes | no | yes | yes | [`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md), [`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md), [`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md) |
| VTB United League | Russia | `vtb_` | yes | yes | no | yes | [`vtb_league_matches()`](https://hoopR.sportsdataverse.org/reference/vtb_league_matches.md), [`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md), [`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md) |

“no” means `hoopR` has no dedicated function for that data type in the
family, not that the league never publishes it. Coverage by season
varies by league and provider; check each function’s reference page.

## How do I get EuroLeague data?

The EuroLeague family wraps the keyless Competition Engine and live
APIs. `competition_code` is `"E"` for the EuroLeague and `"U"` for the
EuroCup, and `season_code` is the competition code plus the season’s
**start** year: `"E2025"` is the 2025-26 EuroLeague.

``` r

library(hoopR)
library(dplyr)

games <- euroleague_games(competition_code = "E", season_code = "E2025")

# game_code comes from the schedule
pbp   <- euroleague_game_pbp(game_code = 1, season_code = "E2025")
box   <- euroleague_game_boxscore(game_code = 1, season_code = "E2025")
shots <- euroleague_game_points(game_code = 1, season_code = "E2025")

# points by team from the play-by-play
pbp |>
  filter(playtype %in% c("2FGM", "3FGM", "FTM")) |>
  count(codeteam, playtype)
```

EuroLeague shot locations (`coord_x`, `coord_y`) are centimeters with
the hoop at the origin.
`sdvplotR::sdv_court_coords(shots, "coord_x", "coord_y", provider = "euroleague")`
converts them to meters on the FIBA court that
`sdvplotR::sdv_surface("fiba")` and `sportyR::geom_basketball("fiba")`
draw; see the [shot chart
article](https://hoopR.sportsdataverse.org/articles/nba-college-basketball-shot-charts.md)
for plotting.

## How do I get FIBA World Cup, Olympic and EuroBasket data?

FIBA’s data platform (GDAP) identifies each **edition** of a competition
with a `comp` id: 208182 is the 2023 World Cup, for example. The
competition shortcuts look the id up for you from an END-year `season`
(for one-year events, the event year).

``` r

# Every World Cup edition the shortcut knows about
fiba_wc_editions()

wc     <- fiba_wc_schedule(season = 2023)
wc_pbp <- fiba_wc_pbp(game_id = wc$game_id[1], season = 2023)

# The same verbs for other competitions
fiba_oly_schedule(season = 2024)
fiba_bcl_schedule(season = 2025)

# Or go through GDAP directly with a comp id
fiba_gdap_schedule(comp = 208182)
fiba_gamepage_shots(game_id = 100720, comp = 208182)
```

## How do I use the Genius Sports and Atrium platform families?

Many leagues publish through the same provider, so one family serves
them all. Genius Sports leagues are chosen with `org`; list competitions
first to find the `comp_id` of a season.

``` r

genius_competitions(org = "ESAKE")
genius_schedule(org = "CEBL", comp_id = 47852)

# Shortcuts resolve the competition for you
slb_schedule(season = 2026)        # Super League Basketball (UK)
bal_schedule(season = 2025)        # Basketball Africa League
```

Sportradar Atrium sites are chosen with `website_id` (12 is LNB France,
14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador, 22 Panama, 236
Austria, 326 Montenegro):

``` r

atrium_fixtures(website_id = 12)

# Shortcuts
lnb_schedule(season = 2026)
fixtures <- lnb_schedule(season = 2026)
lnb_pbp(fixture_id = fixtures$fixture_id[1])
```

Use [`args()`](https://rdrr.io/r/base/args.html) on any shortcut to see
its exact arguments; the identifiers each game function needs are
columns of the matching schedule function.

## Domestic league examples

Each family follows its source’s identifiers. A few starting points,
taken from the reference examples:

``` r

# Spain: Liga Endesa (ACB)
acb_matchlist(match_id = 105401)
acb_pbp(match_id = 105401)
acb_shots(match_id = 105401)

# Australia: NBL on the Rosetta API
nbl_rosetta_matches(org = "nbl", season = 2026, season_type = "regular")

# Japan, Korea, China
bleague_schedule(season = 2026, tab = 1, month = 10, day = 4)
kbl_schedule(from_date = "20251101", to_date = "20251102")
cba_schedule_month(month = 12, year = 2025)

# Italy, Lithuania, Adriatic, Turkey
lba_calendar(championship_id = 602, round = 1)
lkl_results(season = 2026)
aba_calendar(season = 2026)
tbf_schedule(competition = "bsl", season = 2027, week = 1)

# Germany, Spain (FEB), Denmark, Belgium / Netherlands
scb_games(league = "bbl")
feb_schedule(group = 1, season = 2027)
sportality_schedule(season = 2026)
sportpress_schedule(season = 2026)

# Russia, Israel, Slovenia
vtb_league_matches(league_slug = "vtb", season = 2026)
ibba_games(board_id = 5, board_round = 1, season = 2026)
kzs_matches(competition_id = 579,
            date_from = "2025-10-01T00:00:00.000Z", date_to = "2025-10-31T23:59:59.000Z")

# Canada, East Asia, Taiwan
cebl_games(season = 2025)
easl_schedule(season = 2026)
pleague_schedule(season = 2025)
tpbl_games(season = 2026)
```

## Tips for working with international feeds

- **Start from the schedule.** Game functions need the provider’s own
  game id (`match_id`, `game_code`, `gmkey`, `fixture_id`,
  `schedule_key`, …), which the schedule returns.
- **Check the season convention.** `hoopR`’s shortcuts use END-year
  seasons, but some source arguments are the source’s own codes
  (EuroLeague `season_code = "E2025"` is the season starting in 2025).
  The returned `season` column tells you which season you got.
- **Be polite.** Loop over games slowly and cache results with
  [`saveRDS()`](https://rdrr.io/r/base/readRDS.html); these are live
  websites, and several block bursts of requests or requests from cloud
  servers.
- **Some hosts are unofficial.** EASL and P. LEAGUE+ are read through
  third-party hosts, as the reference notes, and can disappear without
  notice.
- **Box-score metrics still apply.** International box scores work with
  the league-agnostic helpers
  ([`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
  [`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
  [`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md))
  once you rename columns; FIBA games are 40 minutes, so quote pace
  per 40. See the [advanced metrics
  article](https://hoopR.sportsdataverse.org/articles/basketball-advanced-metrics.md).

## Where to go next

- The reference index: [International
  Basketball](https://hoopR.sportsdataverse.org/reference/index.html#international-basketball)
  (FIBA, Genius, Atrium and every league family) and [Euroleague
  Data](https://hoopR.sportsdataverse.org/reference/index.html#euroleague-data).
- [Shot charts and court
  plots](https://hoopR.sportsdataverse.org/articles/nba-college-basketball-shot-charts.md),
  including the FIBA court.
- [Basketball advanced
  metrics](https://hoopR.sportsdataverse.org/articles/basketball-advanced-metrics.md)
  for possessions, ratings and the four factors.
- The NBA and college guides: [Getting Started with
  hoopR](https://hoopR.sportsdataverse.org/articles/getting-started-hoopR.md),
  the [NBA
  cookbook](https://hoopR.sportsdataverse.org/articles/nba-cookbook.md)
  and the [men’s college basketball
  cookbook](https://hoopR.sportsdataverse.org/articles/mbb-cookbook.md).
- The Python package
  [sportsdataverse-py](https://py.sportsdataverse.org/) mirrors many of
  these families, column for column for EuroLeague.
