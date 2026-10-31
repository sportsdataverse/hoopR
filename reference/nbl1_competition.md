# **NBL1 (Australia) (Atrium shortcuts)**

**Per-competition shortcuts over the Atrium embed API for NBL1
(Australia) (`website_id = 3`; men's and women's).**

Thin bindings of the parameterised `atrium_*()` wrappers to this site,
minted from the competition registry shared with sportsdataverse-py; the
full surface stays on the `atrium_*()` wrappers.

## Usage

``` r
nbl1_seasons(locale = NULL)
nbl1_schedule(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_standings(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_teams(season = NULL, season_id = NULL, competition_id = NULL, locale = NULL)
nbl1_player_box(fixture_id, locale = NULL)
nbl1_team_box(fixture_id, locale = NULL)
nbl1_pbp(fixture_id, locale = NULL)
nbl1_shots(fixture_id, locale = NULL)
```

## Arguments

- season:

  (*integer* optional): Season END year (season rule below). Omit
  `season` and `season_id` for the site's current season.

- season_id:

  (*character* optional): Season UUID (`season_id` in the seasons
  listing); skips the END-year lookup.

- competition_id:

  (*character* optional): Competition UUID (a site carries many:
  conferences, cups); needed when several share the season.

- locale:

  (*character* optional): Label locale, e.g. `"en-EN"`; omitted = the
  site's own language.

- fixture_id:

  (*character* required): Fixture UUID (`fixture_id` in the schedule).

## Value

A `hoopR_data` tibble with the columns of the base wrapper of each
function:

- `nbl1_seasons()`: the columns of
  [`atrium_seasons()`](https://hoopR.sportsdataverse.org/reference/atrium_seasons.md).

- `nbl1_schedule()`: the columns of
  [`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md).

- `nbl1_standings()`: the columns of
  [`atrium_standings()`](https://hoopR.sportsdataverse.org/reference/atrium_standings.md).

- `nbl1_teams()`: the columns of
  [`atrium_teams()`](https://hoopR.sportsdataverse.org/reference/atrium_teams.md).

- `nbl1_player_box()`: the columns of
  [`atrium_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_box_score.md).

- `nbl1_team_box()`: the columns of
  [`atrium_team_box_score()`](https://hoopR.sportsdataverse.org/reference/atrium_team_box_score.md).

- `nbl1_pbp()`: the columns of
  [`atrium_pbp()`](https://hoopR.sportsdataverse.org/reference/atrium_pbp.md).

- `nbl1_shots()`: the columns of
  [`atrium_shots()`](https://hoopR.sportsdataverse.org/reference/atrium_shots.md).

## Details

Season rule: calendar year, Mar-Aug (END year); conferences are
competition_ids.

Errors and terms of use are those of
[`atrium_fixtures()`](https://hoopR.sportsdataverse.org/reference/atrium_fixtures.md):
unofficial use of the public widget endpoint, at least 1 s between
requests (check the site's terms before you republish the data). The
site also serves women's competitions (pass their `competition_id`).

     nbl1_seasons()
     nbl1_schedule()

## See also

Other Atrium Functions:
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
[`atrium_season_id()`](https://hoopR.sportsdataverse.org/reference/atrium_season_id.md),
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
[`lpb_competition`](https://hoopR.sportsdataverse.org/reference/lpb_competition.md)
