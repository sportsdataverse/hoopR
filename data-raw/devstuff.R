library(devtools)
library(usethis)
library(desc)

unlink("DESCRIPTION")

# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "hoopRs")

#Set your name
my_desc$set("Authors@R", "person('Saiem', 'Gilani', email = 'saiem.gilani@gmail.com',role = c('aut','cre'))")

# Remove some author fields
my_desc$set("Maintainer","Saiem Gilani <saiem.gilani@gmail.com>")

# Set the version
my_desc$set_version("0.0.0.9")

# The title of your package
my_desc$set(Title = "A Scraping Interface for NBA Statistics Website")
# The description of your package
my_desc$set(Description = "The R package hoopRs is for working with NBA.com to scrape the website tables and analyze the data for themselves.")
# The urls
my_desc$set("URL", "https://saiemgilani.github.io/hoopRs, https://www.github.com/saiemgilani/hoopRs")
my_desc$set("BugReports", "http://www.github.com/saiemgilani/hoopRs/issues")
my_desc$set("SystemRequirements","ImageMagick++: ImageMagick-c++-devel (rpm) or libmagick++-dev (deb)")
my_desc$set("LinkingTo", "Rcpp")

# Save everything
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
usethis::use_mit_license(copyright_holder = "Saiem Gilani")
usethis::use_lifecycle_badge("Experimental")

# Get the dependencies
usethis::use_package("dplyr")
usethis::use_package("tidyr", min_version = "1.0.0")
usethis::use_package("stringr", min_version = "1.3.0")
usethis::use_package("stringi")
usethis::use_package("rvest", min_version = "1.0.0")
usethis::use_package("rlang")
usethis::use_package("xml2")
usethis::use_package("data.table")
usethis::use_package("httr")
usethis::use_package("glue")
usethis::use_package("jsonlite")
usethis::use_package("furrr")
usethis::use_package("future")
usethis::use_package("purrr", min_version = "0.3.0")
usethis::use_package("R",type = "Depends","3.5")
usethis::use_package("progressr", min_version = "0.6.0")
usethis::use_package("tibble", min_version = "3.0")
usethis::use_package("usethis", min_version = "1.6.0")

use_package("lubridate")
use_package("memoise")
use_package("readr")
# currently not included because of the animation packages delicate dependencies
# use_package("animation")
# use_package("magick")
# use_package("ggimage")
# use_package("png")
# use_package("av (>= 0.3)","Suggests")
# use_package("spelling","Suggests")
# use_package("jsonlite","Suggests")
# use_package("methods","Suggests")
# use_package("knitr","Suggests")
# use_package("rmarkdown","Suggests")
# use_package("rsvg","Suggests")
# use_package("webp","Suggests")
# use_package("pdftools","Suggests")
# use_package("gapminder","Suggests")
# use_package("IRdisplay","Suggests")
# use_package("tesseract (>= 2.0)","Suggests")
# use_package("gifski","Suggests")

# currently not included because of the animation packages delicate dependencies
# usethis::use_vignette("intro-to-kenpomR")

# Clean your description
usethis::use_tidy_description()
usethis::use_news_md()
usethis::use_github_links()
usethis::use_readme_rmd()
usethis::use_github_action_check_release()
