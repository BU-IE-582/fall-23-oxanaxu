```
install.packages("data.table")
install.packages("skimr")
install.packages("ggcorrplot")
install.packages("GGally")
library(data.table)
```
After installing the required packages, we can see the summary statistics of the data.
```
data_path='C:/Users/ozanridvan.aksu/Documents/all_ticks_wide.csv'
data=fread(data_path)
summary(data)
```
