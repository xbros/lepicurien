# install.packages(c("tidyr", "dplyr"))

#' # load packages
library(tidyr)
library(dplyr)

#' # read wordpress data
wp <- tbl_df(read.csv("export_product-2016_10_24-17_49_21.csv", 
                      sep=";", na.strings = "", 
                      stringsAsFactors = FALSE, 
                      check.names = FALSE))
#' # read pos data
pos <- tbl_df(read.csv("phppos_items.csv", 
                       na.strings="NULL",
                       stringsAsFactors = FALSE, 
                       check.names = FALSE))

#' # process pos
pos2 = pos %>% 
  filter(!is.na(www_link)) %>% 
  separate(www_link, c("www_link_base", "Product ID"), sep = "&p=", remove = FALSE) %>% 
  select(-www_link_base) %>% 
  filter(!is.na(`Product ID`)) %>% 
  mutate(`Product ID` = as.integer(`Product ID`))

tab = table(pos2$www_link)
dupl = names(tab)[tab>1]

pos2 = pos2 %>% 
  filter(!(www_link %in% dupl))

#' # join
wp2 = wp %>% 
  inner_join(pos2, by="Product ID") %>% 
  mutate(`Product SKU` = item_id)

wp2 = wp2 %>% 
  select(`Product ID`, `Product SKU`)

#' # write data
write.csv(wp2, file = "wp2.csv", row.names = FALSE)
