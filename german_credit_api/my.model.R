library(randomForest)
library(gridExtra)
library(dplyr)
library(ROCR)
library(rpart)

# load german data and give column names

my_data <- read.table("german.data",sep="",header=FALSE, col.names = c("check.acc ","duration","cred_hist ","Purpose","Cred_amt","saving_bond","employ_since","Installment_rate","personal_status","other_debtors","residence_since","property ","age","other_install_plans","housing ","no.of_exist_cred","job","dependents","telephone","foreign_worker","status"),stringsAsFactors = FALSE)

# Converting the status feature to 0 as bad and 1 as good credit
my_data$status[my_data$status==2]<-0

# Splitting Data (Train - Test - Validation )(60-20-20)%

set.seed(100)
split_data <- sample(1:3, size=nrow(my_data), prob=c(0.600,0.200,0.200), replace = TRUE)
train <- my_data[split_data==1,]
test <- my_data[split_data==2,]
validation <- my_data[split_data==3,]

# Feature Processing (Logarithmic transformation)
train$age <- log(train$age)
train$Cred_amt <- log(train$Cred_amt)
train$duration <- log(train$duration)
validation$age <- log(validation$age)
validation$duration <- log(validation$duration)


#  Standardisation
train$duration <- as.numeric(scale(train$duration))
train$age <- as.numeric(scale(train$age))
train$Cred_amt <- as.numeric(scale(train$Cred_amt))
validation$age <- as.numeric(scale(validation$age))
validation$duration <- as.numeric(scale(validation$duration))
validation$Cred_amt <- as.numeric(scale(validation$Cred_amt))

# Decision Tree Model
model_dt<- rpart(status~cred_hist.+saving_bond+duration+check.acc.+employ_since+personal_status+age+Cred_amt+Purpose+property.+no.of_exist_cred,train, method = 'class')
saveRDS(model_dt,file="model.rds")
validation$status.p <- predict(model_dt,validation,type = "class")
validation$status <-as.factor(validation$status)
validation$status.p <-as.factor(validation$status.p)
p1 <-caret::confusionMatrix(validation$status,validation$status.p)

