skip_kenpom_test <- function(){
  if(Sys.getenv("KP_USER") == ''){
    skip("User can't run KenPom tests")
  } else {
    invisible()
  }
}

skip_espn_test <- function(){
  if(Sys.getenv("ESPN_TESTS") != "1"){
    skip("User can't run ESPN tests")
  } else {
    invisible()
  }
}

skip_nba_stats_test <- function(){
  if(Sys.getenv("NBA_STATS_TESTS") != "1"){
    skip("User can't run NBA Stats tests")
  } else {
    invisible()
  }
}

skip_nbagl_stats_test <- function(){
  if(Sys.getenv("NBAGL_STATS_TESTS") != "1"){
    skip("User can't run NBA G-League Stats tests")
  } else {
    invisible()
  }
}

skip_ncaa_mbb_test <- function(){
  if(Sys.getenv("NCAA_MBB_TESTS") != "1"){
    skip("User can't run NCAA MBB tests")
  } else {
    invisible()
  }
}

skip_ncaa_wbb_test <- function(){
  if(Sys.getenv("NCAA_WBB_TESTS") != "1"){
    skip("User can't run NCAA WBB tests")
  } else {
    invisible()
  }
}

skip_cbbd_test <- function(){
  if(Sys.getenv("CBBD_API_KEY") == ''){
    skip("User can't run CollegeBasketballData tests (CBBD_API_KEY not set)")
  } else {
    invisible()
  }
}

skip_bref_test <- function(){
  if(Sys.getenv("BREF_TESTS") != "1"){
    skip("User can't run Basketball-Reference tests (BREF_TESTS not set; site is rate-limited)")
  } else {
    invisible()
  }
}

skip_load_test <- function(){
  if(Sys.getenv("HOOPR_LOAD_TESTS") != "1"){
    skip("User can't run hoopR load_* tests")
  } else {
    invisible()
  }
}

skip_realgm_test <- function(){
  if(Sys.getenv("REALGM_TESTS") != "1"){
    skip("User can't run RealGM tests (REALGM_TESTS not set; needs chromote + Google Chrome)")
  } else if(!requireNamespace("chromote", quietly = TRUE)){
    skip("User can't run RealGM tests (chromote not installed)")
  } else {
    invisible()
  }
}
