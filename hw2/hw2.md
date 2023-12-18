## 1st Dataset

Link: https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic
This dataset has 30 numeric features and one binary target value. The features are from digitalized images of human body cells. They are used to diagnose breast cancer. All of them are continuous numeric features.

### KNN
```
data_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/breastcancer.xlsx'
feat_names_path='C:/Users/ozanridvan.aksu/Desktop/582/Homework 2/namesbc.txt'
data <- read_excel(data_path)
feat_names=fread(feat_names_path,header=F)
names(data)=feat_names$V1
head(data)

require(caret)

n_repeats=5
n_folds=10

fitControl=trainControl(method = "repeatedcv",
                        number = n_folds,
                        repeats = n_repeats,
                        classProbs=TRUE, summaryFunction=twoClassSummary)
scaled_data <- data.table(diagnosis = data$diagnosis, 
                          scale(data[, -which(names(data) == "diagnosis"), with = FALSE]))

set.seed(1)
knn_fit=train(diagnosis ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)

  k   ROC        Sens       Spec     
   5  0.9871047  0.9921111  0.9308658
   7  0.9880528  0.9932381  0.9243290
   9  0.9891326  0.9921111  0.9318182
  11  0.9904406  0.9926667  0.9298701
  13  0.9911195  0.9921270  0.9194372
  15  0.9916456  0.9943492  0.9147619
  17  0.9918249  0.9943651  0.9062338
  19  0.9914790  0.9954762  0.8939394
  21  0.9913220  0.9954603  0.8882251
  23  0.9910172  0.9960476  0.8872727
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/837a0938-a199-4aec-b2c9-34f68d25086b)
k_nearest_neighbors approach is implemented do the data in order to tune the number of neighbors "k". We have 10 models with k = 5, 7, 9, ... , 23. We compare these models with respect to the ROC values.
The best value for k is 17. I could not find the correct package to use Manhattan distance.

### DT

```
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
```
I used the values of 10, 20, 30 and 40 for minsplit, and half of them for minbucket (as it was asked in the assignment). The results for these 4 models are shown below:
```
    Model       AUC
1 Model 1 0.9414965
2 Model 2 0.9412485
3 Model 3 0.9355734
4 Model 4 0.9339957
5 Model 5 0.9314827
```
The best model seems to be the first one where minsplit is 10 and minbucket is 5.

### RF
The number of features evaluated in each split are 5, 10, 15 and 20 for the 4 models that I have in the Random Forest application.
```
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
```

```
Model with mtry = 5 

  ROC        Sens       Spec    
  0.9904851  0.9736984  0.932684

Model with mtry = 10 

  ROC        Sens       Spec    
  0.9893447  0.9754127  0.940303

Model with mtry = 15 

  ROC        Sens      Spec    
  0.9886371  0.978746  0.940303

Model with mtry = 20 

  ROC        Sens       Spec     
  0.9887333  0.9770794  0.9412554
```
The best ROC value is achieved by the first model with m = 5.

### GBM

For Gradient Boosting Method, I used Stochastic Gradient Boosting with learning rates: 0.05 and 0.1; number of trees: 100, 200, ... , 500; the depth: 3, 5.
```
gbmGrid=expand.grid(interaction.depth = c( 3, 5), 
                    n.trees = c(1:5)*100, 
                    shrinkage = c(0.05,0.1),
                    n.minobsinnode = 10)
gbm_fit=train(diagnosis ~ ., data = data, 
              method = "gbm", 
              trControl = fitControl, metric='ROC',
              tuneGrid = gbmGrid,
              verbose=F) 
gbm_fit
plot(gbm_fit)  
```
The ROC values are:
```
shrinkage  interaction.depth  n.trees  ROC        Sens       Spec     
  0.05       3                  100      0.9925360  0.9803810  0.9365368
  0.05       3                  200      0.9927302  0.9826190  0.9411688
  0.05       3                  300      0.9931842  0.9837302  0.9411688
  0.05       3                  400      0.9934478  0.9843016  0.9420779
  0.05       3                  500      0.9935039  0.9831429  0.9401732
  0.05       5                  100      0.9923221  0.9803810  0.9347186
  0.05       5                  200      0.9924734  0.9831587  0.9384848
  0.05       5                  300      0.9930837  0.9859841  0.9412554
  0.05       5                  400      0.9932668  0.9854127  0.9412554
  0.05       5                  500      0.9932671  0.9854127  0.9421645
  0.10       3                  100      0.9928376  0.9809206  0.9412121
  0.10       3                  200      0.9935325  0.9826032  0.9420779
  0.10       3                  300      0.9936083  0.9831587  0.9430303
  0.10       3                  400      0.9937941  0.9842857  0.9458874
  0.10       3                  500      0.9940342  0.9842698  0.9458874
  0.10       5                  100      0.9924722  0.9831587  0.9374892
  0.10       5                  200      0.9931599  0.9859841  0.9421212
  0.10       5                  300      0.9932837  0.9854127  0.9421212
  0.10       5                  400      0.9934394  0.9860000  0.9439394
  0.10       5                  500      0.9934141  0.9854286  0.9450216
