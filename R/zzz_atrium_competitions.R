# zzz_atrium_competitions.R -- mint the per-site Atrium aliases (lnb_*, lnbp_*, ...).
# R sources R/ in C-locale order with no Collate field, so this file runs after
# intl_basketball_competitions.R (the registry) and atrium*.R (the minter and bases).
.atrium_mint_aliases(environment())
