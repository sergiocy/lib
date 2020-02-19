

##########################################################
############ functions for ROC computing ############ 

ROCInfo <- function( data, predict, actual, cost.fp=100, cost.fn=100 )
{
    # calculate the values using the ROCR library
    # true positive, false postive 
    pred <- prediction( data[[predict]], data[[actual]] )
    perf <- performance( pred, "tpr", "fpr" )
    roc_dt <- data.frame( fpr = perf@x.values[[1]], tpr = perf@y.values[[1]] )
    
    # cost with the specified false positive and false negative cost 
    # false postive rate * number of negative instances * false positive cost + 
    # false negative rate * number of positive instances * false negative cost
    cost <- perf@x.values[[1]] * cost.fp * sum( data[[actual]] == 0 ) + 
        ( 1 - perf@y.values[[1]] ) * cost.fn * sum( data[[actual]] == 1 )

    
    ####
    #### ...we include distance to (0,1) point in ROC-space (fpr vs tpr)
    # roc_dt$dist <- sqrt( (roc_dt$fpr^2) + (1 - roc_dt$tpr)^2)
    # roc_dt$sens <- roc_dt$tpr
    # roc_dt$spec <- 1 - roc_dt$fpr
    # roc_dt$youden <- roc_dt$sens + roc_dt$spec - 1
    # roc_dt$cutoff <- pred@cutoffs[[1]]
    # 
    # cutoff_dist <- roc_dt[ which.min(roc_dt$dist) , ]$cutoff 
    # cutoff_youden <- roc_dt[ which.max(roc_dt$youden) , ]$cutoff 
    ####
    ####
    
    cost_dt <- data.frame( cutoff = pred@cutoffs[[1]], cost = cost )
    
    

    
    # optimal cutoff value, and the corresponding true positive and false positive rate
    best_index  <- which.min(cost)
    best_cost   <- cost_dt[ best_index, "cost" ]
    best_tpr    <- roc_dt[ best_index, "tpr" ]
    best_fpr    <- roc_dt[ best_index, "fpr" ]
    best_cutoff <- pred@cutoffs[[1]][ best_index ]
    
    # area under the curve
    auc <- performance( pred, "auc" )@y.values[[1]]
    
    # normalize the cost to assign colors to 1
    normalize <- function(v) ( v - min(v) ) / diff( range(v) )
    
    # create color from a palette to assign to the 100 generated threshold between 0 ~ 1
    # then normalize each cost and assign colors to it, the higher the blacker
    # don't times it by 100, there will be 0 in the vector
    col_ramp <- colorRampPalette( c( "green", "orange", "red", "black" ) )(100)   
    col_by_cost <- col_ramp[ ceiling( normalize(cost) * 99 ) + 1 ]
    
    roc_plot <- ggplot( roc_dt, aes( fpr, tpr ) ) + 
        geom_line( color = rgb( 0, 0, 1, alpha = 0.3 ) ) +
        geom_point( color = col_by_cost, size = 4, alpha = 0.2 ) + 
        geom_segment( aes( x = 0, y = 0, xend = 1, yend = 1 ), alpha = 0.8, color = "royalblue" ) + 
        labs( title = "ROC", x = "False Postive Rate", y = "True Positive Rate" ) +
        geom_hline( yintercept = best_tpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" ) +
        geom_vline( xintercept = best_fpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" )				
    
    cost_plot <- ggplot( cost_dt, aes( cutoff, cost ) ) +
        geom_line( color = "blue", alpha = 0.5 ) +
        geom_point( color = col_by_cost, size = 4, alpha = 0.5 ) +
        ggtitle( "Cost" ) +
        scale_y_continuous( labels = comma ) +
        geom_vline( xintercept = best_cutoff, alpha = 0.8, linetype = "dashed", color = "steelblue4" )	
    
    # the main title for the two arranged plot
    sub_title <- sprintf( "Cutoff at %.2f, Total Cost = %.2f, AUC = %.3f", 
                          best_cutoff, best_cost, auc )
    
    
    
    # arranged into a side by side plot
    #plot <- arrangeGrob( roc_plot, cost_plot, ncol = 2, 
    #                     top = textGrob( sub_title, gp = gpar( fontsize = 16, fontface = "bold" ) ) )
    
    
    return( list( #plot 		  = plot, 
        plot 		  = NULL, 
        cutoff 	  = best_cutoff, 
        totalcost   = best_cost, 
        auc         = auc,
        sensitivity = best_tpr, 
        specificity = 1 - best_fpr ) )
}

ConfusionMatrixInfo <- function( data, predict, actual, cutoff )
{	
    # extract the column ;
    # relevel making 1 appears on the more commonly seen position in 
    # a two by two confusion matrix	
    predict <- data[[predict]]
    actual  <- relevel( as.factor( data[[actual]] ), "1" )
    
    result <- data.table( actual = actual, predict = predict )
    
    # caculating each pred falls into which category for the confusion matrix
    result[ , type := ifelse( predict >= cutoff & actual == 1, "TP",
                              ifelse( predict >= cutoff & actual == 0, "FP", 
                                      ifelse( predict <  cutoff & actual == 1, "FN", "TN" ) ) ) %>% as.factor() ]
    
    # jittering : can spread the points along the x axis 
    plot <- ggplot( result, aes( actual, predict, color = type ) ) + 
        geom_violin( fill = "white", color = NA ) +
        geom_jitter( shape = 1 ) + 
        geom_hline( yintercept = cutoff, color = "blue", alpha = 0.6 ) + 
        scale_y_continuous( limits = c( 0, 1 ) ) + 
        scale_color_discrete( breaks = c( "TP", "FN", "FP", "TN" ) ) + # ordering of the legend 
        guides( col = guide_legend( nrow = 2 ) ) + # adjust the legend to have two rows  
        ggtitle( sprintf( "Confusion Matrix with Cutoff at %.2f", cutoff ) )
    
    return( list( data = result, plot = plot ) )
}

FScore <- function(true, predicted)
{
    
    require(ROCR)
    require(data.table)
    
    pred <- prediction( predicted, true )
    perf <- performance( pred, "tpr", "fpr" )
    
    cost <- perf@x.values[[1]] * 100 * sum( true == 0 ) + 
        ( 1 - perf@y.values[[1]] ) * 100 * sum( true == 1 )
    
    
    cutoff <- pred@cutoffs[[1]][which.min(cost)]
    
    result <- data.table( actual = true, predict = predicted )
    
    result[ , type := ifelse( predict >= cutoff & actual == 1, "TP",
                              ifelse( predict >= cutoff & actual == 0, "FP", 
                                      ifelse( predict <  cutoff & actual == 1, "FN", "TN" ) ) ) %>% as.factor() ]
    
    cmT <- table(result$type)
    precT <- cmT["TP"]/(cmT["TP"] + cmT["FP"])
    recallT <- cmT["TP"]/(cmT["TP"] + cmT["FN"])
    fscoreT <- 2/(1/precT + 1/recallT)
    
    return (as.numeric(fscoreT))
    
}

calcMetrics <- function(data)
{
    
    cm <- table(data$type)
    precision <- as.numeric(cm["TP"]/(cm["TP"] + cm["FP"]))
    recall <- as.numeric(cm["TP"]/(cm["TP"] + cm["FN"]))
    
    return (list(
        cm=cm,
        precision=precision,
        recall=recall,
        fscore=as.numeric( 2/(1/precision + 1/recall))  
    ))
    
}




ROCInfo2 <- function( data, predict, actual, cost.fp=100, cost.fn=100, threshold.prec = NULL )
{
  # calculate the values using the ROCR library
  # true positive, false postive 
  pred <- prediction( data[[predict]], data[[actual]] )
  perf <- performance( pred, "tpr", "fpr")
  perf2 <- performance( pred, "tpr", "prec")
  roc_dt <- data.frame( fpr = perf@x.values[[1]], tpr = perf@y.values[[1]], prec = perf2@x.values[[1]], cutoff = pred@cutoffs[[1]] )
  
  # cost with the specified false positive and false negative cost 
  # false postive rate * number of negative instances * false positive cost + 
  # false negative rate * number of positive instances * false negative cost
  cost <- perf@x.values[[1]] * cost.fp * sum( data[[actual]] == 0 ) + 
    ( 1 - perf@y.values[[1]] ) * cost.fn * sum( data[[actual]] == 1 )
  
  #cost_dt <- data.frame( cutoff = pred@cutoffs[[1]], cost = cost)
  roc_dt$cost <- cost
  
  
  
  # optimal cutoff value, and the corresponding true positive and false positive rate
  if( is.null(threshold.prec) ){  
    best_index  <- which.min(cost)
  }else{
    #### ...using threshold...
    # best_index <- rownames( roc_dt[ which.min( roc_dt[roc_dt$prec > threshold.prec, ]$prec  ), ] )
    
    #### ...tpr minimizing...
    # best_index <- rownames( roc_dt[ which.min( roc_dt[roc_dt$tpr > 0 & roc_dt$fpr > 0 & roc_dt$tpr < 1, ]$tpr ), ] )
    
    #### ...using threshold in elbow ROC...
    best_index <- rownames( roc_dt[ which.min( roc_dt[roc_dt$tpr > 0 & roc_dt$fpr > 0 & roc_dt$tpr < 1 & roc_dt$prec > threshold.prec, ]$prec ), ] )
  }
  
  
  #best_cost   <- cost_dt[ best_index, "cost" ]
  best_cost   <- roc_dt[ best_index, "cost" ]
  best_tpr    <- roc_dt[ best_index, "tpr" ]
  best_fpr    <- roc_dt[ best_index, "fpr" ]
  best_prec <- roc_dt[ best_index, "prec"  ]
  #best_cutoff <- pred@cutoffs[[1]][ best_index ]
  best_cutoff <- roc_dt[ best_index, "cutoff" ]
  
  # area under the curve
  auc <- performance( pred, "auc" )@y.values[[1]]
  
  # normalize the cost to assign colors to 1
  normalize <- function(v) ( v - min(v) ) / diff( range(v) )
  
  # create color from a palette to assign to the 100 generated threshold between 0 ~ 1
  # then normalize each cost and assign colors to it, the higher the blacker
  # don't times it by 100, there will be 0 in the vector
  col_ramp <- colorRampPalette( c( "green", "orange", "red", "black" ) )(100)   
  col_by_cost <- col_ramp[ ceiling( normalize(cost) * 99 ) + 1 ]
  
  roc_plot <- ggplot( roc_dt, aes( fpr, tpr ) ) + 
    geom_line( color = rgb( 0, 0, 1, alpha = 0.3 ) ) +
    geom_point( color = col_by_cost, size = 4, alpha = 0.2 ) + 
    geom_segment( aes( x = 0, y = 0, xend = 1, yend = 1 ), alpha = 0.8, color = "royalblue" ) + 
    labs( title = "ROC", x = "False Postive Rate", y = "True Positive Rate" ) +
    geom_hline( yintercept = best_tpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" ) +
    geom_vline( xintercept = best_fpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" )				
  
  cost_plot <- ggplot( cost_dt, aes( cutoff, cost ) ) +
    geom_line( color = "blue", alpha = 0.5 ) +
    geom_point( color = col_by_cost, size = 4, alpha = 0.5 ) +
    ggtitle( "Cost" ) +
    scale_y_continuous( labels = comma ) +
    geom_vline( xintercept = best_cutoff, alpha = 0.8, linetype = "dashed", color = "steelblue4" )	
  
  # the main title for the two arranged plot
  sub_title <- sprintf( "Cutoff at %.2f, Total Cost = %.2f, AUC = %.3f", 
                        best_cutoff, best_cost, auc )
  
  
  
  # arranged into a side by side plot
  #plot <- arrangeGrob( roc_plot, cost_plot, ncol = 2, 
  #                     top = textGrob( sub_title, gp = gpar( fontsize = 16, fontface = "bold" ) ) )
  
  
  return( list( #plot 		  = plot, 
    plot 		  = NULL, 
    cutoff 	  = best_cutoff, 
    totalcost   = best_cost, 
    auc         = auc,
    sensitivity = best_tpr, 
    specificity = 1 - best_fpr ) )
}



