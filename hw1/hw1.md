### Descriptive Analysis
```
install.packages("data.table")
install.packages("skimr")
install.packages("ggcorrplot")
install.packages("GGally")
library(data.table)
```
After installing the required packages, we can see the summary statistics of the data. I ignored the missing data.
```
data_path='C:/Users/ozanridvan.aksu/Documents/all_ticks_wide.csv'
data=fread(data_path)
summary(data)

   timestamp                       AEFES             AKBNK       
 Min.   :2012-09-17 06:45:00   Min.   : 0.0001   Min.   :0.0001  
 1st Qu.:2014-08-12 13:11:15   1st Qu.:19.1605   1st Qu.:5.8500  
 Median :2016-05-13 11:22:30   Median :20.6465   Median :6.3057  
 Mean   :2016-04-12 21:51:05   Mean   :20.9822   Mean   :6.4731  
 3rd Qu.:2017-12-22 11:03:45   3rd Qu.:22.7320   3rd Qu.:6.9325  
 Max.   :2019-07-23 15:00:00   Max.   :28.5090   Max.   :9.2124  
                               NA's   :1881      NA's   :803     
      AKSA             AKSEN           ALARK            ALBRK      
 Min.   : 0.0001   Min.   :0.000   Min.   :0.0001   Min.   :1.026  
 1st Qu.: 5.2088   1st Qu.:2.670   1st Qu.:1.5689   1st Qu.:1.225  
 Median : 6.9853   Median :2.930   Median :1.9376   Median :1.360  
 Mean   : 7.1275   Mean   :3.183   Mean   :2.0609   Mean   :1.365  
 3rd Qu.: 8.7200   3rd Qu.:3.750   3rd Qu.:2.4214   3rd Qu.:1.500  
 Max.   :15.1189   Max.   :5.190   Max.   :3.5143   Max.   :2.190  
 NA's   :1418      NA's   :1841    NA's   :1677     NA's   :3150   
     ANACM            ARCLK             ASELS             ASUZU        
 Min.   :0.0001   Min.   : 0.0001   Min.   : 0.0001   Min.   : 0.0001  
 1st Qu.:1.0470   1st Qu.:11.7111   1st Qu.: 4.9403   1st Qu.: 5.0748  
 Median :1.2597   Median :15.0100   Median : 9.2757   Median : 5.9496  
 Mean   :1.6721   Mean   :15.3881   Mean   :13.4325   Mean   : 6.4670  
 3rd Qu.:2.4021   3rd Qu.:19.0877   3rd Qu.:22.7567   3rd Qu.: 7.1200  
 Max.   :3.5021   Max.   :26.4278   Max.   :46.7616   Max.   :15.2800  
 NA's   :1847     NA's   :967       NA's   :1209      NA's   :1579     
     AYGAZ             BAGFS             BANVT            BRISA        
 Min.   : 0.0001   Min.   : 0.0001   Min.   : 0.000   Min.   : 0.0001  
 1st Qu.: 5.9515   1st Qu.: 8.2617   1st Qu.: 2.590   1st Qu.: 5.8900  
 Median : 7.7238   Median :10.6100   Median : 3.710   Median : 6.7300  
 Mean   : 8.1019   Mean   :10.4071   Mean   : 7.628   Mean   : 6.5449  
 3rd Qu.:10.2690   3rd Qu.:12.3500   3rd Qu.:11.930   3rd Qu.: 7.3300  
 Max.   :13.5935   Max.   :38.4352   Max.   :28.680   Max.   :10.3275  
 NA's   :1893      NA's   :1362      NA's   :2061     NA's   :1075     
     CCOLA             CEMAS           ECILC            EREGL        
 Min.   : 0.0001   Min.   :0.000   Min.   :0.0001   Min.   : 0.0001  
 1st Qu.:31.9782   1st Qu.:0.700   1st Qu.:1.1723   1st Qu.: 2.1812  
 Median :34.8215   Median :0.870   Median :1.8214   Median : 3.0360  
 Mean   :36.8907   Mean   :1.209   Mean   :2.0759   Mean   : 4.1795  
 3rd Qu.:42.0497   3rd Qu.:1.500   3rd Qu.:2.7809   3rd Qu.: 6.7587  
 Max.   :54.2208   Max.   :7.010   Max.   :4.2278   Max.   :10.4710  
 NA's   :1263      NA's   :3618    NA's   :1520     NA's   :839      
     FROTO             GARAN             GOODY             GUBRF        
 Min.   : 0.0001   Min.   : 0.0001   Min.   : 0.0001   Min.   : 0.0001  
 1st Qu.:21.4938   1st Qu.: 7.0154   1st Qu.: 2.4277   1st Qu.: 3.2765  
 Median :27.1182   Median : 7.6542   Median : 3.1920   Median : 4.2500  
 Mean   :32.7637   Mean   : 7.8997   Mean   : 3.1025   Mean   : 4.3283  
 3rd Qu.:48.5116   3rd Qu.: 8.6786   3rd Qu.: 3.5966   3rd Qu.: 5.1300  
 Max.   :65.4192   Max.   :12.1554   Max.   :58.7574   Max.   :13.6191  
 NA's   :1017      NA's   :704       NA's   :1051      NA's   :955      
     HALKB             ICBCT            ISCTR            ISDMR      
 Min.   : 0.0001   Min.   : 0.000   Min.   :0.0001   Min.   :1.02   
 1st Qu.: 8.7205   1st Qu.: 1.560   1st Qu.:4.3200   1st Qu.:4.85   
 Median :10.6531   Median : 2.030   Median :4.8543   Median :5.91   
 Mean   :10.9194   Mean   : 2.829   Mean   :5.1266   Mean   :5.35   
 3rd Qu.:13.4909   3rd Qu.: 4.070   3rd Qu.:5.8203   3rd Qu.:6.56   
 Max.   :20.2365   Max.   :11.270   Max.   :7.9639   Max.   :7.59   
 NA's   :941       NA's   :5676     NA's   :791      NA's   :37785  
     ISFIN           ISYAT           KAREL           KARSN       
 Min.   :0.000   Min.   :0.000   Min.   :0.000   Min.   :0.0001  
 1st Qu.:0.564   1st Qu.:0.441   1st Qu.:1.531   1st Qu.:1.1100  
 Median :0.864   Median :0.496   Median :1.820   Median :1.2874  
 Mean   :1.559   Mean   :0.537   Mean   :3.178   Mean   :1.3269  
 3rd Qu.:1.674   3rd Qu.:0.633   3rd Qu.:5.250   3rd Qu.:1.4700  
 Max.   :9.830   Max.   :1.150   Max.   :9.460   Max.   :2.5000  
 NA's   :7135    NA's   :6828    NA's   :3980    NA's   :1485    
     KCHOL             KRDMB            KRDMD            MGROS        
 Min.   : 0.0001   Min.   :0.0001   Min.   :0.0001   Min.   : 0.0001  
 1st Qu.: 9.7368   1st Qu.:1.5612   1st Qu.:1.0845   1st Qu.:16.6600  
 Median :12.0449   Median :2.2007   Median :1.3979   Median :19.1100  
 Mean   :12.2483   Mean   :2.2228   Mean   :1.7684   Mean   :19.5764  
 3rd Qu.:15.1693   3rd Qu.:2.7273   3rd Qu.:2.1690   3rd Qu.:22.1000  
 Max.   :19.1500   Max.   :4.4960   Max.   :4.9510   Max.   :30.2600  
 NA's   :919       NA's   :2480     NA's   :851      NA's   :1109     
     OTKAR              PARSN            PETKM            PGSUS      
 Min.   :  0.0001   Min.   : 0.000   Min.   :0.0001   Min.   : 0.00  
 1st Qu.: 56.7757   1st Qu.: 4.570   1st Qu.:1.2869   1st Qu.:17.79  
 Median : 82.8224   Median : 7.890   Median :2.2845   Median :25.64  
 Mean   : 81.4195   Mean   : 8.277   Mean   :2.5392   Mean   :24.79  
 3rd Qu.:105.4988   3rd Qu.:10.650   3rd Qu.:3.8828   3rd Qu.:29.44  
 Max.   :139.4288   Max.   :29.820   Max.   :5.7697   Max.   :50.65  
 NA's   :1227       NA's   :4687     NA's   :828      NA's   :4791   
     PRKME            SAHOL              SASA             SISE       
 Min.   :0.0001   Min.   : 0.0001   Min.   :0.0001   Min.   :0.0001  
 1st Qu.:2.3895   1st Qu.: 7.9652   1st Qu.:0.3192   1st Qu.:1.9220  
 Median :2.7400   Median : 8.6079   Median :0.7335   Median :2.6682  
 Mean   :2.9271   Mean   : 8.6159   Mean   :2.2949   Mean   :3.0484  
 3rd Qu.:3.4365   3rd Qu.: 9.2682   3rd Qu.:4.9473   3rd Qu.:4.1460  
 Max.   :5.4300   Max.   :11.6826   Max.   :8.4260   Max.   :6.9230  
 NA's   :1546     NA's   :917       NA's   :2379     NA's   :922     
     SKBNK             SODA            TCELL             THYAO        
 Min.   :0.0001   Min.   :0.0001   Min.   : 0.0001   Min.   : 0.0001  
 1st Qu.:1.2000   1st Qu.:1.4758   1st Qu.: 8.5663   1st Qu.: 6.4300  
 Median :1.5100   Median :2.6684   Median : 9.7001   Median : 7.7800  
 Mean   :1.4737   Mean   :3.1896   Mean   : 9.8280   Mean   : 9.2888  
 3rd Qu.:1.7207   3rd Qu.:4.2861   3rd Qu.:11.2364   3rd Qu.:12.2700  
 Max.   :2.2516   Max.   :7.7659   Max.   :15.8125   Max.   :19.9500  
 NA's   :2742     NA's   :1736     NA's   :869       NA's   :730      
     TKFEN             TOASO             TRKCM             TSKB       
 Min.   : 0.0001   Min.   : 0.0001   Min.   :0.0001   Min.   :0.0001  
 1st Qu.: 4.3190   1st Qu.:10.3656   1st Qu.:1.1742   1st Qu.:0.8254  
 Median : 5.7532   Median :16.5554   Median :1.6270   Median :0.9373  
 Mean   : 9.1918   Mean   :16.5973   Mean   :2.0278   Mean   :0.9452  
 3rd Qu.:14.2468   3rd Qu.:20.6513   3rd Qu.:2.9826   3rd Qu.:1.0244  
 Max.   :27.3200   Max.   :29.9218   Max.   :4.6432   Max.   :1.4208  
 NA's   :1082      NA's   :1066      NA's   :1126     NA's   :1628    
     TTKOM            TUKAS           TUPRS               USAK       
 Min.   :0.0001   Min.   :0.650   Min.   :  0.0001   Min.   :0.0001  
 1st Qu.:5.2673   1st Qu.:1.060   1st Qu.: 34.5491   1st Qu.:0.9571  
 Median :5.7464   Median :1.530   Median : 49.5542   Median :1.0500  
 Mean   :5.6607   Mean   :1.738   Mean   : 62.9945   Mean   :1.2205  
 3rd Qu.:6.2600   3rd Qu.:2.130   3rd Qu.: 93.4287   3rd Qu.:1.3708  
 Max.   :7.3500   Max.   :5.920   Max.   :139.2937   Max.   :2.7578  
 NA's   :935      NA's   :4083    NA's   :869        NA's   :2353    
     VAKBN            VESTL            YATAS            YKBNK       
 Min.   :0.0001   Min.   : 0.000   Min.   : 0.000   Min.   :0.0001  
 1st Qu.:4.0322   1st Qu.: 4.020   1st Qu.: 0.389   1st Qu.:2.2682  
 Median :4.4742   Median : 6.320   Median : 0.966   Median :2.6093  
 Mean   :4.7354   Mean   : 5.943   Mean   : 2.434   Mean   :2.5663  
 3rd Qu.:5.2460   3rd Qu.: 7.450   3rd Qu.: 4.230   3rd Qu.:2.8740  
 Max.   :7.5814   Max.   :14.540   Max.   :10.675   Max.   :3.9581  
 NA's   :800      NA's   :1231     NA's   :3957     NA's   :787     
     YUNSA           ZOREN       
 Min.   :0.000   Min.   :0.0001  
 1st Qu.:3.007   1st Qu.:1.0338  
 Median :4.108   Median :1.2500  
 Mean   :4.080   Mean   :1.2481  
 3rd Qu.:4.721   3rd Qu.:1.4265  
 Max.   :9.527   Max.   :2.4430  
 NA's   :4484    NA's   :1205  
```
Here we can observe that the data belongs to the time period between 2012-09-17 06:45:00 and 2019-07-23 15:00:00. Skewness and Kurtosis values are below:
```
install.packages("moments")
library(moments)
skewness_values <- sapply(data[, -1], skewness, na.rm = TRUE)
kurtosis_values <- sapply(data[, -1], kurtosis, na.rm = TRUE)
print(skewness_values)
  AEFES       AKBNK        AKSA       AKSEN       ALARK       ALBRK 
 0.30640674  0.57930582  0.16908001  0.82596956  0.64571513  0.39113476 
      ANACM       ARCLK       ASELS       ASUZU       AYGAZ       BAGFS 
 0.71282662  0.11570786  0.69724615  1.48203904  0.29553127  2.96610144 
      BANVT       BRISA       CCOLA       CEMAS       ECILC       EREGL 
 1.01275151 -0.16978658  0.60903841  2.35474580  0.49699830  0.57219589 
      FROTO       GARAN       GOODY       GUBRF       HALKB       ICBCT 
 0.57135704  0.66311378 10.19723116  0.50169612  0.20509431  1.49405791 
      ISCTR       ISDMR       ISFIN       ISYAT       KAREL       KARSN 
 0.70013527 -1.22726416  2.16720329  0.52958123  0.85916951  1.03110486 
      KCHOL       KRDMB       KRDMD       MGROS       OTKAR       PARSN 
 0.03927009  0.49498014  1.36896378  0.46608020 -0.23358986  1.11982085 
      PETKM       PGSUS       PRKME       SAHOL        SASA        SISE 
 0.47262606  0.21510731  0.65912277  0.05628828  0.82821479  0.51157002 
      SKBNK        SODA       TCELL       THYAO       TKFEN       TOASO 
-0.06839931  0.53590976 -0.16372549  0.93245901  1.16881803  0.11027809 
      TRKCM        TSKB       TTKOM       TUKAS       TUPRS        USAK 
 0.55320261  0.69824309 -0.79130970  1.69386122  0.68081972  1.29534496 
      VAKBN       VESTL       YATAS       YKBNK       YUNSA       ZOREN 
 0.84584923  0.18189771  1.06890978 -0.24053962  0.87086862  0.40898715

print(kurtosis_values)
     AEFES      AKBNK       AKSA      AKSEN      ALARK      ALBRK      ANACM 
  2.554264   2.960088   2.898543   2.646666   2.466442   3.186814   1.950446 
     ARCLK      ASELS      ASUZU      AYGAZ      BAGFS      BANVT      BRISA 
  2.232914   2.082499   5.347907   1.936214  24.320628   2.995122   2.827794 
     CCOLA      CEMAS      ECILC      EREGL      FROTO      GARAN      GOODY 
  2.326860  10.839219   1.936404   1.965534   1.959249   3.088658 626.321452 
     GUBRF      HALKB      ICBCT      ISCTR      ISDMR      ISFIN      ISYAT 
  2.561553   2.398643   5.611958   2.425660   3.325652   7.169988   4.063215 
     KAREL      KARSN      KCHOL      KRDMB      KRDMD      MGROS      OTKAR 
  2.310079   4.282541   1.909986   2.502624   4.130739   2.661158   2.109730 
     PARSN      PETKM      PGSUS      PRKME      SAHOL       SASA       SISE 
  4.930259   1.877162   2.678079   2.356419   2.720481   1.983416   2.222651 
     SKBNK       SODA      TCELL      THYAO      TKFEN      TOASO      TRKCM 
  1.907605   2.343580   3.233760   2.666856   3.008360   1.989436   2.009637 
      TSKB      TTKOM      TUKAS      TUPRS       USAK      VAKBN      VESTL 
  3.122133   3.453484   6.236394   2.032968   3.827238   2.926751   2.631884 
     YATAS      YKBNK      YUNSA      ZOREN 
  3.086681   3.021049   3.764225   3.273040 
timestamp_column <- data$timestamp
```
In order to be able to compare the variances of the stocks, each column is normalized, and the variance of the normalized data is calculated.
```
timestamp_column <- data$timestamp
numeric_data <- as.data.frame(lapply(data[, -1], function(x) if(is.numeric(x)) (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE)) else x))
normalized_data <- cbind(timestamp = timestamp_column, numeric_data)
normalized_variances <- sapply(normalized_data[, -1], var, na.rm = TRUE)
print(normalized_variances)
 AEFES        AKBNK         AKSA        AKSEN        ALARK        ALBRK 
0.0076530162 0.0105217092 0.0321302894 0.0194778442 0.0268600374 0.0207695471 
       ANACM        ARCLK        ASELS        ASUZU        AYGAZ        BAGFS 
0.0506783366 0.0294006810 0.0423600576 0.0207497668 0.0368772588 0.0088612515 
       BANVT        BRISA        CCOLA        CEMAS        ECILC        EREGL 
0.0477528851 0.0157315955 0.0154852622 0.0130233700 0.0530543396 0.0660347598 
       FROTO        GARAN        GOODY        GUBRF        HALKB        ICBCT 
0.0507169887 0.0105690641 0.0002276099 0.0080640598 0.0230384040 0.0252232848 
       ISCTR        ISDMR        ISFIN        ISYAT        KAREL        KARSN 
0.0158743436 0.0666769614 0.0322338460 0.0194202340 0.0508698669 0.0134954796 
       KCHOL        KRDMB        KRDMD        MGROS        OTKAR        PARSN 
0.0276004074 0.0233078335 0.0360555963 0.0166217557 0.0397052961 0.0244465131 
       PETKM        PGSUS        PRKME        SAHOL         SASA         SISE 
0.0570858822 0.0228510252 0.0176778444 0.0066867763 0.0875364565 0.0422416776 
       SKBNK         SODA        TCELL        THYAO        TKFEN        TOASO 
0.0171564877 0.0693966662 0.0222048115 0.0407516328 0.0595537046 0.0447294412 
       TRKCM         TSKB        TTKOM        TUKAS        TUPRS         USAK 
0.0560926577 0.0119454879 0.0124044830 0.0270714998 0.0540975028 0.0277675757 
       VAKBN        VESTL        YATAS        YKBNK        YUNSA        ZOREN 
0.0166376319 0.0378954171 0.0571713388 0.0114094318 0.0199893825 0.0162416746
```
Maximum variance belongs to SASA with 0.08753646 and minimum variance belongs to GOODY with 0.0002276099. This information gives us an insight about the risk of these stocks.

