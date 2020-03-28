
#'
#'
#' A function to querying Redshift
#'
#' @param qry vector with words that we want to search in "searching_in" parameter
#' @param ... credentials
#' @keywords query redshift
#' @export
#' @examples
#' matchingStringVectors()
#' 
#' 


queryingRedshift <- function(qry, dbname, host, port, user, password){
    drv<-RPostgreSQL::PostgreSQL()
    con<-dbConnect(drv, 
                   dbname=dbname, 
                   host=host,
                   port=port, 
                   user=user, 
                   password=password) 
    datos<-dbGetQuery(con, qry)
    dbDisconnect(con)
    rm(qry)
    
    return(datos)
}

#### TESTING ####
#sentencia<-paste0("SELECT * FROM ",RSDetect ," where dt_fecha='",F_eval,"'")