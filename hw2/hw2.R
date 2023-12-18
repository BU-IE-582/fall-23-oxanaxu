# 1ST DATA SET
require(data.table, quietly = TRUE)
install.packages("readxl")
library(readxl)
data_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/breastcancer.xlsx'
feat_names_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/namesbc.txt'
data <- read_excel(data_path)
feat_names=fread(feat_names_path,header=F)
names(data)=feat_names$V1
head(data)

install.packages("caret")
require(caret)

n_repeats=5
n_folds=10

fitControl=trainControl(method = "repeatedcv",
                        number = n_folds,
                        repeats = n_repeats,
                        classProbs=TRUE, summaryFunction=twoClassSummary)

#KNN 
scaled_data <- data.table(diagnosis = data$diagnosis, 
                          scale(data[, -which(names(data) == "diagnosis"), with = FALSE]))

set.seed(1)
knn_fit=train(diagnosis ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)

#DT
set.seed(1)
install.packages(c("rpart", "ROCR", "caret"))
library(rpart)
library(ROCR)
library(caret)

minsplit_values <- c(10, 20, 30, 40, 50)
minbucket_values <- c(5, 10, 15, 20, 25)

tree_models <- list()
roc_values_df <- data.frame(Model = character(), AUC = numeric())

for (i in seq_along(minsplit_values)) {
  minsplit_val <- minsplit_values[i]
  minbucket_val <- minbucket_values[i]
  
  fit_rtree <- train(diagnosis ~ .,
                     data = data,
                     method = "rpart",
                     metric = "ROC",
                     trControl = trainControl(method = "repeatedcv",
                                              number = 10,
                                              repeats = 5,
                                              classProbs = TRUE,
                                              summaryFunction = twoClassSummary),
                     tuneGrid = data.frame(cp = 0),
                     control = rpart.control(cp = 0, minsplit = minsplit_val, minbucket = minbucket_val))
  
  tree_models[[i]] <- fit_rtree
  
  auc_value <- fit_rtree$results$ROC
  
  roc_values_df <- rbind(roc_values_df, data.frame(Model = paste("Model", i), AUC = auc_value))
}

print(roc_values_df)

#RF
data$diagnosis <- as.factor(data$diagnosis)

n_repeats <- 5
n_folds <- 10

fitControl <- trainControl(
  method = "repeatedcv",
  number = n_folds,
  repeats = n_repeats,
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)

num_trees <- 500  
min_obs_leaf <- 5 

mtry_values <- c(5, 10, 15, 20)

rf_models <- list()

for (mtry in mtry_values) {
  rf_model <- train(
    x = data[, 2:ncol(data)],  
    y = data$diagnosis,
    method = "rf",
    trControl = fitControl,
    tuneGrid = data.frame(mtry = mtry),
    ntree = num_trees,
    nodesize = min_obs_leaf
  )
  rf_models[[as.character(mtry)]] <- rf_model
}

for (mtry in mtry_values) {
  cat("Model with mtry =", mtry, "\n")
  print(rf_models[[as.character(mtry)]])
}

# GBM

gbmGrid=expand.grid(interaction.depth = c( 3, 5), 
                    n.trees = c(1:5)*100, 
                    shrinkage = c(0.05,0.1),
                    n.minobsinnode = 10)
set.seed(1)                        
gbm_fit=train(diagnosis ~ ., data = data, 
              method = "gbm", 
              trControl = fitControl, metric='ROC',
              tuneGrid = gbmGrid,
              verbose=F) 


gbm_fit
plot(gbm_fit)  

selected_gbm=tolerance(gbm_fit$results, metric = "ROC", tol = 2, maximize = TRUE)  
gbm_fit$results[selected_gbm,]

resamps <- resamples(list(
                          knn = knn_fit,
                          DT = fit_rtree,
                          RF = rf_model,
                          GBM = gbm_fit))
summary(resamps)
bwplot(resamps)
#2ND DATA SET

data_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/student-mat.xlsx'
feat_names_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/namesstudent.txt'
data <- read_excel(data_path)
feat_names=fread(feat_names_path,header=F)
names(data)=feat_names$V1
head(data)

binary_columns <- c(1, 2, 4, 5, 6, 16, 17, 18, 19, 20, 21, 22, 23)