In order to see the patterns, we need to plot the columns. In order to have clear plots I made groups of five, so now we have 12 plots:
```
group_size <- 5
numeric_cols <- names(data)[sapply(data, is.numeric)]
numeric_cols <- numeric_cols[2:length(numeric_cols)]
groups <- split(numeric_cols, (seq_along(numeric_cols) - 1) %/% group_size)
par(mar = c(5, 4, 4, 2))  # Adjust figure margins
for (group in groups) {
    if (length(group) > 0) {
        # Prepare data for the group
        group_data <- as.data.frame(data[, c("timestamp", group), with = FALSE])
        max_value <- max(unlist(group_data[group]), na.rm = TRUE)
        if (is.finite(max_value)) {
            # Create a new plot for the group with a common y-axis limit
            plot(group_data$timestamp, group_data[[group[1]]], type = "l", col = 1, xlab = "Timestamp", ylab = "Price", main = paste(group, collapse = ", "), ylim = c(0, max_value))
            for (i in 2:length(group)) {
                lines(group_data$timestamp, group_data[[group[i]]], col = i)
            }
            legend_colors <- c(1, 2:length(group))
            legend("topright", legend = names(group_data)[-1], col = legend_colors, lty = 1, cex = 0.8)
            par(mfrow = c(1, 1))
        }
    }
}
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/86811db0-9912-47af-9541-7f38a44c2151)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/026f6659-ce74-4eba-9240-f713fe668264)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/ff9242e4-1bbc-4b2f-aadf-6718e89b504f)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/8502e552-a8cc-4f25-bfae-2a9f8ba71b76)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/f20cc579-8ae0-40c8-a738-137bd94a8ebc)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/7eef1c6a-c064-409c-a25c-f66f19bab3c5)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/3da242c9-ce49-415f-afd7-849a07142a1d)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/829024ed-b21e-47a4-8256-9aacfef7f69f)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/c5bbf2aa-1e87-4c2a-9dbd-9a79db5f680a)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/04e3fa75-c2ce-49ee-b59c-23259b7d38db)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/702dd3d0-306f-48af-b858-652dba868e8c)
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/e0a82c63-c2ed-49c8-8b20-067f096fc0ee)
Almost every stock price increased at the beginning of 2017 and they decreased during late 2018 with some exceptions like CCOLA. This can be related to some economic or political changes in the country. My guess would be beginning of the presidential system in Türkiye had a negative impact on the stocks.

### Moving Window Correlation
When the correlation matrix is observed, I noticed that 70% of the values are positive. This shows us the size of the two groups, when the data is divided into two groups, in which the stock prices tend to behave in similar direction.
```
correlation_matrix <- cor(data[, -1], use = "complete.obs")
positive_values <- sum(correlation_matrix > 0 & correlation_matrix != 1)
total_values <- sum(correlation_matrix !=1)
ratio <- positive_values/total_values
ratio

