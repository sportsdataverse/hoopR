# Live tests of the international basketball families (R/intl_basketball_*.R and
# the per-league files) hit third-party hosts politely (>= 1 s per host). They run
# only with HOOPR_INTL_LIVE_TESTS=1, never on CRAN. Genius and CBA live tests also
# need GENIUS_PROXY / CBA_PROXY (datacenter IPs are refused); skip those with
# skip_intl_live("GENIUS_PROXY").
skip_intl_live <- function(proxy_env = NULL) {
  testthat::skip_on_cran()
  if (Sys.getenv("HOOPR_INTL_LIVE_TESTS") != "1") {
    testthat::skip("International basketball live tests are off (set HOOPR_INTL_LIVE_TESTS=1)")
  }
  if (!is.null(proxy_env) && !nzchar(trimws(Sys.getenv(proxy_env)))) {
    testthat::skip(paste0("International basketball live test needs ", proxy_env, " set"))
  }
  invisible()
}
