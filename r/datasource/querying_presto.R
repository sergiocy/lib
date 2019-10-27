
#'
#'
#' A function to querying Presto
#'
#' @param qry query to launch
#' @keywords query presto
#' @export
#' @examples
#' queryingSource()
#' 
#' 

queryingSource <- function(qry){
    
    print("Running Presto-Cli...")
    
    system(paste0("echo \"",qry,"\" > presto_query1.txt"))
    system(paste0("time presto-cli --catalog hive --schema revenue -f presto_query1.txt --output-format TSV | tr '\t' '|'  > ",direct, "/query_res_elas1.txt"))
    
    library("data.table")
    qry_resultset <- fread( paste0(direct,"/query_res_elas1.txt"),sep = "|", header = FALSE)
    
    #head(qry_resultset)
    
    return(as.data.frame(qry_resultset))
}

#### TESTING ####
# datos <- queryingSource(paste0("select * from revenue.ds_anomaly_detection_flight;"))