0.705649717514124
```
The the maximum and minimum correlation values between the stock values are given below:

```
max_value <- max(correlation_matrix[correlation_matrix != 1], na.rm = TRUE)
row_index <- which(correlation_matrix == max_value, arr.ind = TRUE)[1,]
print(max_value)
print(row_index)

[1] 0.9340109
row col 
 40   2 

min_value <- min(correlation_matrix[correlation_matrix != 1], na.rm = TRUE)
row_index2 <- which(correlation_matrix == min_value, arr.ind = TRUE)[1,]
print(min_value)
print(row_index2)

[1] -0.8944663
row col 
 44  12 
```
The maximum correlation value is 0.9340109 which is the correlation of AKBNK and SAHOL, which makes sense since Akbank is within the Sabancı Holding.
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/5c290835-60e3-40e4-8238-f9cfc7fcf18f)
The correlation values are mostly between 0.5 and 1. There is an unusual low correlation during April of 2014. What seemed really interesting that BAGFS and SODA has a correlation value of -0.8944663, which indicates that these two stock prices behave almost opposite. But when the moving window correlation is observed, this seems not to be case since there is not a regular pattern in the plot below.
```
correlation_values2 <- c()
for (start_row in seq(2, nrow(data), by = 500)) {
  end_row <- min(start_row + 499, nrow(data))
  data_subset <- data[start_row:end_row, c(45, 13)]
  correlation_value <- cor(data_subset[, 1], data_subset[, 2], use = "complete.obs")
  correlation_values2 <- c(correlation_values2, correlation_value)
}
print(correlation_values2)
plot(correlation_values2, type = "l", xlab = "Time", ylab = "Correlation Value", main = "Monthly Correlation Values of BAGFS and SODA")
```
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/d6acab76-3e34-4d87-918e-a24f3fad8b42)
### Principal Component Analysis
Before applying PCA, we need to remove the rows with missing values. I first inspected the ratios of missing values of each row:
```
missing_ratios <- colMeans(is.na(data))
print(missing_ratios)

 timestamp      AEFES      AKBNK       AKSA      AKSEN      ALARK      ALBRK 
