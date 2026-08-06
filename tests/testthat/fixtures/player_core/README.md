# player_core parity fixtures

Golden-master oracle for `espn_basketball_player_core()`, captured from the
Python implementation that currently produces the released `player_core`
dataset. The R function is a port; these files are what it must reproduce.

## Provenance

| | |
|---|---|
| Oracle function | `sportsdataverse.nba.helper_nba_player_core` |
| sdv-py version | `0.0.75` |
| Captured | 2026-08-03 |
| Payload source | `hoopR-nba-raw/nba/player_core/json/{athlete_id}.json` (committed raw tree, unmodified) |
| Capture command | `helper_nba_player_core(json.load(f), athlete_id=<id>)` per payload, `pl.concat`, `write_csv` |

## Files

- `10.json`, `1000.json`, `1011.json` — ESPN core-v2 athlete payloads, copied
  **unmodified** from the raw tree (git may normalise line endings on commit;
  the parsed JSON was verified `identical()` to the raw-tree originals). Not
  hand-written: a hand-made payload is the failure mode this fixture exists to
  avoid — three Savant parsers shipped wrong against synthetic fixtures.
- `expected_player_core.csv` — the oracle. 3 rows x 35 columns.

## Why these three athletes

They are not a random sample; each covers a branch of the projection:

| athlete | covers |
|---|---|
| `1000` Brendan Haywood | college **and** draft present — the fully-populated path |
| `1011` Raul Lopez | **no college** — `college_id` must be NA, not 0 or an error |
| `10` Malik Allen | college but **no draft** — `draft_year/round/selection` all NA |

No payload in the 2,577-file tree has fewer than 12 keys, so there is no
"sparse" real case to capture; the empty/non-dict input path is covered by a
unit assertion in the test rather than a fixture.

## Column contract

35 columns, dtypes as the released dataset:

- `athlete_id` — **Int64**, the join key into `player_box` /
  `player_season_stats`. Never a float-origin string (`"123.0"`).
- `age`, `position_id`, `college_id`, `current_team_id`, `experience_years`,
  `status_id`, `draft_year`, `draft_round`, `draft_selection` — Int32.
- `height`, `weight` — Float64.
- `active` — logical.
- everything else — character.

Nulls serialize as **empty cells** (not `NA`/`NaN` text), so
`readr::read_csv()` reads them as `NA` of the column type.

## Semantics worth not re-deriving

`current_team_id` is the athlete's team **today**, not their team in any past
season, and height/weight/jersey are a current snapshot — ESPN overwrites them
in place, so era-correct bio is not obtainable from this endpoint. The season
dimension of the released dataset is *participation* (who appeared in season Y,
from `player_box`), not the bio's vintage.

Ids come from parsing the `$ref` URL (`/colleges/{id}`, `/teams/{id}`) — the
port must **never fetch** the ref.

## Refreshing

Re-capture only when the Python oracle changes deliberately. Re-copy the
payloads from the raw tree in the same pass — a refreshed oracle against stale
payloads is worse than no oracle.
