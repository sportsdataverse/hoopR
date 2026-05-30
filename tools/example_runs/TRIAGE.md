# ESPN example triage — TEMPLATE

Update the date and batch result after each `tools/run_examples.R` run.

## Batch result

`N examples run, M classified EMPTY + K silently-failing (NULL return), all others OK.`

## Failures grouped by root cause

### A. Wrong wrapper URL (true bugs, fix in source)

| Function(s) | Current URL | Fix |
|---|---|---|
| ... | ... | ... |

### B. Wrapper extraction key drifted (true bug)

| Function(s) | Issue | Fix |
|---|---|---|
| ... | ... | ... |

### C. Wrapper logic mismatched to endpoint shape (true bug)

| Function | Issue | Fix |
|---|---|---|
| ... | ... | ... |

### D. Stale example data (example bug, not wrapper bug)

Example: athlete_id `X` (player who graduated to pros) → replace with current player `Y`.

| Fix | ... |

### E. Endpoint removed by ESPN (no fix possible from our side)

| Function | Status |
|---|---|
| ... | ... |

### F. Off-season empty (NOT bugs — ESPN really has no data right now)

Today is `<date>`; relevant calendar context:

- `function_a` → ESPN returns `field:[]`
- `function_b` → ESPN returns `{}`

Wrappers handle these correctly. No code change needed; example output is just empty.

### G. ESPN data limitation (NOT a wrapper bug)

- `function_c`: ESPN returns `events: null` for every athlete sampled. The endpoint exists but is unpopulated for this surface.

## Fixes applied

| File | Change |
|---|---|
| `R/...` | ... |
