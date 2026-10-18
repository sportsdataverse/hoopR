# **Atrium Season Id**

**The `seasonId` of a site's season, from its END year and optionally
its competition.**

Maps through the site's own season list (`/{website_id}/fixtures`),
fetched once and cached for an hour per site.

## Usage

``` r
atrium_season_id(website_id, season, competition_id = NULL)
```

## Arguments

- website_id:

  (*integer* required): The site (12 LNB, 14 LNBP, 3 NBL1, 13 El
  Salvador, 22 Panama, 326 Montenegro). Site 236 lists no seasons.

- season:

  (*integer* required): The sdv season END year (2026 = 2025-26 on LNB;
  the calendar year on the other sites). A whole number; a string, a
  logical or a fraction is refused.

- competition_id:

  (*character* optional): The competition when the site lists several
  for that year (see
  [`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md)).
  Omit it when the year is unique.

## Value

The season's UUID (a character string), for the `season_id` argument of
every season-scoped wrapper.

## Details

Raises `hoopR_bad_request` when `season` is not a whole number, the site
is not a known Atrium site, it lists no seasons (236), or the year is
shared by several competitions and `competition_id` is missing;
`hoopR_no_data` when the site lists no such season; `hoopR_asset_fetch`
when the season list could not be fetched or is not the site's.

     atrium_season_id(14, 2026, competition_id = "16be8396-24fb-11ef-9ab7-df6be196e88f")

## See also

Other Atrium:
[`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md),
[`atrium_competition_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_player_stats.md),
[`atrium_competition_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_competition_team_stats.md),
[`atrium_end_year()`](https://hoopR.sportsdataverse.org/reference/atrium_end_year.md),
[`atrium_fixture()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture.md),
[`atrium_fixture_periods()`](https://hoopR.sportsdataverse.org/reference/atrium_fixture_periods.md),
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md),
[`atrium_fixtures_ribbon()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures_ribbon.md),
[`atrium_leaders()`](https://hoopR.sportsdataverse.org/reference/atrium_leaders.md),
[`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md),
[`atrium_player()`](https://hoopR.sportsdataverse.org/reference/atrium_player.md),
[`atrium_player_game_log()`](https://hoopR.sportsdataverse.org/reference/atrium_player_game_log.md),
[`atrium_player_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_player_seasons.md),
[`atrium_player_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_player_stats.md),
[`atrium_players()`](https://hoopR.sportsdataverse.org/reference/atrium_players.md),
[`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md),
[`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md),
[`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md),
[`atrium_standings_summary()`](https://hoopR.sportsdataverse.org/reference/atrium_standings_summary.md),
[`atrium_team()`](https://hoopR.sportsdataverse.org/reference/atrium_team.md),
[`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md),
[`atrium_team_stats()`](https://hoopR.sportsdataverse.org/reference/atrium_team_stats.md),
[`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md),
[`lmb_competition`](https://hoopR.sportsdataverse.org/reference/lmb_competition.md),
[`lnb_competition`](https://hoopR.sportsdataverse.org/reference/lnb_competition.md),
[`lnbp_competition`](https://hoopR.sportsdataverse.org/reference/lnbp_competition.md),
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md),
[`nbl1_competition`](https://hoopR.sportsdataverse.org/reference/nbl1_competition.md)
