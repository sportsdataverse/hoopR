# NBA Possession Engine Test Fixtures

## Provenance

These fixtures feed the offline possession-engine tests (`tests/testthat/test-nba_possessions.R`).
All captures made 2026-06-29 via `nba_pbp()` and `nba_boxscoretraditionalv3()` (R 4.5.3, hoopR 3.1.0).

## Files

### Game 0022200001 — Boston Celtics vs Philadelphia 76ers (2022-10-18, Season opener)

| File | Source function | Description |
|---|---|---|
| `pbp_0022200001.rds` | `nba_pbp("0022200001", on_court=TRUE, version="v3")` | 446 events, 73 cols, V2-formatted frame |
| `box_0022200001.rds` | `nba_boxscoretraditionalv3("0022200001")` | 8-table list: home/away player + team totals |

**Boxscore oracle targets (possession-points gate must match):**
- Home: Boston Celtics (team_id=1610612738) = **126 points**
- Away: Philadelphia 76ers (team_id=1610612755) = **117 points**

Cross-referenced against sdv-py fixture at
`tests/fixtures/nba_engine/0022200001/boxscoretraditionalv3.json` — identical values confirmed.

### Game 0022300001 — Indiana Pacers vs Cleveland Cavaliers (2023-10-24, Season opener)

| File | Source function | Description |
|---|---|---|
| `pbp_0022300001.rds` | `nba_pbp("0022300001", on_court=TRUE, version="v3")` | 473 events, 73 cols, V2-formatted frame |
| `box_0022300001.rds` | `nba_boxscoretraditionalv3("0022300001")` | 8-table list: home/away player + team totals |

**Boxscore oracle targets:**
- Home: Indiana Pacers = **121 points**
- Away: Cleveland Cavaliers = **116 points**

## Column Schema Notes

`nba_pbp(..., version="v3")` emits a **V2-FORMATTED** frame (the `.v3_to_v2_format()` conversion pipeline
runs inside `nba_pbp`). The critical columns for the possession engine:

| Column | Type | Notes for possession engine |
|---|---|---|
| `event_type` | character | V2 EVENTMSGTYPE codes as strings: "1"=Made Shot, "2"=Missed Shot, "3"=FreeThrow, "4"=Rebound, "5"=Turnover, "6"=Foul, "8"=Sub, "12"=StartPeriod, "13"=EndPeriod |
| `event_action_type` | character | V2 EVENTMSGACTIONTYPE codes as strings — **this is the "last FT" signal** |
| `action_type` | character | V3 label preserved: "Made Shot", "Missed Shot", "Free Throw", "Rebound", "Turnover", etc. |
| `sub_type` | character | V3 sub-type preserved: "Free Throw 1 of 1", "Free Throw 2 of 2", etc. — **ALSO usable for "last FT" detection** |
| `shot_result` | character | "Made" / "Missed" (V3 passthrough) |
| `location` | character | "h" = home, "v" = visitor (away) |
| `team_id` | integer | Team that owns this event |
| `home_score` | numeric | Running home score (forward-filled) |
| `away_score` | numeric | Running away score (forward-filled) |
| `away_player1..5` | numeric | Away on-court player IDs (from `nba_gamerotation` stints) |
| `home_player1..5` | numeric | Home on-court player IDs |

## "Last FT of Trip" Detection

**TWO equivalent signals are available in the hoopR frame:**

1. **`sub_type` column** (preferred — same signal as sdv-py uses): `"Free Throw N of N"` pattern,
   where both N values are equal (e.g. `"Free Throw 1 of 1"`, `"Free Throw 2 of 2"`,
   `"Free Throw 3 of 3"`, `"Free Throw Flagrant 3 of 3"`). Technical FTs (`"Free Throw Technical"`)
   do NOT end a possession.

2. **`event_action_type` codes** (V2 numeric-as-string): last-FT codes are
   `"10"` (1of1), `"12"` (2of2), `"15"` (3of3), `"19"` (Flagrant 2of2), `"20"` (Flagrant 1of1),
   `"26"` (ClearPath 2of2), `"29"` (Flagrant 3of3).

The port should use `sub_type` matching (same logic as `_is_last_ft()` in sdv-py's
`nba_possessions.py`) since both `sub_type` and `action_type` are preserved V3 passthrough columns.
