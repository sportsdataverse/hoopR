# NBL Rosetta fixtures

Provenance: sdv-py `origin/main` at `e3d232ebc9bf9e9f98225666a67707b8e554f9b7`.

Captured 2026-10-12 from `prod.rosetta.nbl.com.au` (the `fetched` stamp of every body), except
`live_full--nbl_2025.json`, fetched 2026-10-13.

* `*.json`: the sdv-py captures of `prod.rosetta.nbl.com.au/get` (sdv-internal-refs `nbl-rosetta/`),
  copied byte for byte and renamed short (`<endpoint>--<org>[_<Rosetta year>].json`) so paths stay
  under R CMD check's 100-character limit. Source paths, under `tests/fixtures/nbl_rosetta/`:

| hoopR fixture | sdv-py fixture |
|:---|:---|
| `live_full--nbl_2025.json` | `full/match__match_id__live__all--nbl_2025.json` |
| `match_by_id--nbl_2025.json` | `match__match_id--nbl_2025.json` |
| `live--nbl1_2025.json` | `match__match_id__live__all--nbl1_2025.json` |
| `live--nbl_1979.json` | `match__match_id__live__all--nbl_1979.json` |
| `live--nbl_2011.json` | `match__match_id__live__all--nbl_2011.json` |
| `live--nbl_2015.json` | `match__match_id__live__all--nbl_2015.json` |
| `live--nbl_2025.json` | `match__match_id__live__all--nbl_2025.json` |
| `live--wnbl_2014.json` | `match__match_id__live__all--wnbl_2014.json` |
| `live--wnbl_2025.json` | `match__match_id__live__all--wnbl_2025.json` |
| `outcomes--nbl1_2025.json` | `match__outcomes__for__org__teams__in__season__year__type--nbl1_2025.json` |
| `outcomes--nbl_2025.json` | `match__outcomes__for__org__teams__in__season__year__type--nbl_2025.json` |
| `outcomes--wnbl_2025.json` | `match__outcomes__for__org__teams__in__season__year__type--wnbl_2025.json` |
| `next_match--nbl_2026.json` | `next__match__for__org__year--nbl_2026.json` |
| `next_match--wnbl_2026.json` | `next__match__for__org__year--wnbl_2026.json` |
| `next_match_team--nbl_2026.json` | `next__match__for__team__team_code__org__year--nbl_2026.json` |
| `next_matches--nbl_2026.json` | `next__matches__for__teams__in__org__year--nbl_2026.json` |
| `next_matches--wnbl_2026.json` | `next__matches__for__teams__in__org__year--wnbl_2026.json` |
| `matches--nbl1_2025.json` | `org__matches__in__season__year__type--nbl1_2025.json` |
| `matches--nbl_1979.json` | `org__matches__in__season__year__type--nbl_1979.json` |
| `matches--nbl_2011.json` | `org__matches__in__season__year__type--nbl_2011.json` |
| `matches--nbl_2015.json` | `org__matches__in__season__year__type--nbl_2015.json` |
| `matches--nbl_2025.json` | `org__matches__in__season__year__type--nbl_2025.json` |
| `matches--wnbl_2014.json` | `org__matches__in__season__year__type--wnbl_2014.json` |
| `matches--wnbl_2025.json` | `org__matches__in__season__year__type--wnbl_2025.json` |
| `player_game_log--nbl1_2025.json` | `org__player_boxscores__for__player_id__in__season__year__regular--nbl1_2025.json` |
| `player_game_log--nbl_2025.json` | `org__player_boxscores__for__player_id__in__season__year__regular--nbl_2025.json` |
| `player_game_log--wnbl_2025.json` | `org__player_boxscores__for__player_id__in__season__year__regular--wnbl_2025.json` |
| `team_players--nbl1_2025.json` | `org__players__for__team__team_id__in__season__year--nbl1_2025.json` |
| `team_players--nbl_2025.json` | `org__players__for__team__team_id__in__season__year--nbl_2025.json` |
| `team_players--wnbl_2025.json` | `org__players__for__team__team_id__in__season__year--wnbl_2025.json` |
| `players--nbl1_2025.json` | `org__players__in__season__year--nbl1_2025.json` |
| `players--nbl_2015.json` | `org__players__in__season__year--nbl_2015.json` |
| `players--nbl_2025.json` | `org__players__in__season__year--nbl_2025.json` |
| `players--wnbl_2014.json` | `org__players__in__season__year--wnbl_2014.json` |
| `players--wnbl_2025.json` | `org__players__in__season__year--wnbl_2025.json` |
| `seasons--nbl.json` | `org__seasons--nbl.json` |
| `seasons--nbl1.json` | `org__seasons--nbl1.json` |
| `seasons--wnbl.json` | `org__seasons--wnbl.json` |
| `seasons_current--nbl.json` | `org__seasons__current--nbl.json` |
| `seasons_current--wnbl.json` | `org__seasons__current--wnbl.json` |
| `standings--nbl1_2025.json` | `org__standings__year__regular--nbl1_2025.json` |
| `standings--nbl_1979.json` | `org__standings__year__regular--nbl_1979.json` |
| `standings--nbl_2015.json` | `org__standings__year__regular--nbl_2015.json` |
| `standings--nbl_2025.json` | `org__standings__year__regular--nbl_2025.json` |
| `standings--wnbl_2014.json` | `org__standings__year__regular--wnbl_2014.json` |
| `standings--wnbl_2025.json` | `org__standings__year__regular--wnbl_2025.json` |
| `player_stats--nbl.json` | `org__statistics__for__player__player_id--nbl.json` |
| `player_stats--nbl1.json` | `org__statistics__for__player__player_id--nbl1.json` |
| `player_stats--wnbl.json` | `org__statistics__for__player__player_id--wnbl.json` |
| `stats_leaders--nbl1_2025.json` | `org__stats__leaders__for__season__id__season_id--nbl1_2025.json` |
| `stats_leaders--nbl_2025.json` | `org__stats__leaders__for__season__id__season_id--nbl_2025.json` |
| `stats_leaders--wnbl_2025.json` | `org__stats__leaders__for__season__id__season_id--wnbl_2025.json` |
| `team_stats_leaders--nbl_2025.json` | `org__stats__leaders__for__season__id__season_id__team__team_code--nbl_2025.json` |
| `team_stats_leaders--wnbl_2025.json` | `org__stats__leaders__for__season__id__season_id__team__team_code--wnbl_2025.json` |
| `team_stats--nbl1_2025.json` | `org__team__stats__for__season__year__regular--nbl1_2025.json` |
| `team_stats--nbl_2025.json` | `org__team__stats__for__season__year__regular--nbl_2025.json` |
| `team_stats--wnbl_2025.json` | `org__team__stats__for__season__year__regular--wnbl_2025.json` |
| `teams--nbl.json` | `org__teams--nbl.json` |
| `teams--nbl1.json` | `org__teams--nbl1.json` |
| `teams--wnbl.json` | `org__teams--wnbl.json` |

* `parity/<endpoint>--<fixture>.csv`: the frame sdv-py's `nbl_rosetta_<endpoint>()` returns on that
  fixture (transport mocked, so the request stamp is the runtime's own), written with polars'
  default `write_csv()` (a null is an empty field, `""` a quoted one, so a literal "NA" stays a value; read
  with `intl_read_oracle()` of `helper-intl.R`). The CSVs were regenerated that way on sdv-py `38a22f936d`
  (2026-10-18; e3d232ebc9 wrote `null_value = "NA"`): same frames, only the null marker changed. `parity/parity.json` holds, per frame, the wrapper arguments, the
  URL and query sdv-py sent, the polars dtypes in column order and the row count.
  `test-nbl_rosetta.R` compares names (in order), dtypes and every cell, counting NA-vs-value as a
  mismatch, and the request path and query.

Regenerate both (after sdv-py re-captures the family) by running sdv-py's wrappers with
`/mnt/sdv_repos/sdv-py/.venv/bin/python` against a `git worktree` of sdv-py `origin/main`; refresh
`R/nbl_rosetta_schema.R` (DTYPES + returns-schemas) from the same SHA.
