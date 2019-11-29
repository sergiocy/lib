
s3_bucket_content <- aws.s3::get_bucket(bucket = BUCKET, prefix = paste0(PREFIX_S3_INPUT, "/train/route/full/"))
s3_folders_content <- sapply(1:length(s3_bucket_content), function(r){ s3_bucket_content[r]$Contents$Key })
s3_folders_dates <- as.Date( sapply(1:length(s3_folders_content), function(r){ path <- s3_folders_content[r]
                                                                                split_path <- strsplit(path, "/")[[1]]
                                                                                element_date <- split_path[length(split_path) - 1]
                                                                                dt <- strsplit(element_date, "=")[[1]]
                                                                                return (dt[2])}) )

lst_data <- list()
for(dt_iter in 1:(length(s3_folders_dates))){ 
  dt <- s3_folders_dates[dt_iter]
  system(paste0("s3cmd get ", PATH_S3_INPUT, "/train/route/full/dt=", dt, "/analytic_dataset_final.csv.gz"))
  system(paste0("gunzip analytic_dataset_final.csv.gz"))
  data <- data.table::fread(file=paste0(wd, "/analytic_dataset_final.csv"), sep="|", header=TRUE)
  system(paste0("rm analytic_dataset_final.csv"))
  
  data$dt_execution <- dt
  
  if(nrow(data) > 0){
    print(dim(data))
    lst_data <- c(lst_data, list(data))
  }
}

sapply(1:length(lst_data), function(i){
                                        print(dim(lst_data[[i]]))
                                      })
data_route_full <- rbindlist(lst_data)

head(data_route_full)
dim(data_route_full)