cat(colnames(x), sep = '",\n"')
df <- data.frame(col_name = colnames(x), types = sapply(x, function(y){class(y)[1]}))
df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE)

x %>% knitr::kable()

testy <- function(func) {
  # Extract the parameters of the given function
  params <- formals(func)

  # Loop through each parameter and assign it to the global environment
  for (param_name in names(params)) {
    # Use 'assign' to put each parameter in the global environment
    assign(param_name, eval(params[[param_name]]), envir = .GlobalEnv)
  }

  cat("Parameters have been assigned to the global environment.\n")
}

## NBA Stats Tests Helper
purrr::walk(names(x), function(y){

  print(glue::glue("\n\n {y} \n\n"))
  # cat('c(\n"')
  cat(colnames(x[[y]]), sep = '",\n"')
  # cat('\n')
  # cat('\n')
})

cat(names(x), sep = ', ')
## NBA Stats Roxygen Docs Helper
purrr::walk(names(x), function(y){

  print(glue::glue("\n\n **{y}** "))
  if (length(x[[y]]) > 0) {
    df <- data.frame(col_name = colnames(x[[y]]), types = sapply(x[[y]], function(y){class(y)[1]}))
    df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE) %>%
      print()
  }
})

