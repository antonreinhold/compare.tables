## function to compare two tables in R
## version 0.2
## auth: Anton Reinhold
## date: 2025-12-01

compare_tables <- function(table1, table2, ID_variable) {

  # check data.frame 
  if(! (is.data.frame(table1) & is.data.frame(table2))) {
    stop(message = "error: supplied tables do not fail condition is.data.frame()")
  }
  
  # check ID variable 
  if(! (ID_variable %in% names(table1) & ID_variable %in% names(table2))) {
    stop(message = "error: ID variable does not match supplied tables")
  }
  
  # check supplied variables in tables (length)
  if(length(names(table1)) != length(names(table2))) {
    stop(message = "error: tables have different variable count. Compare 'names(table)'")
  }
  
  # check supplied variables in tables (names)
  if(!all(names(table1) == names(table2))) {
        print("Unmatched variable names")
        print(c("table1: ", names(table1)[!(names(table1) == names(table2))]))  
        print(c("table2: ", names(table2)[!(names(table1) == names(table2))]))
        stop("supplied tables have different variable names. If you wish to continue, set 'continue_if_diff_names = TRUE'")
  }
  
  # check if supplied data frames have different observations
  if(nrow(table1) != nrow(table2)) {
    warning("supplied tables have differences in nrow()") 
  }
  
  # main function 
  merged <- merge(table1, table2, by = ID_variable, suffixes = c("_A", "_B"))
  result <- as.data.frame(x = merged[,ID_variable])
  names(result) <- ID_variable 
  final <- result
  var_names <- setdiff(names(table1), ID_variable)
  
  for(var in var_names) {
    
    col1 <- merged[[paste0(var, "_A")]]
    col2 <- merged[[paste0(var, "_B")]]
    
    # if both values are NA -> NA
    result <- ifelse(is.na(col1) & is.na(col2), NA,
                # of only one is NA -> -88 
                ifelse(xor(is.na(col1), is.na(col2)), -88,
                   # if the values don't match -> -99
                   ifelse(col1 == col2, col1, -99
                          )
                       ) 
                    )
    
# creating the final table
    final[[var]] <- result
  }
  
  return(final) 
  
}