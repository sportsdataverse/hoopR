library(devtools)
library(usethis)
library(desc)

unlink("DESCRIPTION")

# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "kenpomR")

#Set your name
my_desc$set("Authors@R", "person('Saiem', 'Gilani', email = 'saiem.gilani@gmail.com',role = c('aut','cre'))")

# Remove some author fields
my_desc$set("Maintainer","Saiem Gilani <saiem.gilani@gmail.com>")

# Set the version
my_desc$set_version("0.0.0.9")

# The title of your package
my_desc$set(Title = "A Scraping Interface for Ken Pomeroy's College Basketball Statistics Website")
# The description of your package
my_desc$set(Description = "The R package kenpomR is for working with Ken Pomeroy's college basketball data. It provides users with an active subscription and login the capability to scrape the website tables and analyze the data for themselves.")
# The urls
my_desc$set("URL", "https://saiemgilani.github.io/kenpomR (website) https://www.github.com/saiemgilani/kenpomR (devel)")
my_desc$set("BugReports", "http://www.github.com/saiemgilani/kenpomR/issues")
my_desc$set("SystemRequirements","ImageMagick++: ImageMagick-c++-devel (rpm) or libmagick++-dev (deb)")
my_desc$set("LinkingTo", "Rcpp")

# Save everything
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
use_mit_license(name = "Saiem Gilani")
use_code_of_conduct()
use_lifecycle_badge("Experimental")

# Get the dependencies
use_package("dplyr")
use_package("tidyr")
use_package("stringr")
use_package("stringi")
use_package("rvest")
use_package("rlang")
use_package("xml2")
use_package("data.table")
use_package("assertthat")
use_package("httr")
use_package("curl")
use_package("attempt")
use_package("magrittr")
use_package("glue")
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
use_tidy_description()
use_news_md()
use_github_links()
