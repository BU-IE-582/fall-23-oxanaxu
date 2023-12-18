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
```
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
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/837a0938-a199-4aec-b2c9-34f68d25086b)
k_nearest_neighbors approach is implemented do the data in order to tune the number of neighbors "k". We have 10 models with k = 5, 7, 9, ... , 23. We compare these models with respect to the ROC values.
The best value for k is 17.