```
The best parameters for learning rate, number of trees and depth are  0.10, 3 and 500 respectively.
```
selected_gbm=tolerance(gbm_fit$results, metric = "ROC", tol = 2, maximize = TRUE)  
gbm_fit$results[selected_gbm,]
```
I selected the best model with the best parameters as the selected gradient boosting method.
In order to select the best approach for the model, I run the Random Forest again with mtry = 5.
```
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

mtry_values <- c(5)

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

resamps <- resamples(list(
                          knn = knn_fit,
                          DT = fit_rtree,
                          RF = rf_model,
                          GBM = gbm_fit))
summary(resamps)
bwplot(resamps)
```
The resutls are:
```
Call:
summary.resamples(object = resamps)

Models: knn, DT, RF, GBM 
Number of resamples: 50 

ROC 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
knn 0.9642857 0.9886054 0.9941829 0.9918249 0.9984836 1.0000000    0
DT  0.8174603 0.9102608 0.9357413 0.9314827 0.9566799 0.9986772    0
RF  0.9530423 0.9871032 0.9960317 0.9904851 0.9986772 1.0000000    0
GBM 0.9695767 0.9907407 0.9973545 0.9940342 1.0000000 1.0000000    0

Sens 
         Min.   1st Qu.    Median      Mean   3rd Qu. Max. NA's
knn 0.9428571 1.0000000 1.0000000 0.9943651 1.0000000    1    0
DT  0.7777778 0.8888889 0.9166667 0.9231587 0.9646825    1    0
RF  0.8888889 0.9714286 0.9722222 0.9736984 1.0000000    1    0
GBM 0.9142857 0.9722222 1.0000000 0.9842698 1.0000000    1    0

Spec 
         Min.   1st Qu.    Median      Mean   3rd Qu. Max. NA's
knn 0.7619048 0.8636364 0.9047619 0.9062338 0.9523810    1    0
DT  0.7272727 0.8571429 0.9523810 0.9149351 0.9523810    1    0
RF  0.8095238 0.9047619 0.9523810 0.9326840 0.9886364    1    0
GBM 0.8571429 0.9047619 0.9523810 0.9458874 0.9540043    1    0
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/3a473109-870b-47db-aeb7-07757eaac692)

Decision Tree seems to be the weakest model. The other three approaches are very close.

## 2nd and 3rd Datasets
The 2nd and 3rd datasets are actually the same except their target features, which are performance of the students on mathematics and portuguese lessons respectively. There are numeric, binary and nominal features.
### Performance on Mathematics
```
Attributes for both student-mat.csv (Math course) and student-por.csv (Portuguese language course) datasets:
1 school - student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)
2 sex - student's sex (binary: 'F' - female or 'M' - male)
3 age - student's age (numeric: from 15 to 22)
4 address - student's home address type (binary: 'U' - urban or 'R' - rural)
5 famsize - family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)
6 Pstatus - parent's cohabitation status (binary: 'T' - living together or 'A' - apart)
7 Medu - mother's education (numeric: 0 - none,  1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
8 Fedu - father's education (numeric: 0 - none,  1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
9 Mjob - mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
10 Fjob - father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
11 reason - reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')
12 guardian - student's guardian (nominal: 'mother', 'father' or 'other')
13 traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
14 studytime - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
15 failures - number of past class failures (numeric: n if 1<=n<3, else 4)
16 schoolsup - extra educational support (binary: yes or no)
17 famsup - family educational support (binary: yes or no)
18 paid - extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
19 activities - extra-curricular activities (binary: yes or no)
20 nursery - attended nursery school (binary: yes or no)
21 higher - wants to take higher education (binary: yes or no)
22 internet - Internet access at home (binary: yes or no)
23 romantic - with a romantic relationship (binary: yes or no)
24 famrel - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
25 freetime - free time after school (numeric: from 1 - very low to 5 - very high)
26 goout - going out with friends (numeric: from 1 - very low to 5 - very high)
27 Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
28 Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
29 health - current health status (numeric: from 1 - very bad to 5 - very good)
30 absences - number of school absences (numeric: from 0 to 93)

these grades are related with the course subject, Math or Portuguese:
31 G1 - first period grade (numeric: from 0 to 20)
31 G2 - second period grade (numeric: from 0 to 20)
```
First i converted the binary features into 0s and 1s. Then I used dummy encoding for the nominal features. I also removed G1 and G2 features since they are highly correlated to the target feature. Since the target feature is numeric, i transformed it into a binary feature. If the value of an instance is higher then the median, it is in class "high", otherwise, "low".
```
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
```
### KNN
The parameters that I tuned for each of the following approaches are the same with the first dataset.
```
knn_fit=train(is_high ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/ea95010d-e3a7-47ae-9d22-ecd84cc37959)
5NN is the best model.
### DT
```
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
```

```
    Model       AUC
