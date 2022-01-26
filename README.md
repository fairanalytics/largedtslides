# Introduction 

Generate a **report/slides** based on [rmarkdown](https://rmarkdown.rstudio.com/)  using a dataset as an input.

The current version support supports **[xaringan](https://bookdown.org/yihui/rmarkdown/xaringan.html)**
In each slide a subset is displayed.

![](slides_dt.gif)

# Installation and usage : 

```{r}
# install the package( dependencies will be installed automaticall)
devtools::install_github("fairanalytics/largedtslides", dependencies = TRUE)

# load the package
library("largedtslides")
library("dplyr")

# generate the report (will be saved in your main working directory)
fair_generate_report(raw_data = mtcars, chunk_size = 5, report_author = "Fair Analytics" )

```
