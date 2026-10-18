# zzz_genius_competitions.R -- mint the Genius competition aliases (R/genius_competitions.R).
# Sorted last on purpose: R sources R/ in C-locale order (no Collate field), so the competition
# registry (R/intl_basketball_competitions.R) is defined by the time this runs.
.genius_mint_aliases(environment())