0.00000000 0.03761097 0.01605615 0.02835320 0.03681117 0.03353195 0.06298488 
     ANACM      ARCLK      ASELS      ASUZU      AYGAZ      BAGFS      BANVT 
0.03693114 0.01933536 0.02417420 0.03157242 0.03785092 0.02723346 0.04121011 
     BRISA      CCOLA      CEMAS      ECILC      EREGL      FROTO      GARAN 
0.02149484 0.02525394 0.07234264 0.03039271 0.01677597 0.02033512 0.01407662 
     GOODY      GUBRF      HALKB      ICBCT      ISCTR      ISDMR      ISFIN 
0.02101496 0.01909542 0.01881548 0.11349276 0.01581620 0.75551868 0.14266576 
     ISYAT      KAREL      KARSN      KCHOL      KRDMB      KRDMD      MGROS 
0.13652723 0.07958090 0.02969287 0.01837559 0.04958810 0.01701592 0.02217468 
     OTKAR      PARSN      PETKM      PGSUS      PRKME      SAHOL       SASA 
0.02453411 0.09371751 0.01655603 0.09579701 0.03091258 0.01833560 0.04756858 
      SISE      SKBNK       SODA      TCELL      THYAO      TKFEN      TOASO 
0.01843558 0.05482684 0.03471167 0.01737583 0.01459650 0.02163481 0.02131488 
     TRKCM       TSKB      TTKOM      TUKAS      TUPRS       USAK      VAKBN 
