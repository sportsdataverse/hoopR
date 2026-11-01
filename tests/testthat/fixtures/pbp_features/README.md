# Play-feature parity fixtures

sportsdataverse-py's clock / period / timeout columns for `tests/testthat/test-espn_pbp_features.R`:
`<name>.csv` is `espn_<lg>_pbp()` (the release frame) run on `../score_repair/<name>.json.gz`, the same
real ESPN summary bytes `helper_espn_<lg>_pbp()` reads in the test, keyed by `row` (1-based array
position) and `sequence_number`. Never hand-edit: regenerate with the maintainer script
`ClaudeCowork/scripts/score-repair-r/write_pbp_features.py` (private repo) from a sportsdataverse-py
checkout. Written from sportsdataverse-py @ 4b78a45a3daa8976837e32f826d4570bb394e016.
