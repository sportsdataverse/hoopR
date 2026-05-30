# tools/example_runs/ — live-API smoke-test harness

Mirrors the wehoop harness at `c:/Users/saiem/Documents/GitHub-Data/sdv-dev/wehoop-dev/wehoop/tools/example_runs/`. The point is to surface empty / NULL / 404 / schema-drift regressions in ESPN wrappers *without* running them in `R CMD check` (those tests use `skip_on_ci()` to keep CI fast and avoid rate-limit flake).

## Workflow

```sh
# 1. Generate per-function example scripts from man/*.Rd \donttest{} blocks
Rscript tools/extract_examples.R                       # default pattern: espn_(nba|mbb)_
# or: Rscript tools/extract_examples.R "espn_nba_" tools/example_runs

# 2. Run all extracted scripts; produces tools/example_runs/_results.csv + output/*.log
Rscript tools/run_examples.R

# 3. After triaging, edit tools/rerun_failures.R `fails` vector and rerun just those
Rscript tools/rerun_failures.R
```

## Outputs

- `_manifest.csv` — `name,file` of every extracted script
- `_results.csv` — `name,status,summary,duration_s` per run (committed as baseline)
- `output/<name>.log` — raw stdout+stderr per script (gitignored)
- `TRIAGE.md` — root-cause categorization after each batch run

Each per-function script is a small wrapper around the `\donttest{}` block from the function's roxygen example, plus a `---RESULT---` marker the runner parses to classify outputs:

- `OK` — non-empty result returned
- `EMPTY` — `dim: 0 x 0` data.frame or zero-element list
- `ERROR` — script exit code != 0
- `TIMEOUT` — 90s timeout exceeded

## Categorization (for TRIAGE.md)

Use the same A-G categories wehoop established in its TRIAGE.md (see `c:/.../wehoop/tools/example_runs/TRIAGE.md`):

| Category | Meaning |
|----------|---------|
| **A** | Wrong wrapper URL (true bug, fix in source) |
| **B** | Wrapper extraction key drifted (true bug) |
| **C** | Wrapper logic mismatched to endpoint shape (true bug) |
| **D** | Stale example data (athlete_id / game_id, example bug not wrapper bug) |
| **E** | Endpoint removed by ESPN (no fix possible from our side) |
| **F** | Off-season empty (not bug — ESPN really has no data right now) |
| **G** | ESPN data limitation (not a wrapper bug) |

## CI integration (future)

This harness is currently manual. The cross-package audit at `tools/docs/espn_rectangularization_audit.md` recommends baking `run_examples.R` into a scheduled GitHub Actions workflow that diffs the resulting `_results.csv` against the committed baseline and posts a PR comment when statuses change. See that doc's "CI coverage gap" section.

## Why not just use the testthat tests?

Most ESPN testthat tests use `skip_on_ci()` so they don't run on push CI. This harness deliberately runs the actual `\donttest{}` examples to exercise the live API without going through testthat's skip-guard infrastructure. It complements rather than replaces the testthat suite — the testthat tests verify column schemas when they do run, this harness verifies the wrappers haven't started silently returning empty/NULL.

## Bootstrap

1. `tools/example_runs/` is initially empty except for this README + the TRIAGE template.
2. Run `tools/extract_examples.R` to populate the manifest + per-function scripts (one per matched `man/*.Rd`).
3. Run `tools/run_examples.R` to produce the baseline `_results.csv`.
4. Commit `_manifest.csv`, `_results.csv`, and the per-function `.R` scripts. Do NOT commit `output/` (gitignore it).
