setwd("C:/Users/jason/OneDrive/桌面/Coding Temple/R")

titanic.train <- read.csv(file = "train.csv", stringsAsFactors = FALSE, header = TRUE)
titanic.test <- read.csv(file = "test.csv", stringsAsFactors = FALSE, header = TRUE)

titanic.train$IsTrainSet <- TRUE
titanic.train$IsTrainSet <- FALSE

cols <- intersect(colnames(titanic.test), colnames(titanic.train))

titanic.full <- rbind(titanic.test[,cols], titanic.train[,cols])

titanic.full$Age <- as.factor(titanic.full$Age)

titanic.train <- titanic.full[titanic.full$IsTrainSet==TRUE,]
titanic.test <- titanic.full[titanic.full$IsTrainSet==FALSE,]

titanic.full$Transported <- as.factor(titanic.full$Transported)

Transported.equation <- "Transported ~ Age"
Transported.formula <- as.formula(Transported.equation)
install.packages("randomForest")
library(randomForest)

titanic.model <- randomForest(formula = Transported.formula, data = titanic.train, nodesize = nrow(titanic.test))

another.equation <- "Age"

Transported <- predict(titanic.model, newdata = titanic.test)

PassengerId <- titanic.test$PassengerId

output.df <- as.data.frame(PassengerId)

output.df$Transported <- Transported

write.csv(output.df, file="sample_submission.csv", row.names = FALSE)