

# pkg <- c("dplyr","reshape2","date", "sqldf",              
#          "zoo","lattice","data.table","magrittr", "readr","xtable","plyr","devtools", 
#          "caret", "randomForest", "purrrlyr", "stringi", "dplyr",             
#          "devtools", "apcluster","RRF","corrplot","randomForestExplainer","miscTools")
# 
# lib_path <- "/usr/lib" #### this is the path??
# repos_url <- "http://cran.rstudio.com/"
# .libPaths(lib_path)



####
#### ...function to install packages...
InstallLoadPackages <- function(pkg, repos_url, lib_path){
  new.pkg <- pkg[!(pkg %in% installed.packages()[,"Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, repos = repos_url, lib = lib_path, dependencies = TRUE)
  #sapply(pkg, require, character.only = TRUE)
  print(" Packages were installed!")
}

#InstallLoadPackages(pkg)