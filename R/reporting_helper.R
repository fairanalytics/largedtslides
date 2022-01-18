#' Generate a report for large dataset using multiple slides
#' @author Fair Analytics
#' @description t.b.d
#' @param raw_data  the large dataset to use to generate the slides
#' @param chunk_size the regular size of subset in each slide
#' @param report_author The author of the report
#' @export
fair_generate_report <- function(raw_data = NULL, chunk_size = 10,report_author=  "Fair Analytics"){
  #split dataset
  nr <- nrow(raw_data)
  dt_chunks <- split(raw_data, rep(1:ceiling(nr/chunk_size), each=chunk_size, length.out=nr))

  # create slides with larger datasets


  # load the templates
  rmd_files <- c("dt_slide_main.rmd")
  rmd_files_package  <- system.file(rmd_files, package = "largedtslides")
  dir.create("./reporting")
  file.copy(from = rmd_files_package,to = paste0("./reporting/",rmd_files),overwrite = TRUE)
  rmd_template    <- heddlr::import_draft("dt_slide" =  "./reporting/dt_slide_main.rmd")

  # create yaml header

  dash_aqerruy <- list()
  dash_aqerruy$title <- "Large dataset report"
  dash_aqerruy$author <- report_author
  dash_aqerruy$date <- paste(Sys.time())
  dash_aqerruy$output <- list("xaringan::moon_reader" = list("lib_dir" = "libs"),
                              "yolo" = TRUE)
  dash_aqerruy$params <- list("large_dt" = "NA")
  dash_aqerruy_yml <- heddlr::create_yaml_header(dash_aqerruy)




  # create body based on chunk template


  dashboard_body <- names(dt_chunks)%>%purrr::map(.x = ., ~heddlr::heddle(data = .x,rmd_template$dt_slide,"DT_CHUNK") )

  # dashboard_body <- heddlr::make_template(Saldae_rmd$navbar_menu, dashboard_body)


  main_report_file <- "./slide_main_report.Rmd"

  heddlr::make_template(dash_aqerruy_yml, dashboard_body) %>%
    heddlr::export_template(main_report_file)

  # generate report

  #----- render and generate report
  output <- rmarkdown::render(input                  =  main_report_file,
                              # output_file           =  "./reporting",
                              params                 =  heddlr::provide_parameters(
                                large_dt             = dt_chunks
                              ))

}