1 Model 1 0.5898313
2 Model 2 0.6251618
3 Model 3 0.6211462
4 Model 4 0.6315749
5 Model 5 0.6360014
```
### RF
```
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
```
```
Model with mtry = 5

  ROC        Sens       Spec     
  0.6887078  0.4182353  0.8191667

Model with mtry = 10 

  ROC        Sens       Spec     
  0.6942766  0.4634559  0.7902899

Model with mtry = 15 

  ROC        Sens       Spec     
  0.6839224  0.4678676  0.7802174

Model with mtry = 20 

  ROC        Sens     Spec     
  0.6832418  0.48625  0.7653261
```
Since the model with mtry = 10 is the best, I will run it again for further analysis on every approach that I used.
```
mtry_values <- c(10)

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
```
### GBM
```
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
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/f6f88b5f-fb34-4a3a-a895-0869b0d2a540)
The best parameters for shrinkage, depth and number of trees are 0.05, 3 and 10 respectively.
```
resamps <- resamples(list(
                          knn = knn_fit,
                          DT = fit_rtree,
                          RF = rf_model,
                          GBM = gbm_fit))
summary(resamps)
bwplot(resamps)
```
```
summary.resamples(object = resamps)

Models: knn, DT, RF, GBM 
Number of resamples: 50 

ROC 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
knn 0.4442935 0.6216632 0.6794327 0.6683136 0.7180707 0.8369565    0
DT  0.4619565 0.5741688 0.6426630 0.6360014 0.6897778 0.8242188    0
RF  0.5217391 0.6511974 0.6903556 0.6879311 0.7428269 0.8363171    0
GBM 0.4739583 0.6474035 0.6821784 0.6856283 0.7546755 0.8695652    0
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/31b962e1-cb27-4230-8b1b-7623b8bf2f80)
Random forest is the best approach.

### Performance on Portuguese
### KNN
```
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

set.seed(1)
knn_fit=train(is_high ~ ., data = scaled_data,  
              method = "knn", 
              trControl = fitControl, ,metric = "ROC",
              tuneLength = 10)

print(knn_fit)
plot(knn_fit)
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/55aa7d15-4a94-4e36-b3bf-2bdb2a195e71)
### DT
```
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
```
```
    Model       AUC
1 Model 1 0.7047959
2 Model 2 0.7264140
3 Model 3 0.7305166
4 Model 4 0.7288442
5 Model 5 0.7278111
```
#RF
```
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
```
```
Model with mtry = 5 

  ROC        Sens       Spec     
  0.8001766  0.6387831  0.7644808

Model with mtry = 10 

  ROC        Sens       Spec    
  0.8011812  0.6713228  0.759175

Model with mtry = 15 

  ROC        Sens       Spec     
  0.7954997  0.6672751  0.7527454

Model with mtry = 20 

  ROC      Sens       Spec     
  0.79731  0.6689947  0.7521906
```
Again, mtry = 10 is the best model.
```
mtry_values <- c(10)

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
```
### GBM
```
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
```
The best parameters for shrinkage, depth and number of trees are 0.05, 3 and 10 respectively.
```
resamps <- resamples(list(
                          knn = knn_fit,
                          DT = fit_rtree,
                          RF = rf_model,
                          GBM = gbm_fit))
summary(resamps)
bwplot(resamps)
```
```
summary.resamples(object = resamps)

Models: knn, DT, RF, GBM 
Number of resamples: 50 

ROC 
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. NA's
knn 0.6452703 0.7423986 0.7659266 0.7662866 0.7899373 0.8527992    0
DT  0.6047297 0.6888674 0.7218200 0.7278111 0.7687017 0.8406955    0
RF  0.7002002 0.7783140 0.8052479 0.8037333 0.8373105 0.9059059    0
GBM 0.6756757 0.7760886 0.7867153 0.7963840 0.8269788 0.8928929    0
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/1c39cd67-2caf-4a68-9ea4-4f0b4b36cdb7)
Random forest is again the best approach, which is no surprise since the only difference between 2nd and 3rd datasets are the target feature.
## On Learners
Gradient Boosting and Random Forest have the most execution time.
