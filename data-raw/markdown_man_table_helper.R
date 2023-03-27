cat(colnames(x), sep = '",\n"')
df <- data.frame(col_name = colnames(x), types = sapply(x, class))
df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE)

x %>% knitr::kable()


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
    df <- data.frame(col_name = colnames(x[[y]]), types = sapply(x[[y]], class))
    df %>% dplyr::select(col_name, types) %>% knitr::kable(row.names = FALSE) %>%
      print()
  }
})

