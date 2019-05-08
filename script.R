
#RFM helps to identify customers who are more 
#likely to respond to promotions by segmenting them into various categories.

# Проведем RFM анализ 
# Шаг 1 - запуск пакетов

getwd()
#setwd("C:/RPackages")

if(!require(rfm)){
  install.packages("rfm")
  library(rfm)
}
if(!require(lubridate)){
  install.packages("lubridate")
  library(lubridate)
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}


# Шаг 2 - присваивание переменных

# as_date() - ignores the tomezone attrubute resulting in a more intuitive vectors
#analysis_date <- as_date('2006-12-31', tz='UTC')

customer_id <- sample(1:6000, 500000, rep=TRUE) 
order_date <- sample(seq(as.Date('2017/01/01'), as.Date('2018/12/01'), by='day'), 500)
revenue <- sample(9:350, 500, rep=TRUE)  

data <- data.frame(customer_id, order_date, revenue)
head(data)

rfm_heatmap(rfm_result)
rfm_result <- rfm_table_order(data=data, 
                              customer_id=customer_id,
                              order_date=order_date,
                              revenue=revenue,
                              analysis_date=Sys.Date())

# The heat map shows the average monetary value for different categories of recency 
#and frequency scores. Higher scores of frequency and recency are characterized by higher 
#average monetary value as indicated by the darker areas in the heatmap.

rfm_heatmap(rfm_result)

rfm_bar_chart(rfm_result)

rfm_bar_chart(rfm_result, bar_color = "darkblue",
              xaxis_title = "Деньги", sec_xaxis_title = "Частота",
              yaxis_title = " ", sec_yaxis_title = "Недавность")




# Шаг 3 - Создадим сегменты (от самых лояльных до потерянных)



segment_names <- c("Чемпион", "Лояльный_покупатель", "Может_быть_лояльным",
                   "Новичок", "Падающий_надежду", "Требует_внимания", "Засыпает",
                   "В_зоне_риска", "Нельзя_терять", "В_спячке", "Потерян")

recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)

segments <- rfm_segment(rfm_result, segment_names, recency_lower,
                        recency_upper, frequency_lower, frequency_upper, monetary_lower,
                        monetary_upper)

rfm_plot_median_recency(segments)
rfm_plot_median_frequency(segments)
rfm_plot_median_monetary(segments)

rfm_heatmap(rfm_result)

## Запишем файлы в CSV


TempData<- rfm_result$rfm

getwd()
setwd("C:/WorkFiles")


write.csv(TempData, file='rfm_result.csv')





library(rfm, lib="/RPackages/")
library(lubridate, lib="/RPackages/")
library(dplyr, lib="/RPackages/")
library(crayon, lib="/RPackages/")
library(fansi, lib="/RPackages/")
library(utf8, lib="/RPackages/")
library(cli, lib="/RPackages/")
library(ggplot2, lib="/RPackages/")
library(ggthemes, lib="/RPackages/")
library(labeling, lib="/RPackages/")
library(forcats, lib="/RPackages/")
library(RColorBrewer, lib="/RPackages/")