for (col in names(data)[binary_columns]) {
  unique_values <- unique(data[[col]])
  if (length(unique_values) == 2) {
    data[[col]] <- as.numeric(data[[col]] == unique_values[1])
  }
}
nominal_columns <- c(9, 10, 11, 12)
unique_counts <- sapply(data[, nominal_columns], function(x) length(unique(x)))
dummy_columns <- lapply(data[, nominal_columns, drop = FALSE], function(x) {
  if (length(unique(x)) > 1) {
    model.matrix(~ x - 1, data = data.frame(x = x))
  } else {
    as.data.frame(x)
  }
})

data <- cbind(data, do.call(cbind, dummy_columns))
data <- data[, -nominal_columns]
head(data)

exclude_columns <- c(1, 2, 4, 5, 6, 12, 13, 14, 15, 16,17, 18, 19, 29, 30, 31, 32, 33, 34, 35, 36,
                     37, 38, 39, 40, 41, 42, 43, 44, 45, 46)

scale_columns <- setdiff(1:ncol(data), exclude_columns)

scaled_data <- data
scaled_data[, scale_columns] <- scale(data[, scale_columns])
data <- data[, -c(27, 28)]
scaled_data <- scaled_data[, -c(27, 28)]
fitControl=trainControl(method = "repeatedcv",
                        number = n_folds,
                        repeats = n_repeats,
                        classProbs=TRUE, summaryFunction=twoClassSummary)

library(dplyr)
data <- data %>%
  select(G3, everything())
scaled_data <- scaled_data %>%
  select(G3, everything())
require(data.table, quietly = TRUE)

scaled_data$is_high <- ifelse(scaled_data$G3 > quantile(scaled_data$G3, 0.5), 'high', 'low')
scaled_data <- scaled_data[, -c(1)]
#KNN 

set.seed(1)
knn_fit=train(is_high ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)

#DT

set.seed(1)

minsplit_values <- c(10, 20, 30, 40, 50)
minbucket_values <- c(5, 10, 15, 20, 25)

tree_models <- list()
roc_values_df <- data.frame(Model = character(), AUC = numeric())

for (i in seq_along(minsplit_values)) {
  minsplit_val <- minsplit_values[i]
  minbucket_val <- minbucket_values[i]
  
  fit_rtree <- train(is_high ~ .,
                     data = scaled_data,
                     method = "rpart",
                     metric = "ROC",
                     trControl = trainControl(method = "repeatedcv",
                                              number = 10,
                                              repeats = 5,
                                              classProbs = TRUE,
                                              summaryFunction = twoClassSummary),
                     tuneGrid = data.frame(cp = 0),
                     control = rpart.control(cp = 0, minsplit = minsplit_val, minbucket = minbucket_val))
  
  tree_models[[i]] <- fit_rtree
  
  auc_value <- fit_rtree$results$ROC
  
  roc_values_df <- rbind(roc_values_df, data.frame(Model = paste("Model", i), AUC = auc_value))
}

print(roc_values_df)

#RF
scaled_data$is_high <- as.factor(scaled_data$is_high)

n_repeats <- 5
n_folds <- 10

fitControl <- trainControl(
  method = "repeatedcv",
  number = n_folds,
  repeats = n_repeats,
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)

num_trees <- 500  # Number of trees
min_obs_leaf <- 5  # Minimal number of observations per tree leaf

mtry_values <- c(5, 10, 15, 20)

rf_models <- list()

for (mtry in mtry_values) {
  rf_model <- train(
    x = scaled_data[, 1:ncol(data) - 1],  
    y = scaled_data$is_high, 
    method = "rf",
    trControl = fitControl,
    tuneGrid = data.frame(mtry = mtry),
    ntree = num_trees,
    nodesize = min_obs_leaf
  )
  rf_models[[as.character(mtry)]] <- rf_model
}

for (mtry in mtry_values) {
  cat("Model with mtry =", mtry, "\n")
  print(rf_models[[as.character(mtry)]])
}

#GBM
gbmGrid=expand.grid(interaction.depth = c( 3, 5), 
                    n.trees = c(1:5)*100, 
                    shrinkage = c(0.05,0.1),
                    n.minobsinnode = 10)
set.seed(1)                        
gbm_fit=train(is_high ~ ., data = scaled_data, 
              method = "gbm", 
              trControl = fitControl, metric='ROC',
              tuneGrid = gbmGrid,
              verbose=F) 

gbm_fit
plot(gbm_fit)

#3RD DATA SET

data_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/student-por.xlsx'
feat_names_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/namesstudent.txt'
data <- read_excel(data_path)
feat_names=fread(feat_names_path,header=F)
names(data)=feat_names$V1
head(data)

binary_columns <- c(1, 2, 4, 5, 6, 16, 17, 18, 19, 20, 21, 22, 23)

