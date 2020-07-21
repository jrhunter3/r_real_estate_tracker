library('tidyverse')
library('rvest')
library('httr')
options(scipen = 999, stringsAsFactors = F)

# BOT IS BLOCKED; JUST DOWNLOAD BY HAND
# user_agent_list <- read_rds('data/user_agent_list.RDS')
# url <- 'https://www.zillow.com/search/GetSearchPageState.htm?searchQueryState={"pagination":{},"mapBounds":{"west":-88.7945947265625,"east":-84.1254052734375,"south":36.44328475453152,"north":37.605434111722595},"isMapVisible":true,"mapZoom":8,"filterState":{"sort":{"value":"globalrelevanceex"}},"isListVisible":true}'
# s <- html_session(url, user_agent = user_agent(sample(user_agent_list, size=1)))
# html_text(html_nodes(s, xpath = "//*"))

json <- jsonlite::fromJSON('data/zillow_local.json')

for_sale_houses <- test$searchResults$mapResults
for_sale_houses <- jsonlite::flatten(for_sale_houses, recursive = T)

glimpse(for_sale_houses)

for_sale_houses %>%
  group_by(hdpData.homeInfo.zipcode) %>%
  summarize(listed_homes = n(),
            mean_price = mean(hdpData.homeInfo.price, na.rm = T)) %>%
  arrange(mean_price)

for_sale_houses %>%
  filter(is.na(hdpData.homeInfo.zipcode)) %>%
  View()
