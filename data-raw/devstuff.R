library(devtools)
library(usethis)
library(desc)

unlink("DESCRIPTION")

# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "kenpomR")
#Set your name
my_desc$set("Author", "Saiem Gilani <saiem.gilani@gmail.com>")

#Set your name
my_desc$set("Authors@R", "person('Saiem', 'Gilani', email = 'saiem.gilani@gmail.com',role = c('aut','cre'))")

# Remove some author fields
my_desc$set("Maintainer","Saiem Gilani <saiem.gilani@gmail.com>")

# Set the version
my_desc$set_version("0.0.0.9")

# The title of your package
my_desc$set(Title = "A Scraping Interface for Ken Pomeroy's College Basketball Statistics Website")
# The description of your package
my_desc$set(Description = "The R package kenpomR(oy) is for working with KenPom's college basketball data. A Scraping interface for Ken Pomeroy's college basketball statistics website, kenpom.com. It provides users with an active subscription and login the capability to scrape the website tables and analyze the data for themselves.")
# The urls
my_desc$set("URL", "http://www.github.com/saiemgilani/kenpomR")
my_desc$set("BugReports", "http://www.github.com/saiemgilani/kenpomR/issues")
# Save everyting

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


# Clean your description
use_tidy_description()
use_news_md()
use_github_links()
