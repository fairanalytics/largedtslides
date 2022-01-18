# Introduction 



# Installation and usage : 

```{r}
devtools::install_github("fairanalytics/largedtslides", dependencies = TRUE)

library("largedtslides")
library("dplyr")


fair_generate_report(raw_data = mtcars, chunk_size = 5, report_author = "Fair Analytics" )

```
