


# pkg <- c("dplyr","reshape2","date", "sqldf",              
#          "zoo","lattice","data.table","magrittr", "readr","xtable","plyr","devtools", 
#          "caret", "randomForest", "purrrlyr", "stringi", "dplyr",             
#          "devtools", "apcluster","RRF","corrplot","randomForestExplainer","miscTools")
# 
# lib_path <- "/usr/lib" #### this is the path??
# repos_url <- "http://cran.rstudio.com/"
# .libPaths(lib_path)


load_packages <- function(pkg){
    sapply(pkg, require, character.only = TRUE)
}