for (col in names(data)[binary_columns]) {
  unique_values <- unique(data[[col]])
  if (length(unique_values) == 2) {
    data[[col]] <- as.numeric(data[[col]] == unique_values[1])
  }
}
nominal_columns <- c(9, 10, 11, 12)
unique_counts <- sapply(data[, nominal_columns], function(x) length(unique(x)))
dummy_columns <- lapply(data[, nominal_columns, drop = FALSE], function(x) {
  if (length(unique(x)) > 1) {
    model.matrix(~ x - 1, data = data.frame(x = x))
  } else {
    as.data.frame(x)
  }
})

data <- cbind(data, do.call(cbind, dummy_columns))
data <- data[, -nominal_columns]
head(data)

exclude_columns <- c(1, 2, 4, 5, 6, 12, 13, 14, 15, 16,17, 18, 19, 29, 30, 31, 32, 33, 34, 35, 36,
                     37, 38, 39, 40, 41, 42, 43, 44, 45, 46)

scale_columns <- setdiff(1:ncol(data), exclude_columns)

scaled_data <- data
scaled_data[, scale_columns] <- scale(data[, scale_columns])
data <- data[, -c(27, 28)]
scaled_data <- scaled_data[, -c(27, 28)]
fitControl=trainControl(method = "repeatedcv",
                        number = n_folds,
                        repeats = n_repeats,
                        classProbs=TRUE, summaryFunction=twoClassSummary)

data <- data %>%
  select(G3, everything())
scaled_data <- scaled_data %>%
  select(G3, everything())

scaled_data$is_high <- ifelse(scaled_data$G3 > quantile(scaled_data$G3, 0.5), 'high', 'low')
scaled_data <- scaled_data[, -c(1)]
#KNN 

set.seed(1)
knn_fit=train(is_high ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)

#DT

set.seed(1)

minsplit_values <- c(10, 20, 30, 40, 50)
minbucket_values <- c(5, 10, 15, 20, 25)

tree_models <- list()
roc_values_df <- data.frame(Model = character(), AUC = numeric())

for (i in seq_along(minsplit_values)) {
  minsplit_val <- minsplit_values[i]
  minbucket_val <- minbucket_values[i]
  
  fit_rtree <- train(is_high ~ .,
                     data = scaled_data,
                     method = "rpart",
                     metric = "ROC",
                     trControl = trainControl(method = "repeatedcv",
                                              number = 10,
                                              repeats = 5,
                                              classProbs = TRUE,
                                              summaryFunction = twoClassSummary),
                     tuneGrid = data.frame(cp = 0),
                     control = rpart.control(cp = 0, minsplit = minsplit_val, minbucket = minbucket_val))
  
  tree_models[[i]] <- fit_rtree
  
  auc_value <- fit_rtree$results$ROC
  
  roc_values_df <- rbind(roc_values_df, data.frame(Model = paste("Model", i), AUC = auc_value))
}

print(roc_values_df)

#RF
scaled_data$is_high <- as.factor(scaled_data$is_high)

n_repeats <- 5
n_folds <- 10

fitControl <- trainControl(
  method = "repeatedcv",
  number = n_folds,
  repeats = n_repeats,
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)

num_trees <- 500  # Number of trees
min_obs_leaf <- 5  # Minimal number of observations per tree leaf

mtry_values <- c(5, 10, 15, 20)

rf_models <- list()

for (mtry in mtry_values) {
  rf_model <- train(
    x = scaled_data[, 1:ncol(data) - 1],  
    y = scaled_data$is_high, 
    method = "rf",
    trControl = fitControl,
    tuneGrid = data.frame(mtry = mtry),
    ntree = num_trees,
    nodesize = min_obs_leaf
  )
  rf_models[[as.character(mtry)]] <- rf_model
}

for (mtry in mtry_values) {
  cat("Model with mtry =", mtry, "\n")
  print(rf_models[[as.character(mtry)]])
}

#GBM
gbmGrid=expand.grid(interaction.depth = c( 3, 5), 
                    n.trees = c(1:5)*100, 
                    shrinkage = c(0.05,0.1),
                    n.minobsinnode = 10)
set.seed(1)                        
gbm_fit=train(is_high ~ ., data = scaled_data, 
              method = "gbm", 
              trControl = fitControl, metric='ROC',
              tuneGrid = gbmGrid,
              verbose=F)


gbm_fit
plot(gbm_fit)

selected_gbm=tolerance(gbm_fit$results, metric = "ROC", tol = 2, maximize = TRUE)  
gbm_fit$results[selected_gbm,]