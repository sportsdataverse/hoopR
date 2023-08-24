skip_kenpom_test <- function(){
  if(Sys.getenv("KP_USER") == ''){
    skip("User can't run KenPom tests")
  } else {
    invisible()
  }
}