0.02251460 0.03255219 0.01869551 0.08164041 0.01737583 0.04704871 0.01599616 
     VESTL      YATAS      YKBNK      YUNSA      ZOREN 
0.02461409 0.07912101 0.01573622 0.08965848 0.02409422 
```

ISDMR is missing more than 75% of the values, which would force us to remove a big part of the data. Instead, i decided to remove ISDMR column itself.
```
setkey(data, ISDMR)
new_data <- data[, ISDMR := NULL]
```
With `new_data` which excludes ISDMR colummn from the original data, I am ready to apply PCA.
```
newdata <- na.omit(new_data)
pca_obj = princomp(newdata[, -1],cor=T)
summary(pca_obj,loadings=T)
plot(pca_obj)

Importance of components:
                          Comp.1    Comp.2     Comp.3     Comp.4     Comp.5
Standard deviation     5.2594227 3.7012672 2.35932652 1.80420577 1.53616303
Proportion of Variance 0.4688394 0.2321929 0.09434613 0.05517218 0.03999656
Cumulative Proportion  0.4688394 0.7010323 0.79537843 0.85055061 0.89054716
                           Comp.6     Comp.7     Comp.8     Comp.9     Comp.10
Standard deviation     1.01627456 0.90591178 0.80317812 0.73365516 0.656029419
Proportion of Variance 0.01750532 0.01390977 0.01093382 0.00912288 0.007294485
Cumulative Proportion  0.90805248 0.92196225 0.93289606 0.94201894 0.949313429
                           Comp.11     Comp.12     Comp.13     Comp.14
