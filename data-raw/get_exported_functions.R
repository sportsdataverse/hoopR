library(pkgapi)
library(tidyverse)
pacman::p_load_current_gh("r-lib/pkgapi")
pkg <- pkgapi::map_package()
function_calls <- pkg$calls
exported <- pkg$defs %>%
  dplyr::filter(exported == TRUE) %>%
  dplyr::select(all_of(c("name", "file")))

nba_functions <- exported %>%
  dplyr::filter(stringr::str_detect(.data$name,pattern = "^nba*"))

nba_function_parameters <- purrr::map(nba_functions$name, function(x){
  data.frame(param = names(as.list(args(x))), function_name = x)
}) %>%
  purrr::list_rbind()

nba_function_parameters_raw <- nba_function_parameters %>%
  dplyr::select("param") %>%
  dplyr::distinct()

write.csv(nba_function_parameters_raw, "data-raw/hoopR_nba_stats_params.csv", row.names = F)

## --- Exported functions ---
exported %>%
  knitr::kable()
## --- hoopR calls ---
self_calls <- function_calls %>%
  dplyr::filter(stringr::str_detect(.data$to,"hoopR::"))
self_calls %>%
  knitr::kable()

pkg_usage_summary <- function_calls %>%
  dplyr::mutate(
    package_called = stringr::str_extract(string = .data$to, ".+(?=::)")) %>%
  dplyr::group_by(.data$package_called) %>%
  dplyr::summarize(n = dplyr::n()) %>%
  dplyr::arrange(dplyr::desc(.data$n))

write.csv(exported,"data-raw/hoopR_exported_functions.csv",row.names=F)

new_nba <- exported %>%
  dplyr::filter(stringr::str_starts(.data$name,"nba_"))
print(nrow(new_nba))
new_nba %>%
  knitr::kable()

