
#'
#'
#' A function to compare strings (exists or not) between two vectors of strings
#'
#' test if exist string in another vector strings
#' Use case: compare headers of dataframes to get if variables are the same
#' @param searched vector with words that we want to search in "searching_in" parameter
#' @param searching_in vector where we want to search words in "searched" parameter
#' @keywords match strings
#' @export
#' @examples
#' matchingStringVectors()
#' 
#' 

matchingStringVectors <- function(searched, searching_in){
    o <- data.frame(out = NULL, word = NULL)
    for(i in 1:length(searched)) {
        # i <- 2
        ou <- match(searched[i], searching_in) 
        r <- data.frame(out = ou, word = searched[i])
        o <- rbind(o, r)
    }
    return(o)
}


#### TESTING ####
# test <- data.frame(y = c(1,2,3), x = c(4,5,6), z = c(7,8,9))
# varsneed <- c("x", "y", "t")
# matchingStringVectors(varsneed, names(test))