Standard deviation     0.621553016 0.558348550 0.557144632 0.460072711
Proportion of Variance 0.006547935 0.005283951 0.005261189 0.003587575
Cumulative Proportion  0.955861363 0.961145314 0.966406503 0.969994078
                          Comp.15     Comp.16     Comp.17     Comp.18
Standard deviation     0.43438562 0.409606536 0.395897527 0.352491930
Proportion of Variance 0.00319815 0.002843687 0.002656523 0.002105942
Cumulative Proportion  0.97319223 0.976035915 0.978692438 0.980798379
                          Comp.19    Comp.20    Comp.21     Comp.22     Comp.23
Standard deviation     0.32101216 0.29981177 0.29035033 0.269239517 0.256713316
Proportion of Variance 0.00174659 0.00152351 0.00142887 0.001228643 0.001116978
Cumulative Proportion  0.98254497 0.98406848 0.98549735 0.986725992 0.987842970
                           Comp.24      Comp.25      Comp.26      Comp.27
Standard deviation     0.251489823 0.2384695451 0.2347833712 0.2163822789
Proportion of Variance 0.001071985 0.0009638597 0.0009342921 0.0007935812
Cumulative Proportion  0.988914955 0.9898788152 0.9908131073 0.9916066885
                            Comp.28      Comp.29      Comp.30     Comp.31
