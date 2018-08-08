
library(jsonlite)
library(httr)
library(plumber)
library(jsonlite)
library(futile.logger)
model <-readRDS("model.rds")
preprocessing <- readRDS("preprocess.rds")

#' @param duration 
#' @param age
#' @param Cred_amt 
#' @param cred_hist. 
#' @param saving_bond
#' @param check.acc.
#' @param employ_since
#' @param personal_status 
#' @param Purpose
#' @param property.
#' @param no.of_exist_cred
#' @post /predict
#' @response 200
function(cred_hist., saving_bond, duration, check.acc., employ_since, personal_status, age, Cred_amt, Purpose, property., no.of_exist_cred){
  flog.info("decision tree model")
  my_numeric.df <- as.data.frame(list(duration = duration,Cred_amt = Cred_amt,age = age))
  my_non_num.df <- as.data.frame(list(cred_hist.= cred_hist., saving_bond = saving_bond, check.acc.= check.acc.,  employ_since =  employ_since, personal_status = personal_status, Purpose = Purpose, property. = property., no.of_exist_cred = no.of_exist_cred))
  my_numeric.df <- log(my_numeric.df)
  my_num.process.df <- predict(preprocvalues, my_numeric.df)
  new_data <- cbind(my_num.process.df, my_non_num.df)
  prediction_prob <- predict(model_dt, new_data)
  return(list(probability_of_good=prediction_prob[2]))}


  