# Preprocessing
library(caret)
my_train.df <- data.frame(duration = train$duration,Cred_amt = train$Cred_amt,age = train$age)
my_test.df <- data.frame(duration = test$duration,Cred_amt = test$Cred_amt,age = test$age)
preprocvalues <- caret::preProcess(my_train.df,method = c("center", "scale"))
processsed_value <- predict(preprocvalues, my_test.df)
saveRDS(preprocvalues,file = "preprocess.rds")
