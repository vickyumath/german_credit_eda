library(httr)
library(jsonlite)
library(magrittr)
url<-"http://localhost:8000/predict"
query <- list(cred_hist.= "A34",
              saving_bond ="A65",
              duration = 48,
              check.acc.= "A11",
              employ_since = "A75",
              personal_status = "A93",
              age= 25,
              Cred_amt = 1250,
              Purpose = "A43",
              property.= "A121",
              no.of_exist_cred = 2)
r <- POST(url, body = query, encode = "json") %>% stop_for_status()
text_content <-content(r,as = "text", encoding = "UTF-8")
json_content <- fromJSON(text_content, flatten = T)
json_df <- as.data.frame(json_content )
