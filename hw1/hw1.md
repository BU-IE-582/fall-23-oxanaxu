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