Standard deviation     0.2065210275 0.2047997676 0.1965549090 0.176718944
Proportion of Variance 0.0007228972 0.0007108974 0.0006548107 0.000529315
Cumulative Proportion  0.9923295857 0.9930404830 0.9936952938 0.994224609
                            Comp.32      Comp.33      Comp.34      Comp.35
Standard deviation     0.1697037110 0.1652266593 0.1611288285 0.1543652780
Proportion of Variance 0.0004881246 0.0004627093 0.0004400424 0.0004038752
Cumulative Proportion  0.9947127333 0.9951754426 0.9956154850 0.9960193602
                           Comp.36      Comp.37      Comp.38      Comp.39
Standard deviation     0.148310573 0.1425080476 0.1323322649 0.1290588549
Proportion of Variance 0.000372814 0.0003442126 0.0002968106 0.0002823083
Cumulative Proportion  0.996392174 0.9967363868 0.9970331975 0.9973155058
                            Comp.40     Comp.41      Comp.42      Comp.43
Standard deviation     0.1270258315 0.123287530 0.1158778770 0.1120808237
Proportion of Variance 0.0002734841 0.000257624 0.0002275878 0.0002129171
Cumulative Proportion  0.9975889899 0.997846614 0.9980742017 0.9982871188
                            Comp.44      Comp.45      Comp.46      Comp.47
Standard deviation     0.1033681234 0.0993566337 0.0965876030 0.0945330939
Proportion of Variance 0.0001811012 0.0001673176 0.0001581214 0.0001514662
Cumulative Proportion  0.9984682200 0.9986355376 0.9987936591 0.9989451253
                            Comp.48      Comp.49      Comp.50      Comp.51
Standard deviation     0.0883265815 0.0845165409 0.0837312576 0.0787975636
Proportion of Variance 0.0001322303 0.0001210686 0.0001188292 0.0001052382
Cumulative Proportion  0.9990773555 0.9991984241 0.9993172533 0.9994224916
                             Comp.52       Comp.53       Comp.54       Comp.55
Standard deviation     0.07619981606 0.07231073081 0.07037477343 0.06717938705
Proportion of Variance 0.00009841376 0.00008862444 0.00008394252 0.00007649271
Cumulative Proportion  0.99952090531 0.99960952975 0.99969347227 0.99976996499
                             Comp.56       Comp.57       Comp.58       Comp.59
Standard deviation     0.06504532364 0.06331124508 0.05432051905 0.04880716341
Proportion of Variance 0.00007171007 0.00006793752 0.00005001218 0.00004037524
Cumulative Proportion  0.99984167506 0.99990961258 0.99995962476 1.00000000000

Loadings:
      Comp.1 Comp.2 Comp.3 Comp.4 Comp.5 Comp.6 Comp.7 Comp.8 Comp.9 Comp.10
