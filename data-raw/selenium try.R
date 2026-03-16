library(RSelenium)
library(rvest)
library(dplyr)
library(janitor)

# Launch Chrome in headless mode
rD <- rsDriver(
  chromever =
  browser = "chrome",
  port = 4445L,  # You can set this manually if needed
  extraCapabilities = list(
    chromeOptions = list(
      args = c('--headless', '--disable-gpu', '--window-size=1280,800', '--no-sandbox')
    )
  )
)

remDr <- rD$client

remDr$open()
remDr$navigate("https://kenpom.com/")

# Wait a few seconds to let page load fully
Sys.sleep(3)

# Grab rendered HTML
page_source <- remDr$getPageSource()[[1]]
html <- read_html(page_source)

# Extract the first table (main rankings)
rankings <- html %>%
  html_element("table") %>%
  html_table()

# Clean and format the table
rankings_clean <- rankings %>%
  clean_names() %>%
  filter(!is.na(adjem))  # Filter out non-data rows

# View output
print(head(rankings_clean))

# Shutdown browser
remDr$close()
rD$server$stop()