AEFES         0.136  0.262                              0.392               
AKBNK  0.113  0.193                                     0.116  0.198        
AKSA   0.164                              0.233               -0.180 -0.205 
AKSEN  0.114  0.130  0.155 -0.210               -0.209               -0.155 
ALARK  0.154                0.146  0.250  0.123        -0.133         0.102 
ALBRK                0.208  0.228 -0.193 -0.483 -0.278        -0.199        
ANACM  0.176                                    -0.114                      
ARCLK  0.102        -0.312                      -0.101                      
ASELS  0.180               -0.115                0.163                      
ASUZU  0.156         0.160                0.139         0.109               
AYGAZ  0.170        -0.104 -0.122        -0.124                             
BAGFS         0.204               -0.220                                    
BANVT  0.171                       0.153         0.205 -0.112         0.103 
BRISA         0.121 -0.101        -0.499         0.167 -0.265  0.167        
CCOLA -0.108  0.151  0.151  0.148  0.117 -0.188        -0.157  0.112        
CEMAS  0.118         0.109 -0.288               -0.263         0.145        
ECILC  0.169               -0.140                             -0.129        
EREGL  0.178                                                                
FROTO  0.174                                                   0.138        
GARAN  0.136  0.151         0.159                       0.144  0.240        
GOODY  0.101  0.105 -0.159 -0.176 -0.134 -0.271        -0.231         0.532 
GUBRF         0.174 -0.127        -0.291         0.114               -0.311 
HALKB         0.206                0.123 -0.243        -0.149  0.133 -0.160 
ICBCT  0.133               -0.151        -0.262  0.421         0.167 -0.157 
ISCTR  0.119  0.173         0.165               -0.138               -0.175 
ISFIN        -0.168         0.241        -0.247               -0.272 -0.105 
ISYAT  0.134 -0.137         0.212         0.110                0.176        
KAREL  0.180                                    -0.115        -0.170        
KARSN  0.116  0.110  0.131        -0.322         0.128  0.174 -0.135 -0.124 
KCHOL  0.170        -0.152                                     0.124        
KRDMB                0.332                             -0.269 -0.249        
KRDMD  0.148         0.195 -0.133 -0.111        -0.125 -0.105               
MGROS         0.250                                    -0.117        -0.145 
OTKAR  0.108        -0.292  0.110                       0.174               
PARSN  0.142               -0.198               -0.115         0.367        
PETKM  0.184                                            0.103               
PGSUS                0.210  0.311         0.225  0.210 -0.272  0.224  0.153 
PRKME         0.182  0.132         0.202         0.217 -0.174 -0.153        
SAHOL         0.233         0.109                       0.158  0.174        
SASA   0.167 -0.110                                                         
SISE   0.162 -0.119                      -0.168                             
SKBNK         0.196  0.184                       0.231        -0.143  0.117 
SODA   0.137 -0.168                      -0.134                      -0.115 
TCELL  0.165                0.165                0.280  0.145               
THYAO  0.151         0.184        -0.125         0.100  0.106               
TKFEN  0.144 -0.160         0.119                              0.125        
TOASO  0.147  0.101 -0.161 -0.138         0.109               -0.146        
TRKCM  0.183                                                                
TSKB          0.238                                     0.155               
TTKOM         0.250         0.110         0.104                      -0.107 
TUKAS               -0.139  0.349         0.159        -0.196        -0.213 
TUPRS  0.162 -0.122                      -0.112        -0.102               
USAK   0.125  0.155        -0.148                      -0.214 -0.103 -0.256 
VAKBN         0.220                                                         
VESTL  0.150                0.127 -0.201  0.206 -0.208 -0.119         0.170 
YATAS  0.179                                     0.112  0.183 -0.166        
YKBNK         0.244         0.154               -0.136         0.158  0.105 
YUNSA                0.314        -0.130        -0.168 -0.145  0.105 -0.178 
ZOREN  0.126  0.123               -0.292                              0.288 ...
```

The first 6 components cover over 90% of the variance. At this part of the homework, I realized my knowledge about PCA is not enough to interpret.
### Inference  with Google Trends
I chose stocks that show dramatic increase or decrease in the prices to search for Google Trend keywords. 
![image](https://github.com/BU-IE-582/fall-23-oxanaxu/assets/119375227/c60c47af-309c-4152-b8b6-bc36905e1aeb)
PGSUS, FROTO and TOASO's price started a rise at the beginning of 2017. Search results of all three stocks increased at late 2017 and early 2018. The same is true for KAREL, TUPRS, YUNSA and YATAS. This tells me that Google users' interest follows the increment with a several months of delay. When the graphs are observed from a closer look, it seems like the prices maintain an increase during the first half of the years and behave the opposite in the second halfs. 
